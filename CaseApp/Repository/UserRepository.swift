//
//  UserRepository.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import Foundation

protocol UserRepositoryProtocol {
    func fetchUsers(completion: @escaping (Result<[User],Error>) -> Void)
}


class UserRepository:UserRepositoryProtocol {
    
    func fetchUsers(completion: @escaping (Result<[User], any Error>) -> Void) {
        
        NetworkManager.shared.fetchUsers { result in            
            completion(result)
        }
        
        
    }
    
    
}
