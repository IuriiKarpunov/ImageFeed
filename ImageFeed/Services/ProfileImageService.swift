//
//  ProfileImageService.swift
//  ImageFeed
//
//  Created by Iurii on 21.08.23.
//

import Foundation

final class ProfileImageService {
    
    // MARK: - Constants
    
    static let shared = ProfileImageService()
    private let urlSession = URLSession.shared
    static let DidChangeNotification = Notification.Name(rawValue: "ProfileImageProviderDidChange")
    
    // MARK: - Private Properties
    
    private (set) var avatarURL: String?
    private var task: URLSessionTask?
    
    // MARK: - Public Methods
    
    func fetchProfileImageURL(token: String, username: String, _ completion: @escaping (Result<String, Error>) -> Void) {
        assert(Thread.isMainThread)
        guard avatarURL == nil else { return }
        task?.cancel()
        
        var request: URLRequest? = profileImageURLRequest(username: username)
        request?.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let request = request else {
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<UserResult, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let body):
                    let avatarURL = body.profileImage?.small
                    guard let avatarURL = avatarURL else { return }
                    self.avatarURL = avatarURL
                    completion(.success(avatarURL))
                    NotificationCenter.default
                        .post(
                            name: ProfileImageService.DidChangeNotification,
                            object: self,
                            userInfo: ["URL": avatarURL])
                    
                case .failure(let error):
                    completion(.failure(error))
                    self.avatarURL = nil
                }
            }
        }
        self.task = task
        task.resume()
    }
    
}

extension ProfileImageService {
    func profileImageURLRequest(username: String) -> URLRequest {
        URLRequest.makeHTTPRequest(path: "/users/\(username)", httpMethod: "GET")
    }
}
