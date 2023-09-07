//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Iurii on 02.07.23.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    //MARK: - Variables
    
    weak var delegate: ImagesListCellDelegate?
    static let reuseIdentifier = "ImagesListCell"
    private let imagesListService = ImagesListService.shared
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var linearGradient: UIView!
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        super.prepareForReuse()
        cellImage.kf.cancelDownloadTask()
    }
    
    // MARK: - Public Methods
    
    func configCell(photoURL: String, with indexPath: IndexPath) -> Bool {
        gradientLayer(linearGradient)
        
        var status = false
        guard let imageURL = URL(string: photoURL) else { return status }
        let date = imagesListService.photos[indexPath.row].createdAt
        let placeholder = UIImage(named: "placeholder.png")
        
        cellImage?.kf.indicatorType = .activity
        cellImage?.kf.setImage(
            with: imageURL,
            placeholder: placeholder
        ) { result in
            switch result {
            case .success:
                status = true
            case .failure:
                self.cellImage.image = placeholder
            }
        }
        dateLabel.text = date?.dateTimeString
        return status
    }
    
    func setIsLiked(isLiked: Bool) {
        let likeImage = isLiked ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        likeButton.setImage(likeImage, for: .normal)
    }
    
    // MARK: - IBAction
    
    @IBAction private func likeButtonClicked(_ sender: Any) {
        delegate?.imageListCellDidTapLike(self)
    }
    
    // MARK: - Private Methods
    
    private func gradientLayer(_ view: UIView) {
        let gradientLayer = CAGradientLayer()
        let startColor: UIColor = UIColor(red: 0.26, green: 0.27, blue: 0.34, alpha: 0.00)
        let endColor: UIColor = UIColor(red: 0.26, green: 0.27, blue: 0.34, alpha: 0.20)
        let gradientColors: [CGColor] = [startColor.cgColor, endColor.cgColor]
        gradientLayer.frame = view.bounds
        gradientLayer.colors = gradientColors
        
        view.backgroundColor = UIColor.clear
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
