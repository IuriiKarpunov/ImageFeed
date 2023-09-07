//
//  AlertPresenter.swift
//  ImageFeed
//
//  Created by Iurii on 24.08.23.
//

import UIKit

final class AlertPresenter: AlertPresenterProtocol {
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    func showSplashView(_ result: AlertModelOneButton) {
        let alert = UIAlertController(title: result.title,
                                      message: result.message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            result.completion?()
        }
        
        alert.addAction(action)
        viewController?.presentedViewController?.present(alert, animated: true, completion: nil)
    }
    
    func showOneButton(_ result: AlertModelOneButton) {
        let alert = UIAlertController(title: result.title,
                                      message: result.message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            result.completion?()
        }
        
        alert.addAction(action)
        viewController?.present(alert, animated: true, completion: nil)
    }
    
    func showTwoButton(_ result: AlertModelTwoButton) {
        let alertTwoButton = UIAlertController(title: result.title,
                                               message: result.message,
                                               preferredStyle: .alert)
        let actionOne = UIAlertAction(title: result.buttonTextOne, style: .default) { _ in
            result.completionOne?()
        }
        let actionTwo = UIAlertAction(title: result.buttonTextTwo, style: .default) { _ in
            result.completionTwo?()
        }
        
        alertTwoButton.addAction(actionOne)
        alertTwoButton.addAction(actionTwo)
        viewController?.present(alertTwoButton, animated: true, completion: nil)
    }
}
