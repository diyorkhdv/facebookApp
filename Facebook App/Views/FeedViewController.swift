//
//  FeedViewController.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 13/03/23.
//

import UIKit
import SnapKit

class FeedViewController: UIViewController {
    // Overall News Count
    var newsCount = 3
    let dogImages = [UIImage(named: "dog2"), UIImage(named: "dog3")]
    var dogImage = UIImage(named: "dog")
    // MARK: - UI Elements
    let tableView: UITableView = {
        let tableview = UITableView()
        tableview.register(FeedTableViewCell.self, forCellReuseIdentifier: FeedTableViewCell.id)
        tableview.separatorStyle = .none
        tableview.allowsSelection = true
        return tableview
    }()
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(addNews(sender:)), for: .valueChanged)
        return refreshControl
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Feed"
        setupUI()
        // delegate || dataSource
        tableView.delegate = self
        tableView.dataSource = self
        // Refresh Control
        tableView.refreshControl = myRefreshControl
        // Double Tap Gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(scrollToTop))
        tap.numberOfTapsRequired = 2
        tabBarController?.tabBar.addGestureRecognizer(tap)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // NavBar Configure
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .systemBlue
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    // MARK: - SetupUI
    private func setupUI() {
        // Add subviews
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    // Table View footer
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        spinner.style = .large
        spinner.center = footerView.center
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    // MARK: - Button Actions
    @objc private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
    @objc private func addNews(sender: UIRefreshControl) {
        newsCount += 1
        dogImage = dogImages.randomElement()!
        tableView.reloadData()
        sender.endRefreshing()
    }
}
// MARK: - Tableview Delegate || DataSource
extension FeedViewController: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 450
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedTableViewCell", for: indexPath) as! FeedTableViewCell
        cell.selectionStyle = .none
        // Posts Count Overall
        cell.likesLabel.text = "\(indexPath.row + 1) Likes"
        cell.postImage.image = dogImage
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(DetailViewController(likes: indexPath.row + 1), animated: true)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       let lastSectionIndex = tableView.numberOfSections - 1
       let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
       if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex {
           self.tableView.tableFooterView = createSpinnerFooter()
           self.tableView.tableFooterView?.isHidden = false
           newsCount += 5
           DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
               self.tableView.reloadData()
               self.tableView.tableFooterView = nil
           }
       }
   }
}
