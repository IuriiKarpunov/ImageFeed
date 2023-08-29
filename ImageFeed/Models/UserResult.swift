//
//  UserResult.swift
//  ImageFeed
//
//  Created by Iurii on 21.08.23.
//

import Foundation

struct UserResult: Codable {
    let profileImage: ProfileImage?
}

struct ProfileImage: Codable {
    let small: String?
    let medium: String?
    let large: String?
}
