//
//  ProfileViewController.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 13/03/23.
//

import UIKit
import FBSDKLoginKit
import CoreData

class ProfileViewController: UIViewController {
    // MARK: - UI Elements
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 100
        image.image = UIImage(named: "cat")
        image.clipsToBounds = true
        return image
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        return label
    }()
    let actualNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        return label
    }()
    let actualemailLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    let idLabel: UILabel = {
        let label = UILabel()
        label.text = "ID:"
        return label
    }()
    let actualIdLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        // FB Logout button configure
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        setupUI()
        // CoreData read
        let profiles = CoreDataManager.shareInstance.fetchProfiles()
        for profile in profiles {
            print("coredata read")
            let name = profile.name
            let email = profile.email
            let id = profile.id
            let image = profile.image
            print("name: \(name)")
            print("id: \(id)")
            profileImage.image = UIImage(data: image ?? Data())
            actualNameLabel.text = name
            actualemailLabel.text = email
            actualIdLabel.text = id
        }
    }
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
//           navigationController?.navigationBar.prefersLargeTitles = true

           let appearance = UINavigationBarAppearance()
           appearance.backgroundColor = .systemBlue
           appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
           appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

           navigationController?.navigationBar.tintColor = .white
           navigationController?.navigationBar.standardAppearance = appearance
           navigationController?.navigationBar.compactAppearance = appearance
           navigationController?.navigationBar.scrollEdgeAppearance = appearance
   }
    // MARK: - Button Actions
    @objc private func logout() {
        let logoutAlert = UIAlertController(title: "Do you want to Logout?", message: "All data will be lost.", preferredStyle: .alert)
        logoutAlert.addAction(UIAlertAction(title: "Logout", style: .destructive, handler: { (action: UIAlertAction!) in
            let manager = LoginManager()
            manager.logOut()
            CoreDataManager.shareInstance.deleteProfiles()
            self.dismiss(animated: true)
        }))
        logoutAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        }))
        present(logoutAlert, animated: true, completion: nil)
    }
    // MARK: - SetupUI
    private func setupUI() {
        view.addSubviews(profileImage, nameLabel, actualNameLabel, emailLabel, actualemailLabel, idLabel, actualIdLabel)
        profileImage.snp.makeConstraints { make in
            make.width.height.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(120)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(profileImage.snp.bottom).offset(50)
        }
        actualNameLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(20)
            make.top.equalTo(nameLabel)
        }
        emailLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(nameLabel.snp.bottom).offset(50)
        }
        actualemailLabel.snp.makeConstraints { make in
            make.left.equalTo(emailLabel.snp.right).offset(20)
            make.top.equalTo(emailLabel.snp.top)
        }
        idLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.left)
            make.top.equalTo(emailLabel.snp.bottom).offset(50)
        }
        actualIdLabel.snp.makeConstraints { make in
            make.left.equalTo(idLabel.snp.right).offset(40)
            make.top.equalTo(idLabel.snp.top)
        }
    }
}
