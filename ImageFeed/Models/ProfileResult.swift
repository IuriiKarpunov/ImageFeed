//
//  ProfileResult.swift
//  ImageFeed
//
//  Created by Iurii on 18.08.23.
//

import Foundation

struct ProfileResult: Codable {
    let username: String
    let firstName: String
    let lastName: String?
    let bio: String?
}
