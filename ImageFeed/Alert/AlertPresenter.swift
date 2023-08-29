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
    
    func show(_ result: AlertModel) {
        let alert = UIAlertController(title: result.title,
                                      message: result.message,
                                      preferredStyle: .alert)
        let action = UIAlertAction(title: result.buttonText, style: .default) { _ in
            result.completion?()
        }
        
        alert.addAction(action)
        viewController?.presentedViewController?.present(alert, animated: true, completion: nil)
    }
}
