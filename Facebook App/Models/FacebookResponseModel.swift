//
//  FacebookResponseModel.swift
//  Facebook App
//
//  Created by Diyor Khalmukhamedov on 14/03/23.
//

import Foundation

struct FacebookResponseModel: Codable {
    let name: String
    let email: String
    let id: Int
    let picture: [PicData]
}

struct PicData: Codable {
    let height: Int
    let is_silhouette: Int
    let url: String
    let width: Int
}
