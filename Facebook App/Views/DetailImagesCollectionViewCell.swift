//
//  DetailImagesCollectionViewCell.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 15/03/23.
//

import UIKit

class DetailImagesCollectionViewCell: UICollectionViewCell {
    static let id = "DetailImagesCollectionViewCell"
    // MARK: - UI Elements
    let postImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "dog")
        image.contentMode = .scaleAspectFill
        return image
    }()
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(postImage)
        backgroundColor = .gray
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    private func setupUI() {
        addSubview(postImage)
        postImage.snp.makeConstraints { make in
            make.height.width.equalToSuperview()
            make.centerY.centerX.equalToSuperview()
        }
    }
}
