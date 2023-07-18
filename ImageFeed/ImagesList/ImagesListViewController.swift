//
//  ViewController.swift
//  ImageFeed
//
//  Created by Iurii on 29.06.23.
//

import UIKit

class ImagesListViewController: UIViewController {

    // MARK: - Private Constants
    
    private let photosName: [String] = Array(0..<21).map{ "\($0)" }
    private let ShowSingleImageSegueIdentifier = "ShowSingleImage"
    
    // MARK: - Public Properties
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter
    }()
    
    // MARK: - IBOutlet
    
    @IBOutlet private var tableView: UITableView!
    
    // MARK: - UIStatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == ShowSingleImageSegueIdentifier {
            let viewController = segue.destination as! SingleImageViewController
            let indexPath = sender as! IndexPath
            let image = UIImage(named: photosName[indexPath.row])
            viewController.image = image
        } else {
            super.prepare(for: segue, sender: sender)
        }
    }
}

extension ImagesListViewController {
    func configCell(for cell: ImagesListCell, with indexPath: IndexPath) {
        gradientLayer(cell)
        
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return
        }
        
        cell.cellImage.image = image
        cell.dateLabel.text = dateFormatter.string(from: Date())
        let isLike = indexPath.row % 2 == 0
        let likeImage = isLike ? UIImage(named: "like_button_on") : UIImage(named: "like_button_off")
        cell.likeButton.setImage(likeImage, for: .normal)
    }
    
    func gradientLayer(_ cell: ImagesListCell) {
        let gradientLayer = CAGradientLayer()
        let startColor: UIColor = UIColor(red: 0.26, green: 0.27, blue: 0.34, alpha: 0.00)
        let endColor: UIColor = UIColor(red: 0.26, green: 0.27, blue: 0.34, alpha: 0.20)
        let gradientColors: [CGColor] = [startColor.cgColor, endColor.cgColor]
        gradientLayer.frame = cell.linearGradient.bounds
        gradientLayer.colors = gradientColors
        
        cell.linearGradient.backgroundColor = UIColor.clear
        cell.linearGradient.layer.insertSublayer(gradientLayer, at: 0)
        
        cell.linearGradient.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}

// MARK: - UITableViewDelegate

extension ImagesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: ShowSingleImageSegueIdentifier, sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let image = UIImage(named: photosName[indexPath.row]) else {
            return 0
        }
        
        let imageInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        let imageViewWidth = tableView.bounds.width - imageInsets.left - imageInsets.right
        let imageWidth = image.size.width
        let scale = imageViewWidth / imageWidth
        let cellHeight = image.size.height * scale + imageInsets.top + imageInsets.bottom
        return cellHeight
    }
}

// MARK: - UITableViewDataSource

extension ImagesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photosName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImagesListCell.reuseIdentifier, for: indexPath)
        
        guard let imagesListCell = cell as? ImagesListCell else {
            print("warning: ошибка приведения типов, пустые ячейки")
            return UITableViewCell()
        }
        
        configCell(for: imagesListCell, with: indexPath)
        return imagesListCell
    }
}


