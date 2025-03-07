//
//  EndPoint.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import Foundation

enum EndPoint {
    case getUsers
}

enum HttpMethod : String {
    case GET = "GET"
    case POST = "POST"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

protocol EndpointProtocol{
    var baseUrl: String {get}
    var path : String {get}
    var method : HttpMethod {get}
    var header : [String : String]? {get}
    func getRequest () -> URLRequest
}

extension EndPoint : EndpointProtocol{
    
    var baseUrl: String {
        return "https://jsonplaceholder.typicode.com"
    }
    
    var path: String {
        switch self {
        case .getUsers : return "/users"
        }
    }
    
    var method: HttpMethod {
        switch self{
        case .getUsers : return .GET
            
        }
    }
    
    var header: [String : String]? {
        return nil
    }
    
    func getRequest() -> URLRequest {
        guard var component = URLComponents(string: baseUrl) else{
            fatalError("Invalid Error")
        }
        component.path = path
        var request = URLRequest(url: component.url!)
        request.httpMethod =  method.rawValue
        return request
    }
}
