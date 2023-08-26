//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Iurii on 06.08.23.
//

import Foundation
import SwiftKeychainWrapper

class OAuth2TokenStorage {
    
    private enum Keys: String {
        case token
    }
    
    private let keychainWrapper = KeychainWrapper.standard
    
    var token: String? {
            get {
                keychainWrapper.string(forKey: Keys.token.rawValue)
            }
            set {
                guard let newValue = newValue else { return }
                
                let isSuccess = keychainWrapper.set(newValue, forKey: Keys.token.rawValue)
                guard isSuccess else {
                    return
                }
            }
        }
    }
