//
//  ImagesListService.swift
//  ImageFeed
//
//  Created by Iurii on 29.08.23.
//

import Foundation

final class ImagesListService {
    
    // MARK: - Constants
    
    static let shared = ImagesListService()
    private let urlSession = URLSession.shared
    private let token = OAuth2TokenStorage().token
    static let didChangeNotification = Notification.Name(rawValue: "ImagesListServiceDidChange")
    
    // MARK: - Private Properties
    
    private (set) var photos: [Photo] = []
    private var lastLoadedPage: Int?
    private var task: URLSessionTask?
    private var likeTask: URLSessionTask?
    
    // MARK: - Public Methods
    
    func fetchPhotosNextPage() {
        let nextPage = nextPageNumber()
        
        assert(Thread.isMainThread)
        guard task == nil else { return }
        task?.cancel()
        
        guard let token = token else { return }
        var requestPhotos: URLRequest? = photosRequest(page: nextPage, perPage: 10)
        requestPhotos?.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let requestPhotos = requestPhotos else { return }
        let task = urlSession.objectTask(for: requestPhotos) { [weak self] (result: Result<[PhotoResult], Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let photoResults):
                        for photoResult in photoResults {
                            self.photos.append(self.convert(photoResult))
                    }
                    self.lastLoadedPage = nextPage
                    NotificationCenter.default
                        .post(
                            name: ImagesListService.didChangeNotification,
                            object: self,
                            userInfo: ["Photos": self.photos]
                        )
                    
                    self.task = nil
                case .failure(let error):
                    assertionFailure("WARNING loading photo \(error)")
                }
            }
        }
        self.task = task
        task.resume()
    }
    
    func changeLike(photoId: String, isLike: Bool, _ completion: @escaping (Result<Bool, Error>) -> Void) {
        
        assert(Thread.isMainThread)
        guard likeTask == nil else { return }
        likeTask?.cancel()
        
        guard let token = token else { return }
        var requestLike: URLRequest? = isLike ? unlikeRequest(photoId: photoId) : likeRequest(photoId: photoId)
        requestLike?.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let requestLike = requestLike else { return }
        let likeTask = urlSession.objectTask(for: requestLike) { [weak self] (result: Result<PhotoLikeResult, Error>) in
            DispatchQueue.main.async {
                guard let self = self else { return }
                switch result {
                case .success(let body):
                    let likedByUser = body.photo?.likedByUser ?? false
                    if let index = self.photos.firstIndex(where: { $0.id == photoId}) {
                        let photo = self.photos[index]
                        let newPhoto = Photo(
                            id: photo.id,
                            size: photo.size,
                            createdAt: photo.createdAt,
                            welcomeDescription: photo.welcomeDescription,
                            thumbImageURL: photo.thumbImageURL,
                            largeImageURL: photo.largeImageURL,
                            isLiked: likedByUser
                        )
                        self.photos[index] = newPhoto
                    }
                    completion(.success(likedByUser))
                    self.likeTask = nil
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        self.likeTask = likeTask
        likeTask.resume()
    }
    
    func cleanImagesList() {
        photos = []
        lastLoadedPage = nil
        task = nil
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
    
    func likeRequest(photoId: String) -> URLRequest {
        URLRequest.makeHTTPRequest(
            path: "/photos/\(photoId)/like",
            httpMethod: "POST"
        )
    }
    
    func unlikeRequest(photoId: String) -> URLRequest {
        URLRequest.makeHTTPRequest(
            path: "/photos/\(photoId)/like",
            httpMethod: "DELETE"
        )
    }
    
    func nextPageNumber() -> Int {
        guard let lastLoadedPage = lastLoadedPage else { return 1 }
        return lastLoadedPage + 1
    }
    
    func convert(_ photoResult: PhotoResult) -> Photo {
        Photo(
            id: photoResult.id,
            size: CGSize(width: photoResult.width, height: photoResult.height),
            createdAt: photoResult.createdAt?.dateTimeString,
            welcomeDescription: photoResult.description ?? "",
            thumbImageURL: photoResult.urls.thumb,
            largeImageURL: photoResult.urls.full,
            isLiked: photoResult.likedByUser
        )
    }
}
