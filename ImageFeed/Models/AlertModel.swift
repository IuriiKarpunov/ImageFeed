//
//  AlertModel.swift
//  ImageFeed
//
//  Created by Iurii on 24.08.23.
//

import UIKit

struct AlertModelOneButton {
    let title: String
    let message: String
    let buttonText: String
    let completion: (() -> Void)?
}

struct AlertModelTwoButton {
    let title: String
    let message: String
    let buttonText: String
    let buttonText2: String
    let completion: (() -> Void)?
    let completion2: (() -> Void)?
}
