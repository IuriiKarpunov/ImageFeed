//
//  AlertPresenterProtocol.swift
//  ImageFeed
//
//  Created by Iurii on 24.08.23.
//

import Foundation

protocol AlertPresenterProtocol: AnyObject {
    func show(_ result: AlertModelOneButton)
    func showTwoButton(_ result: AlertModelTwoButton)
}
