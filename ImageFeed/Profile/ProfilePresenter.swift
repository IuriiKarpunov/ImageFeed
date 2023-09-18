//
//  ProfilePresenter.swift
//  ImageFeed
//
//  Created by Iurii on 14.09.23.
//

import UIKit

protocol ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol? { get set }
    func viewDidLoad()
    func exitProfile()
    func updateAvatar()
}

final class ProfilePresenter: ProfilePresenterProtocol {
    var view: ProfileViewControllerProtocol?
    
    // MARK: - Private Constants
    
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    private let imagesListService = ImagesListService.shared
    
    func viewDidLoad() {
        view?.updateProfileDetails(profile: profileService.profile)
    }
    
    func exitProfile() {
        OAuth2TokenStorage().token = nil
        WebViewViewController.clean()
        cleanService()
        
        guard let window = UIApplication.shared.windows.first else {
            return assertionFailure("Invalid Configuration")
        }
        window.rootViewController = SplashViewController()
    }
    
    private func cleanService() {
        profileService.cleanProfile()
        profileImageService.cleanProfileImageURL()
        imagesListService.cleanImagesList()
    }
    
    func updateAvatar() {
        guard
            let profileImageURL = profileImageService.avatarURL,
            let imageURL = URL(string: profileImageURL)
        else { return }
        view?.updateAvatar(imageURL: imageURL)
    }
}
