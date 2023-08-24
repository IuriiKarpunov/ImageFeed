//
//  ProfileService.swift
//  ImageFeed
//
//  Created by Iurii on 18.08.23.
//

import Foundation

final class ProfileService {
    
    private(set) var profile: Profile?
    static let shared = ProfileService()
    private let urlSession = URLSession.shared
    private var task: URLSessionTask?
    
    
    func fetchProfile(_ token: String, completion: @escaping (Result<Profile, Error>) -> Void) {
        assert(Thread.isMainThread)
        if profile != nil { return }
        task?.cancel()
        
        var request: URLRequest? = selfProfileRequest
        request?.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        guard let request = request else {
            return
        }
        
        let task = urlSession.objectTask(for: request) { [weak self] (result: Result<ProfileResult, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let body):
                    let profile = Profile(
                        username: body.username,
                        name: "\(body.firstName) \(body.lastName)",
                        loginName: "@\(body.username)",
                        bio: body.bio
                    )
                    self.profile = profile
                    
                    completion(.success(profile))
                case .failure(let error):
                    completion(.failure(error))
                    self.profile = nil
                }
            }
        }
        self.task = task
        task.resume()
    }
}

extension ProfileService {
    var selfProfileRequest: URLRequest {
        URLRequest.makeHTTPRequest(path: "/me", httpMethod: "GET")
    }
}
