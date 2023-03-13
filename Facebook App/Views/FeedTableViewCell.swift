//
//  FeedTableViewCell.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 13/03/23.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    static let id = "FeedTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .systemGreen
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
