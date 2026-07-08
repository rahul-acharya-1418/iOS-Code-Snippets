//
//  AESManager.swift
//  CommonCrypto
//
//  Created by Rahul Acharya on 08/07/26.
//

import Foundation
import CryptoSwift

// MARK: - AES Encryption Manager

final class AESManager {

    static let shared = AESManager()

    private init() {}

    // MARK: Encrypt Codable Object
    func encrypt<T: Codable>(_ object: T) throws -> String {

        let jsonData = try JSONEncoder().encode(object)

        let aes = try AES(
            key: Array(CryptoConfig.secretKey.utf8),
            blockMode: CBC(iv: Array(CryptoConfig.iv.utf8)),
            padding: .pkcs7
        )

        let encrypted = try aes.encrypt(Array(jsonData))

        return Data(encrypted).base64EncodedString()
    }

    // MARK: Decrypt Codable Object
    func decrypt<T: Codable>(_ type: T.Type,
                             from base64: String) throws -> T {

        let encryptedData = Data(base64Encoded: base64)!
        
        let aes = try AES(
            key: Array(CryptoConfig.secretKey.utf8),
            blockMode: CBC(iv: Array(CryptoConfig.iv.utf8)),
            padding: .pkcs7
        )

        let decrypted = try aes.decrypt(Array(encryptedData))

        return try JSONDecoder().decode(T.self, from: Data(decrypted))
    }
}

struct CryptoConfig {
    static let secretKey = "4Wm2Qn3rWQ7O5X1QjQmM6Xq7wQ6Y8M7s"
    static let iv = "4Wm2Qn3rWQ7O5X1Q"
}
