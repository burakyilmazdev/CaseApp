//
//  ViewController.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import UIKit

protocol UserListProtocol {
    func userListDidCome(userList:[User])
    func userListErrorDidOccur(error:String)
}


final class UserListViewController: UIViewController,UserListProtocol {
    
    var userList = [User]()
    var selectedUser:UserDetailWrapper?
    
    @IBOutlet var userListTableView: UITableView!
    @IBOutlet var userListLoadingIndicator: UIActivityIndicatorView!
    
    let userListViewModel = UserListViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        userListTableView.dataSource = self
        userListTableView.delegate = self
        userListTableView.register(UINib(nibName: "UserListTableViewCell", bundle: nil), forCellReuseIdentifier: "UserListTableViewCell")
        
        userListViewModel.subscribeUserList(userListProtocol: self)
        userListViewModel.fetchUsers()
        
    }
    
    func userListDidCome(userList: [User]) {
        
        DispatchQueue.main.async {
            print("UserListViewControllerDebug: userListDidCome")
            self.userList = userList
            self.userListLoadingIndicator.stopAnimating()
            self.userListTableView.reloadData()
        }
    }
    
    func userListErrorDidOccur(error: String) {
        
        DispatchQueue.main.async {
            print("UserListViewControllerDebug: userListErrorDidOccur")
            self.userListLoadingIndicator.stopAnimating()
            self.userListTableView.isHidden = true
            self.showAlert(alertText: "Hata", alertMessage: error)
        
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
            
        case "goToUserDetail":
            let vc = segue.destination as? UserDetailViewController
            
            if let selectedUser = self.selectedUser {
                vc?.setUser(user: selectedUser)
            }
            
            break
            
        default:
            break
        }
    }
    
    

}


extension UserListViewController:UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserListTableViewCell", for: indexPath) as? UserListTableViewCell {
            
            let user = userList[indexPath.row]
            
            cell.userEmail.text = user.email
            cell.userName.text = user.name
            cell.userInitials.text = userListViewModel.getInitials(name: user.name)
            cell.userInitialsView.backgroundColor = userListViewModel.getUserColor(indexPath: indexPath)
            
            
            return cell
            
        }
        else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedUser = UserDetailWrapper(user: userList[indexPath.row], color: userListViewModel.getUserColor(indexPath: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "goToUserDetail", sender: self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    
}

