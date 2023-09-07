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
        let action1 = UIAlertAction(title: result.buttonText, style: .default) { _ in
            result.completion?()
        }
        let action2 = UIAlertAction(title: result.buttonText2, style: .default) { _ in
            result.completion2?()
        }
        
        alertTwoButton.addAction(action1)
        alertTwoButton.addAction(action2)
        viewController?.present(alertTwoButton, animated: true, completion: nil)
    }
}
