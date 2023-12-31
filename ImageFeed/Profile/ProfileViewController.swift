//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Iurii on 13.07.23.
//

import UIKit
import Kingfisher

public protocol ProfileViewControllerProtocol: AnyObject {
    func updateProfileDetails(profile: Profile?)
    func updateAvatar(imageURL: URL)
}

final class ProfileViewController: UIViewController & ProfileViewControllerProtocol {
    
    // MARK: - Subview Properties
    
    private var profileImageServiceObserver: NSObjectProtocol?
    private var alertPresenter: AlertPresenterProtocol?
    private var presenter: ProfilePresenterProtocol?
    
    //MARK: - Layout variables
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "test profile photo.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 35
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Екатерина Новикова"
        label.textColor = .ypWhite
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.accessibilityIdentifier = "nameLabel"
        
        return label
    }()
    
    private let loginLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "@ekaterina_nov"
        label.textColor = .ypGray
        label.font = UIFont.systemFont(ofSize: 13)
        label.accessibilityIdentifier = "loginLabel"
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello, world!"
        label.textColor = .ypWhite
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    private let favoritesLabel: UILabel = {
        let label = UILabel()
        label.text = "Избранное"
        label.textColor = .ypWhite
        label.font = UIFont.boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let noPhotoImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "No Photo.png"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = UIImage(named: "Exit.png")
        button.accessibilityIdentifier = "logoutButton"
        button.setImage(image, for: .normal)
        button.addTarget(
            self,
            action: #selector(didTapLogoutButton),
            for: .touchUpInside
        )
        button.tintColor = .ypRed
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - UIStatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .ypBlack
        addSubViews()
        applyConstraints()
        alertPresenter = AlertPresenter(viewController: self)
        presenter?.viewDidLoad()
    }
    
    // MARK: - Public Methods
    
    func updateProfileDetails(profile: Profile?) {
        guard let profile = profile else {
            return
        }
        nameLabel.text = profile.name
        loginLabel.text = profile.loginName
        descriptionLabel.text = profile.bio
        
        profileImageServiceObserver = NotificationCenter.default
            .addObserver(
                forName: ProfileImageService.didChangeNotification,
                object: nil,
                queue: .main
            ) { [weak self] _ in
                guard let self = self else { return }
                self.presenter?.updateAvatar()
            }
        presenter?.updateAvatar()
    }
    
    func showAlertExitProfile() {
        let model = AlertModelTwoButton(
            title: "Пока, пока!",
            message: "Уверены что хотите выйти?",
            buttonTextOne: "Да",
            buttonTextTwo: "Нет",
            completionOne: { [weak self] in
                guard let self = self else { return }
                presenter?.exitProfile()
            },
            completionTwo: nil
        )
        alertPresenter?.showTwoButton(model)
    }
    
    func configure(_ presenter: ProfilePresenterProtocol) {
        self.presenter = presenter
        self.presenter?.view = self
    }
    
    func updateAvatar(imageURL: URL) {
        let processor = RoundCornerImageProcessor(cornerRadius: 61)
        avatarImageView.kf.indicatorType = .activity
        avatarImageView.kf.setImage(with: imageURL,
                                    placeholder: UIImage(named: "Stub.png"),
                                    options: [.processor(processor)])
    }
    
    // MARK: - IBAction
    
    @objc
    private func didTapLogoutButton() {
        showAlertExitProfile()
    }
    
    // MARK: - Private Methods
    
    private func addSubViews() {
        view.addSubview(avatarImageView)
        view.addSubview(nameLabel)
        view.addSubview(loginLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(favoritesLabel)
        view.addSubview(noPhotoImageView)
        view.addSubview(logoutButton)
    }
    
    private func applyConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.heightAnchor.constraint(equalToConstant: 70),
            avatarImageView.widthAnchor.constraint(equalToConstant: 70),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            nameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            loginLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 8),
            
            favoritesLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            favoritesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 24),
            
            noPhotoImageView.heightAnchor.constraint(equalToConstant: 115),
            noPhotoImageView.widthAnchor.constraint(equalToConstant: 115),
            noPhotoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noPhotoImageView.topAnchor.constraint(equalTo: favoritesLabel.bottomAnchor, constant: 110),
            
            logoutButton.heightAnchor.constraint(equalToConstant: 44),
            logoutButton.widthAnchor.constraint(equalToConstant: 44),
            logoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            logoutButton.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
}
