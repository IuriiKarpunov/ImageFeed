//
//  AuthViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Iurii on 07.08.23.
//

import Foundation

protocol AuthViewControllerDelegate: AnyObject {
    func authViewController(_ vc: AuthViewController, didAuthenticateWithCode code: String)
}
