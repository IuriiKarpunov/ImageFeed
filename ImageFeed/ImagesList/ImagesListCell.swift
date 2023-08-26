//
//  ImagesListCell.swift
//  ImageFeed
//
//  Created by Iurii on 02.07.23.
//

import UIKit

final class ImagesListCell: UITableViewCell {
    
    static let reuseIdentifier = "ImagesListCell"
    
    // MARK: - IBOutlet
    
    @IBOutlet private weak var linearGradient: UIView!
    @IBOutlet private weak var cellImage: UIImageView!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var dateLabel: UILabel!
    
    // MARK: - Public Methods
    
    func configCell(photo: String, with indexPath: IndexPath) {
        gradientLayer(linearGradient)
        
        guard let image = UIImage(named: photo) else {
            return
        }
        
        cellImage.image = image
        dateLabel.text = Date().dateString
        let isLike = indexPath.row % 2 == 0
        let likeImage = isLike ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        likeButton.setImage(likeImage, for: .normal)
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
