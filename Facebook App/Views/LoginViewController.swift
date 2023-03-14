//
//  ViewController.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 13/03/23.
//
import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
        loginFB()
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
                let name = dictionary.object(forKey: "name") as! String
                let email = dictionary.object(forKey: "email") as! String
                let id = dictionary.object(forKey: "id") as! String
                
//                do {
//                    let model = try JSONDecoder().decode(FacebookResponseModel.self, from: dataExample)
//                    print("modelName: \(model.name)")
//                    print("modelEmail: \(model.email)")
//                    print("modelID: \(model.id)")
////                    print("model URL: \(model.picture[0].url)")
//                } catch {
//                    print("error json")
//                }
                
                // Get Image
                if let picture = dictionary["picture"] as? NSDictionary, let data = picture["data"] as? NSDictionary,
                   let urlStr = data["url"] as? String, let url = URL(string: urlStr) {
                    print("urlStr: \(urlStr)")
                    URLSession.shared.dataTask(with: url) { (data, response, error) in
                      guard let imageData = data else { return }
                        if let profileImage = UIImage(data: imageData)?.pngData() {
                            // CoreData Save profile
                            DispatchQueue.main.async {
                                CoreDataManager.shareInstance.saveProfile(data: profileImage, email: email, id: id, name: name)
                                let tabBar = TabBarController()
                                tabBar.modalPresentationStyle = .fullScreen
                                self.present(tabBar, animated: true)
                            }
                        }
                    }.resume()
                    
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
