//
//  Adress.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import Foundation

struct Address: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: Geo
}
