//
//  Constants.swift
//  ImageFeed
//
//  Created by Iurii on 01.08.23.
//

import Foundation

let AccessKey = "2i4FAQbW7fEnniPHAzXFLvqgGZW6_HI8roYeuegoFkk"
let SecretKey = "UJm2MOuvmrRRNTyfAw6WsUV1TEKKvAx7jh9SWOfmubA"
let RedirectURI = "urn:ietf:wg:oauth:2.0:oob"
let AccessScope: String = "public+read_user+write_likes"
let unsplashAuthorizeURLString = "https://unsplash.com/oauth/authorize"
let DefaultBaseURL = URL(string: "https://api.unsplash.com")!

struct AuthConfiguration {
    let accessKey: String
    let secretKey: String
    let redirectURI: String
    let accessScope: String
    let authURLString: String
    let defaultBaseURL: URL
    
    static var standard: AuthConfiguration {
        return AuthConfiguration(accessKey: AccessKey,
                                 secretKey: SecretKey,
                                 redirectURI: RedirectURI,
                                 accessScope: AccessScope,
                                 authURLString: unsplashAuthorizeURLString,
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
