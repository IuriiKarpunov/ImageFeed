//
//  ImagesListViewTests.swift
//  ImageFeed
//
//  Created by Iurii on 19.09.23.
//

@testable import ImageFeed
import XCTest

final class ImagesListViewTests: XCTestCase {
    func testImagesListViewControllerCallsViewDidLoad() {
        //given
        let imagesListViewController = ImagesListViewController()
        let imagesListViewPresenter = ImagesListViewPresenterSpy()
        imagesListViewController.configure(imagesListViewPresenter)
        
        //when
        imagesListViewController.updateImagesListDetails()
        
        //then
        XCTAssertTrue(imagesListViewPresenter.updateIsCalled)
    }
}
