//
//  ViewController.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 13/03/23.
//
import FBSDKLoginKit

class LoginViewController: UIViewController, LoginButtonDelegate {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Login"
        loginFB()
    }
    func loginFB() {
        if let token = AccessToken.current,
           !token.isExpired {
            let token = token.tokenString
            
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                     parameters: ["fields": "email, name"],
                                                     tokenString: token,
                                                     version: nil,
                                                     httpMethod: .get)
            request.start(completion: { connection, result, error in
                print("connection: \(String(describing: connection))")
                print("result : \(String(describing: result))")
                print("error : \(String(describing: error))")
                if error == nil {
                    DispatchQueue.main.async {
                        self.navigationController?.pushViewController(FeedViewController(), animated: true)
                    }
                } else {
                    let alert = UIAlertController(title: "Error", message: "Error occured", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        } else {
            // button setup
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            loginButton.delegate = self
            loginButton.permissions = ["public_profile", "email"]
            view.addSubview(loginButton)
        }
    }
    // MARK: - LoginButtonDelegate
    func loginButton(_ loginButton: FBSDKLoginKit.FBLoginButton, didCompleteWith result: FBSDKLoginKit.LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, name"],
                                                 tokenString: token,
                                                 version: nil,
                                                 httpMethod: .get)
        request.start(completion: { connection, result, error in
            print("connection: \(String(describing: connection))")
            print("result : \(String(describing: result))")
            print("error : \(String(describing: error))")
            if error == nil {
                self.navigationController?.pushViewController(FeedViewController(), animated: true)
            } else {
                let alert = UIAlertController(title: "Error", message: "Error occured", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        })
    }
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginKit.FBLoginButton) {
    }
}


