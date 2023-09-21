//
//  ProfilePresenterSpy.swift
//  ImageFeed
//
//  Created by Iurii on 19.09.23.
//

import ImageFeed
import Foundation

final class ProfilePresenterSpy: ProfilePresenterProtocol {
    var viewDidLoadCalled: Bool = false
    var view: ProfileViewControllerProtocol?
    
    func viewDidLoad() {
        viewDidLoadCalled = true
    }
    
    func exitProfile() { }
    
    func updateAvatar() { }
}
