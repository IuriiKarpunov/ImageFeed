//
//  AlertPresenterProtocol.swift
//  ImageFeed
//
//  Created by Iurii on 24.08.23.
//

import Foundation

protocol AlertPresenterProtocol: AnyObject {
    func showSplashView(_ result: AlertModelOneButton)
    func showOneButton(_ result: AlertModelOneButton)
    func showTwoButton(_ result: AlertModelTwoButton)
}
