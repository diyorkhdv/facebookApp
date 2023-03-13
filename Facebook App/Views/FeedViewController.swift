//
//  FeedViewController.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 13/03/23.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    // MARK: - UI Elements
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.id)
        return tableview
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.backgroundColor = .white
        // Logout Button configure
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        title = "Feed"
        setupUI()
        // delegate || dataSource
        tableView.delegate = self
        tableView.dataSource = self
    }
    func setupUI() {
        // Add subviews
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // MARK: - Button Actions
    @objc func logout() {
        navigationController?.popToRootViewController(animated: true)
    }
}
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.id, for: indexPath) as? FeedTableViewCell else { return UITableViewCell()}
        return cell
    }
}
