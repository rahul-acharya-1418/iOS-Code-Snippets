//
//  RMGetAllCharactersResponse.swift
//  PaginationDemo
//
//  Created by Rahul Acharya on 27/08/26.
//

import Foundation

struct RMGetAllCharactersResponse: Codable {
    
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [RMCharacter]
}

struct RMCharacter: Codable {
    let id: Int
    let name: String
    let image: String
}
