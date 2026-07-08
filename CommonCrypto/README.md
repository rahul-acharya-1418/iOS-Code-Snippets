## 1.0 CommonCrypto

**Description**

Demonstrates **AES-256-CBC** encryption and decryption using the **CryptoSwift** library with a backend-provided **Secret Key** and **IV**.

**Repository**

* https://github.com/krzyzanowskim/CryptoSwift

**Example Includes**

* Encrypt a Swift `Codable` model (JSON) to a Base64 string.
* Decrypt a Base64 string back to a Swift `Codable` model (JSON).
* AES-256-CBC encryption using a backend-provided Secret Key and IV.
* End-to-end compatibility between iOS and the backend.

- then the flow is:
```
Swift Model
      ↓
JSONEncoder
      ↓
JSON Data
      ↓
AES-256-CBC (Key + IV)
      ↓
Encrypted Bytes
      ↓
Base64 String
      ↓
Send to Backend
```
- Decrypt:
```
Base64 String
      ↓
Base64 Decode
      ↓
AES-256-CBC Decrypt (Same Key + IV)
      ↓
JSON Data
      ↓
JSONDecoder
      ↓
Swift Model
```
