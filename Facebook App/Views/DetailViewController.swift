//
//  DetailViewController.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 15/03/23.
//

import UIKit
import AdvancedPageControl

class DetailViewController: UIViewController {
    var likes = 0
    // MARK: - UI Elements
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(DetailTableViewCell.self, forCellReuseIdentifier: DetailTableViewCell.id)
        tableview.register(CommentsTableViewCell.self, forCellReuseIdentifier: CommentsTableViewCell.id)
        tableview.separatorStyle = .none
        tableview.allowsSelection = false
        return tableview
    }()
    // MARK: - Init
    init(likes: Int) {
        self.likes = likes
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post Detail"
        // delegate || dataSource
        tableView.delegate = self
        tableView.dataSource = self
        // Setup UI
        setupUI()
    }
    // MARK: - SetupUI
    private func setupUI() {
        // Add subviews
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Button Actions
    @objc private func likeButtonPressed(sender: UIButton) {
        if sender.currentImage != UIImage(systemName: "heart.fill") {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likes += 1
            tableView.reloadData()
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            likes -= 1
            tableView.reloadData()
        }
    }
}
// MARK: - Tableview Delegate || DataSource
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 490
        } else {
            return 90
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableViewCell", for: indexPath) as! DetailTableViewCell
            cell.likeButton.addTarget(self, action: #selector(likeButtonPressed), for: .touchUpInside)
            // Likes count
            cell.likesLabel.text = "\(likes) Likes"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
            return cell
        }
    }
}
