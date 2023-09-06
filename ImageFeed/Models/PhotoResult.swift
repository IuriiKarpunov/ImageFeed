//
//  PhotoResult.swift
//  ImageFeed
//
//  Created by Iurii on 30.08.23.
//

import Foundation

struct PhotoResult: Codable {
    let id: String
    let createdAt: String?
    let width: Int
    let height: Int
    let description: String?
    let likedByUser: Bool
    let urls: UrlsResult
}

struct UrlsResult: Codable {
    let full: String
    let thumb: String
}

struct PhotoLikeResult: Codable {
    let photo: PhotoResult?
}
