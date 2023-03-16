//
//  LoginViewModel.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 16/03/23.
//

import UIKit

final class LoginViewModel {
    func getImage(url: URL, completion: @escaping (Result<Data, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let imageData = data, error == nil else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            completion(.success(imageData))
        }.resume()
    }
}
