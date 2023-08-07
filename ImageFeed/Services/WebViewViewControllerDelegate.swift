//
//  WebViewViewControllerDelegate.swift
//  ImageFeed
//
//  Created by Iurii on 06.08.23.
//

import Foundation

protocol WebViewViewControllerDelegate: AnyObject {
    func webViewViewController(_ vc: WebViewViewController, didAuthenticateWithCode code: String)
    func webViewViewControllerDidCancel(_ vc: WebViewViewController)
}
