//
//  AlertModel.swift
//  ImageFeed
//
//  Created by Iurii on 24.08.23.
//

import UIKit

struct AlertModel {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)
}
