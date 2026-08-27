//
//  NetworkManager.swift
//  PaginationDemo
//
//  Created by Rahul Acharya on 27/08/26.
//


import Foundation
import Alamofire

final class NetworkManager {

    static let shared = NetworkManager()

    private init() {}
    
    private let defaultHeaders: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": "Bearer "
    ]

    public func getData<T: Codable>(
        _ type: T.Type,
        url: String,
        parameters: [String: String]? = nil,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

        var requestHeaders = defaultHeaders
        
        if let headers, !headers.isEmpty {
            headers.forEach {
                requestHeaders.add(
                    HTTPHeader(
                        name: $0.key,
                        value: $0.value
                    )
                )
            }
        }
        
        AF.request(
            url,
            method: .get,
            parameters: parameters,
            headers: requestHeaders
        )
        .responseDecodable(of: type) { response in
            let responseString = response.data
                           .flatMap { String(data: $0, encoding: .utf8) }

            print("""
            ==================== API RESPONSE ====================
            \(responseString ?? "nil")
            ========================================================
            """)
            
            switch response.result {

            case .success(let value):
                completion(.success(value))

            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    public func postData<T: Codable>(
        _ type: T.Type,
        url: String,
        body: String?,
        headers: [String: String]? = nil,
        completion: @escaping (Result<T, Error>) -> Void
    ) {


        var requestHeaders = defaultHeaders

        if let headers, !headers.isEmpty {
            headers.forEach {
                requestHeaders.add(
                    HTTPHeader(
                        name: $0.key,
                        value: $0.value
                    )
                )
            }
        }

        var request = URLRequest(url: URL(string: url)!)
        request.method = .post
        request.headers = requestHeaders
        request.httpBody = body?.data(using: .utf8)
        
//        printAPIDebug(
//             url: url,
//             method: request.method?.rawValue ?? "",
//             headers: requestHeaders,
//             body: body
//         )
        
        AF.request(request)
            .responseDecodable(of: type) { response in
                let responseString = response.data
                               .flatMap { String(data: $0, encoding: .utf8) }

                print("""
                ==================== API RESPONSE ====================
                \(responseString ?? "nil")
                ========================================================
                """)
                
                switch response.result {

                case .success(let value):
                    completion(.success(value))

                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    private func printAPIDebug(
        url: String,
        method: String,
        headers: HTTPHeaders,
        body: String? = nil
    ) {
        print("""
        ==================== API REQUEST ====================
        URL     : \(url)
        METHOD  : \(method)
        HEADERS : \(headers)
        BODY    : \(body ?? "nil")
        ======================================================
        """)
    }
}
