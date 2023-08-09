//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Iurii on 06.08.23.
//

import Foundation

struct OAuthTokenResponseBody: Decodable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
}
