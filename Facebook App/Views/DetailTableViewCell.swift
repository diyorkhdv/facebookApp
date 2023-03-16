//
//  DetailTableViewCell.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 15/03/23.
//

import UIKit
import AdvancedPageControl

class DetailTableViewCell: UITableViewCell {
    static let id = "DetailTableViewCell"
    // MARK: - UI Elements
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.image = UIImage(named: "zucker")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Mark Zuckerberg"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    let dateLabel: UILabel = {
        let label = UILabel()
        label.text = "March 15"
        label.textColor = .systemGray
        return label
    }()
    let cityLabel: UILabel = {
        let label = UILabel()
        label.text = "San Francisco"
        label.textColor = .systemGray
        return label
    }()
    let postLabel: UILabel = {
        let label = UILabel()
        label.text = "Meanwhile, Beast turned to the dark side."
        return label
    }()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.showsHorizontalScrollIndicator = false
        cv.allowsSelection = false
        cv.isScrollEnabled = true
        cv.register(DetailImagesCollectionViewCell.self, forCellWithReuseIdentifier: DetailImagesCollectionViewCell.id)
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        return cv
    }()
    let pageControl = AdvancedPageControlView()
    let postImage: UIImageView = {
        let image = UIImageView()
        image.isUserInteractionEnabled = true
        image.image = UIImage(named: "dog")
        return image
    }()
    let likesLabel: UILabel = {
        let label = UILabel()
        label.text = "488 Likes"
        label.textColor = .systemGray
        return label
    }()
    let commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "10.7K Comments"
        label.textColor = .systemGray
        return label
    }()
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#dfdfdf")
        return view
    }()
    let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.setTitle(" Like", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.setTitle(" Comment", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.setTitle(" Share", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    let bottomSeperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#dfdfdf")
        return view
    }()
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        // Page control configure
        pageControl.drawer = SlideDrawer(numberOfPages: 3, height: 8, width: 8,
                                               space: 10.0,
                                               indicatorColor: .systemBlue,
                                               dotsColor: .lightGray,
                                               isBordered: false,
                                               borderWidth: 0.0,
                                               indicatorBorderColor: .clear,
                                               indicatorBorderWidth: 0.0)
        setupUI()
    }
    // MARK: - Setup UI
    func setupUI() {
        addSubviews(profileImage, nameLabel, dateLabel, cityLabel, postLabel, collectionView, pageControl, postImage, likesLabel, commentsLabel, seperatorView, likeButton, commentButton, shareButton, bottomSeperatorView)
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(15)
            make.top.equalToSuperview().offset(10)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(profileImage.snp.right).offset(15)
            make.top.equalTo(profileImage.snp.top).offset(5)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.left.equalTo(nameLabel)
        }
        cityLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel)
            make.left.equalTo(dateLabel.snp.right).offset(6.5)
        }
        postLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(6.5)
            make.left.equalTo(profileImage)
        }
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(postLabel.snp.bottom).offset(10)
            make.height.equalTo(240)
        }
        pageControl.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(5)
            make.centerX.equalToSuperview()
            make.width.equalTo(200)
        }
        likesLabel.snp.makeConstraints { make in
            make.left.equalTo(postLabel)
            make.top.equalTo(pageControl.snp.bottom).offset(10)
        }
        commentsLabel.snp.makeConstraints { make in
            make.left.equalTo(likesLabel.snp.right).offset(10)
            make.top.equalTo(likesLabel)
        }
        seperatorView.snp.makeConstraints { make in
            make.top.equalTo(commentsLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(1)
        }
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(seperatorView.snp.bottom).offset(15)
            make.left.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(likeButton)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(likeButton)
            make.right.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(30)
        }
        bottomSeperatorView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(shareButton.snp.bottom).offset(15)
            make.height.equalTo(15)
        }
    }
}
// MARK: - UICollectionView Delegate || DataSource || FlowLayout
extension DetailTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailImagesCollectionViewCell", for: indexPath) as! DetailImagesCollectionViewCell
        let images = [UIImage(named: "dog"), UIImage(named: "dog2"), UIImage(named: "dog3")]
        cell.postImage.image = images[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let page = (Int(round(offSet / width)))
        pageControl.setPage(page)
    }
}
