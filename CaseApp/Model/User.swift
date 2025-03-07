//
//  User.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import Foundation
import UIKit

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
        
}

struct UserListResponse {
    var user:[User]?
    var error:String?
}

struct UserDetailWrapper {
    var user:User
    var color:UIColor
}
