//
//  ViewController.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 13/03/23.
//
import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    // MARK: - ViewModel
    let viewModel = LoginViewModel()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
        loginFB()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // NavBar Configure
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .white
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    private func loginFB() {
        if let token = AccessToken.current,
           !token.isExpired {
            let tabBar = TabBarController()
            tabBar.modalPresentationStyle = .fullScreen
            self.present(tabBar, animated: true)
        } else {
            // button setup
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
        }
    }
}
// MARK: - LoginButtonDelegate
extension LoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "id, email, name, picture.type(large)"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completion: { connection, result, error in
            if error == nil {
                // Get properties
                let dictionary = result as! [String: AnyObject] as NSDictionary
                guard let name = dictionary.object(forKey: "name") as? String else { return }
                guard let email = dictionary.object(forKey: "email") as? String else { return }
                guard let id = dictionary.object(forKey: "id") as? String else { return }
                // Get Image URL
                if let picture = dictionary["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary,
                   let urlStr = data["url"] as? String, let url = URL(string: urlStr) {
                    print("urlStr: \(urlStr)")
                    // Get Image Data
                    self.viewModel.getImage(url: url) { [weak self] result in
                        switch result {
                        case .success(let data):
                            DispatchQueue.main.async {
                                // CoreData Save profile
                                CoreDataManager.shareInstance.saveProfile(imageData: data, email: email, id: id, name: name)
                                let tabBar = TabBarController()
                                tabBar.modalPresentationStyle = .fullScreen
                                self?.present(tabBar, animated: true)
                            }
                        case .failure(_):
                            break
                        }
                    }
                }
            } else {
                self.showAlert(title: "Error", description: error?.localizedDescription ?? "error occured")
            }
        })
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
        print("logout")
    }
}
