//
//  Constants.swift
//  ImageFeed
//
//  Created by Iurii on 01.08.23.
//

import Foundation

let DefaultBaseURL = URL(string: "https://api.unsplash.com")!

public enum Constants {
    static let accessKey = "2i4FAQbW7fEnniPHAzXFLvqgGZW6_HI8roYeuegoFkk"
    static let secretKey = "UJm2MOuvmrRRNTyfAw6WsUV1TEKKvAx7jh9SWOfmubA"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope: String = "public+read_user+write_likes"
    static let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
}

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let authURLString: String
    let defaultBaseURL: URL
    
    static var standard: AuthConfiguration {
        return AuthConfiguration(accessKey: Constants.accessKey,
                                 secretKey: Constants.secretKey,
                                 redirectURI: Constants.redirectURI,
                                 accessScope: Constants.accessScope,
                                 authURLString: Constants.unsplashAuthorizeURLString,
                                 defaultBaseURL: DefaultBaseURL)
    }
    
    init(
        accessKey: String,
        secretKey: String,
        redirectURI: String,
        accessScope: String,
        authURLString: String,
        defaultBaseURL: URL
    ) {
        self.accessKey = accessKey
        self.secretKey = secretKey
        self.redirectURI = redirectURI
        self.accessScope = accessScope
        self.defaultBaseURL = defaultBaseURL
        self.authURLString = authURLString
    }
}
