//
//  Photo.swift
//  ImageFeed
//
//  Created by Iurii on 29.08.23.
//

import Foundation

struct Photo {
    let id: String
    let size: CGSize
    let createdAt: Date?
    let welcomeDescription: String?
    let thumbImageURL: String
    let largeImageURL: String
    let isLiked: Bool
} 
