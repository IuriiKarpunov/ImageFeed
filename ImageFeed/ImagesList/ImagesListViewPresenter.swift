//
//  ImagesListViewPresenter.swift
//  ImageFeed
//
//  Created by Iurii on 18.09.23.
//

import UIKit

public protocol ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol? { get set }
    func updateTableViewAnimated()
    func fetchPhotosNextPage(indexPath: IndexPath)
    func imageListCellDidTapLike(_ cell: ImagesListCell, indexPath: IndexPath?)
    func getPhotosCount() -> Int
    func getPhoto(indexPath: IndexPath) -> Photo?
    func getCellHeight(indexPath: IndexPath, tableView: UITableView) -> CGFloat
    func getLargeImageURL(indexPath: IndexPath) -> URL?
    func updateImagesListDetails()
}

final class ImagesListViewPresenter: ImagesListViewPresenterProtocol {
    var view: ImagesListViewControllerProtocol?
    private var imagesListService = ImagesListService.shared
    private var photos: [Photo] = []
    
    func getPhotosCount() -> Int {
        return photos.count
    }
    
    func getPhoto(indexPath: IndexPath) -> Photo? {
        return photos[indexPath.row]
    }
    
    func getLargeImageURL(indexPath: IndexPath) -> URL? {
        return URL(string: photos[indexPath.row].largeImageURL)
    }
    
    func updateTableViewAnimated() {
        let oldCount = photos.count
        let newCount = imagesListService.photos.count
        photos = imagesListService.photos
        if oldCount != newCount {
            view?.updateTableViewAnimated(oldCount: oldCount, newCount: newCount)
        }
    }
    
    func fetchPhotosNextPage(indexPath: IndexPath) {
        if indexPath.row + 1 == imagesListService.photos.count {
            imagesListService.fetchPhotosNextPage()
        }
    }
    
    func imageListCellDidTapLike(_ cell: ImagesListCell, indexPath: IndexPath?) {
        guard let indexPath = indexPath else { return }
        let photo = photos[indexPath.row]
        
        UIBlockingProgressHUD.show()
        
        imagesListService.changeLike(
            photoId: photo.id,
            isLike: photo.isLiked
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.photos = self.imagesListService.photos
                cell.setIsLiked(isLiked: self.photos[indexPath.row].isLiked)
            case .failure:
                self.view?.showError()
            }
            do {
                UIBlockingProgressHUD.dismiss()
            }
        }
    }
    
    func getCellHeight(indexPath: IndexPath, tableView: UITableView) -> CGFloat {
        let image = photos[indexPath.row]
        
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
    
    func updateImagesListDetails() {
        imagesListService.fetchPhotosNextPage()
        view?.updateImagesListDetails()
    }
}
