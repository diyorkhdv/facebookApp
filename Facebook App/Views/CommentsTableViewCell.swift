//
//  CommentsTableViewCell.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 15/03/23.
//

import UIKit

class CommentsTableViewCell: UITableViewCell {
    static let id = "CommentsTableViewCell"
    // MARK: - UI Elements
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.image = UIImage(named: "gates")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Bill Gates"
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Cool application!"
        label.textColor = .black
        return label
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "1 hour ago"
        label.textColor = .gray
        return label
    }()
    let likeLabel: UILabel = {
        let label = UILabel()
        label.text = "Like"
        label.textColor = .black
        return label
    }()
    let replyLabel: UILabel = {
        let label = UILabel()
        label.text = "Reply"
        label.textColor = .black
        return label
    }()
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#dfdfdf")
        return view
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init (coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    private func setupUI() {
        addSubviews(profileImage, nameLabel, commentLabel, timeLabel, likeLabel, replyLabel, seperatorView)
        profileImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(50)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage)
            make.left.equalTo(profileImage.snp.right).offset(10)
        }
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(6)
            make.left.equalTo(nameLabel)
        }
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(commentLabel.snp.bottom).offset(6)
            make.left.equalTo(nameLabel)
        }
        likeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel)
            make.left.equalTo(timeLabel.snp.right).offset(6)
        }
        replyLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel)
            make.left.equalTo(likeLabel.snp.right).offset(6)
        }
        seperatorView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-5)
            make.height.equalTo(2)
            make.top.equalTo(timeLabel.snp.bottom).offset(8)
        }
    }
}
