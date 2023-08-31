//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Iurii on 29.08.23.
//

import Foundation

final class ImagesListService {
    
    // MARK: - Constants
    
    private let urlSession = URLSession.shared
    private let token = OAuth2TokenStorage().token
    static let DidChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    // MARK: - Private Properties
    
    private (set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private var task: URLSessionTask?
    private var nextPage: Int = 1
    
    func fetchPhotosNextPage() {
        nextPageNumber()
        
        assert(Thread.isMainThread)
        guard task == nil else { return }
        task?.cancel()
        
        guard let token = token else { return }
        var request: URLRequest? = photosRequest(page: nextPage, perPage: 10)
        request?.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let request = request else { return }
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<[PhotoResult], Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let body):
                    body.forEach { photo in
                        self.photos.append(Photo(
                            id: photo.id,
                            size: CGSize(width: photo.width, height: photo.height),
                            createdAt: dateFormatter.date(from: photo.createdAt ?? ""),
                            welcomeDescription: photo.description ?? "",
                            thumbImageURL: photo.urls.thumb,
                            largeImageURL: photo.urls.full,
                            isLiked: photo.likedByUser
                        )
                        )
                    }
                    self.lastLoadedPage = self.nextPage
                    NotificationCenter.default
                        .post(
                            name: ImagesListService.DidChangeNotification,
                            object: self,
                            userInfo: ["Photos": self.photos]
                        )
                   
                case .failure(let error):
                    print("WARNING loading photo \(error)")
                }
            }
        }
        self.task = task
        task.resume()
    }
}

// MARK: - Private Methods

private extension ImagesListService {
    func photosRequest(page: Int, perPage: Int) -> URLRequest {
        URLRequest.makeHTTPRequest(
            path: "/photos?"
            + "page=\(page)"
            + "&&per_page=\(perPage)",
            httpMethod: "GET"
        )
    }
    
    func nextPageNumber() -> Int {
        guard let lastLoadedPage = lastLoadedPage else {
            return nextPage
        }
        nextPage = lastLoadedPage + 1
        return nextPage
    }
}
