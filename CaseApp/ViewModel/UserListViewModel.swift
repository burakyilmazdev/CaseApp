//
//  UserListViewModel.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import Foundation
import UIKit

protocol UserListViewModelProtocol {
    func subscribeUserList(userListProtocol:UserListProtocol)
    func distributeUserList(userList:[User])
    func distributeError(errorMessage:String)
}

class UserListViewModel:UserListViewModelProtocol {

    var userRepository = UserRepository()
    var userListDelegates = [UserListProtocol]()
    
    var userColors = [UIColor.blue,UIColor.systemYellow,UIColor.orange,UIColor.systemGreen,UIColor.purple,UIColor.systemPink]
    
    
    func subscribeUserList(userListProtocol:UserListProtocol) {
        self.userListDelegates.append(userListProtocol)
    }
    
    
    func distributeUserList(userList:[User]) {
        
        for userListDelegate in userListDelegates {
            userListDelegate.userListDidCome(userList: userList)
        }
    }
    
    func distributeError(errorMessage:String) {
        
        for userListDelegate in userListDelegates {
            userListDelegate.userListErrorDidOccur(error: errorMessage)
        }
        
    }
    
    
    func fetchUsers() {
        
        userRepository.fetchUsers(completion: { result in
            
            switch result {
            case .success(let userList):
                self.distributeUserList(userList: userList)
            case .failure(let failure):
                self.distributeError(errorMessage: failure.localizedDescription)
            }
        })
    }
    
    func getUserColor(indexPath:IndexPath) -> UIColor {
        
        return userColors[indexPath.row % userColors.count]

        
    }
    
    func getInitials(name:String) -> String {
        let nameAndSurname = name.split(separator: " ")
        
        if nameAndSurname.count == 0 {
            //if there is no name and surname return XX
            return "XX"
        }
        else if nameAndSurname.count >= 2 {
            //if there is both name and surname return initials
            
            return "\(nameAndSurname.first?.first ?? "X")\(nameAndSurname[1].first ?? "X")"
        }
        else {
            //if there is only name return first two letter of name
            return String(name.prefix(2)).uppercased()
        }
    }
    
    
}
