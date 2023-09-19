//
//  ProfileViewTests.swift
//  ImageFeed
//
//  Created by Iurii on 19.09.23.
//

@testable import ImageFeed
import XCTest

final class ProfileViewTests: XCTestCase {
    func testViewControllerCallsViewDidLoad() {
        //given
        let profileViewController = ProfileViewController()
        let profileViewPresenter = ProfilePresenterSpy()
        profileViewController.configure(profileViewPresenter)
        
        //when
        _ = profileViewController.view
        
        //then
        XCTAssertTrue(profileViewPresenter.viewDidLoadCalled)
    }
}
