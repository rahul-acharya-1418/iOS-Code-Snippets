//
//  UserProfile.swift
//  CommonCrypto
//
//  Created by Rahul Acharya on 08/07/26.
//

import Foundation


// MARK: - Model
struct UserProfile: Codable {
    let id: Int
    let name: String
    let email: String
}
