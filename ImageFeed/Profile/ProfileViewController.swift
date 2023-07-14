//
//  ProfileViewController.swift
//  ImageFeed
//
//  Created by Iurii on 13.07.23.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var loginNameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var logoutButton: UIButton!
    
    
    @IBAction private func didTapLogoutButton(_ sender: Any) {
    }
}
