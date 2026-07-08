//
//  ViewController.swift
//  CommonCrypto
//
//  Created by Rahul Acharya on 08/07/26.
//

import UIKit
import Foundation
import CryptoSwift
import CryptoKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        simpleExample()
//        encrypteUserProfileConfig()
        cryptoKitExample()
    }
    
    // MARK: - Refactor example code
    func encrypteUserProfileConfig() {
        
        let profile = UserProfile(
            id: 1,
            name: "test",
            email: "test@test.com"
        )
        
        do {
            // Encrypt
            let encryptedString = try AESManager.shared.encrypt(profile)
            
            print("========== ENCRYPTED ==========")
            print(encryptedString)
            
            // Decrypt
            let decryptedProfile = try AESManager.shared.decrypt(
                UserProfile.self,
                from: encryptedString
            )
            
            print("========== DECRYPTED ==========")
            print(decryptedProfile)
            
        } catch {
            print(error)
        }
    }
    
    // MARK: - Simple working example AES-256-CBC
    func simpleExample() {
        let json = UserProfile(
            id: 1,
            name: "test",
            email: "test@test.com"
        )
        
        let key = "4Wm2Qn3rWQ7O5X1QjQmM6Xq7wQ6Y8M7s"
        let iv  = "4Wm2Qn3rWQ7O5X1Q"

        do {

            let encoder = JSONEncoder()
            let jsonData = try encoder.encode(json)

            let aes = try AES(
                key: Array(key.utf8),
                blockMode: CBC(iv: Array(iv.utf8)),
                padding: .pkcs7
            )

            let encrypted = try aes.encrypt(Array(jsonData))

            let base64 = Data(encrypted).base64EncodedString()
            
            print("encrypted:")
            print(encrypted)
            print("====================")
            print("base64:")
            print(base64)
            print("====================")
            
            // -------------------------
            // Decrypt
            // -------------------------

            let encryptedData = Data(base64Encoded: base64)!

            let decrypted = try aes.decrypt(Array(encryptedData))

            let profile = try JSONDecoder().decode(
                UserProfile.self,
                from: Data(decrypted)
            )

            print(profile)

        }
        catch {
            print("Error: ",error)
        }
    }
    
  
    // MARK: - CryptoKit AES-GCM Example
    func cryptoKitExample() {

        let profile = UserProfile(
            id: 2,
            name: "test2",
            email: "test2@test.com"
        )

        do {

            // MARK: Encode JSON

            let jsonData = try JSONEncoder().encode(profile)

            print("========== ORIGINAL JSON ==========")
            print(String(data: jsonData, encoding: .utf8)!)

            let secretKey = "4Wm2Qn3rWQ7O5X1QjQmM6Xq7wQ6Y8M7s"

            guard secretKey.utf8.count == 32 else {
                fatalError("Key must be exactly 32 bytes for AES-256")
            }

            let key = SymmetricKey(data: Data(secretKey.utf8))
            
            // MARK: Encrypt

            let sealedBox = try AES.GCM.seal(jsonData, using: key)

            guard let encryptedData = sealedBox.combined else {
                fatalError("Failed to create encrypted data.")
            }

            let base64 = encryptedData.base64EncodedString()

            print("\n========== ENCRYPTED BASE64 ==========")
            print(base64)

            // MARK: Decrypt

            let encrypted = Data(base64Encoded: base64)!

            let sealed = try AES.GCM.SealedBox(combined: encrypted)

            let decryptedData = try AES.GCM.open(sealed, using: key)

            print("\n========== DECRYPTED JSON ==========")
            print(String(data: decryptedData, encoding: .utf8)!)

            // MARK: Decode Model

            let decodedProfile = try JSONDecoder().decode(
                UserProfile.self,
                from: decryptedData
            )

            print("\n========== DECODED OBJECT ==========")
            print(decodedProfile)

        } catch {
            print("Error:", error)
        }
    }
}
