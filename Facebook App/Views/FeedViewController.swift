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
        tableview.separatorStyle = .none
        tableview.allowsSelection = false
        return tableview
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.navigationBar.barTintColor = UIColor.systemBlue
        view.backgroundColor = .white
        title = "Feed"
        setupUI()
        // delegate || dataSource
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           navigationController?.navigationBar.prefersLargeTitles = true

           let appearance = UINavigationBarAppearance()
           appearance.backgroundColor = .systemBlue
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

           navigationController?.navigationBar.tintColor = .white
           navigationController?.navigationBar.standardAppearance = appearance
           navigationController?.navigationBar.compactAppearance = appearance
           navigationController?.navigationBar.scrollEdgeAppearance = appearance
   }
    private func setupUI() {
        // Add subviews
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
extension FeedViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        return cell
    }
}
