//
//  NetworkManager.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    func request <T:Decodable> (_ endpoint : EndPoint , completion : @escaping (Result<T , Error>) ->Void) ->Void {
        
        let urlSessionTask = URLSession.shared.dataTask(with: endpoint.getRequest()) {(data ,response , error) in
            if let error = error {
                print(error)
            }
            
            if let response = response as? HTTPURLResponse {}
            
            if let data = data {
                do {
                    let jsonData = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(jsonData))
                    
                }catch let error {
                    completion(.failure(error))
                }
            }
            
        }
        urlSessionTask.resume()
        
    }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) ->Void) -> Void {
        let endpoint = EndPoint.getUsers
        request(endpoint, completion: completion)
    }
}
