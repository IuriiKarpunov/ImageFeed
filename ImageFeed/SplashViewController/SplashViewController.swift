//
//  SplashViewController.swift
//  ImageFeed
//
//  Created by Iurii on 07.08.23.
//

import UIKit
import ProgressHUD

final class SplashViewController: UIViewController  {
    
    // MARK: - Private Constants
    
    private let showAuthenticationScreenSegueIdentifier = "ShowAuthenticationScreen"
    private let oauth2TokenStorage = OAuth2TokenStorage()
    private let oauth2Service = OAuth2Service()
    private let profileService = ProfileService.shared
    private let profileImageService = ProfileImageService.shared
    
    // MARK: - Private Properties
    
    private var splashScreenImageView: UIImageView!
    private var alertPresenter: AlertPresenterProtocol?
    private var authViewController: AuthViewController?
    
    // MARK: - UIStatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        alertPresenter = AlertPresenter(viewController: self)
        
        if oauth2TokenStorage.token != nil {
            fetchProfile(token: oauth2TokenStorage.token!)
        } else {
            switchToAuthViewController()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .ypBlack
        creatSplashScreenImageView()
    }
    
    // MARK: - Private Methods
    
    private func switchToTabBarController() {
        guard let window = UIApplication.shared.windows.first else {
            fatalError("Invalid Configuration")
        }
        let tabBarController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(identifier: "TabBarViewController")
        window.rootViewController = tabBarController
    }
    
    private func showAlertNetworkError() {
        let model = AlertModel(
            title: "Что-то пошло не так(",
            message: "Не удалось войти в систему",
            buttonText: "ОК",
            completion: { [weak self] in
                guard let self = self else { return }
            })
        alertPresenter?.show(model)
    }
    
    //MARK: - Creat View
    
    private func creatSplashScreenImageView() {
        let splashScreenImageView = UIImageView(image: UIImage(named: "Splash_screen.png"))
        splashScreenImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(splashScreenImageView)
        NSLayoutConstraint.activate([
            splashScreenImageView.heightAnchor.constraint(equalToConstant: 75),
            splashScreenImageView.widthAnchor.constraint(equalToConstant: 72),
            splashScreenImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            splashScreenImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        self.splashScreenImageView = splashScreenImageView
    }
}

//MARK: - AuthViewControllerDelegate

extension SplashViewController: AuthViewControllerDelegate {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String) {
        UIBlockingProgressHUD.show()
        dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            self.fetchOAuthToken(code)
        }
    }
    
    private func switchToAuthViewController() {
        let authViewController = UIStoryboard(name: "Main", bundle: .main)
            .instantiateViewController(identifier: "AuthViewController") as? AuthViewController
        authViewController?.delegate = self
        guard let authViewController = authViewController else { return }
        authViewController.modalPresentationStyle = .fullScreen
        present(authViewController, animated: true)
    }
    
    private func fetchOAuthToken(_ code: String) {
        oauth2Service.fetchAuthToken(code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let token):
                self.fetchProfile(token: token)
                UIBlockingProgressHUD.dismiss()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                showAlertNetworkError()
                break
            }
        }
    }
    
    private func fetchProfile(token: String) {
        profileService.fetchProfile(token) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                profileImageService.fetchProfileImageURL(token: token, username: data.username) { _ in }
                UIBlockingProgressHUD.dismiss()
                self.switchToTabBarController()
            case .failure:
                UIBlockingProgressHUD.dismiss()
                showAlertNetworkError()
                break
            }
        }
    }
}
