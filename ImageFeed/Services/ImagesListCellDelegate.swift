//
//  ImagesListCellDelegate.swift
//  ImageFeed
//
//  Created by Iurii on 05.09.23.
//

import Foundation

protocol ImagesListCellDelegate: AnyObject {
    func imageListCellDidTapLike(_ cell: ImagesListCell)
}
