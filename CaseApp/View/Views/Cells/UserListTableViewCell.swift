//
//  UserListTableViewCell.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import UIKit

class UserListTableViewCell: UITableViewCell {
    
    @IBOutlet var userEmail: UILabel!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userInitials: UILabel!
    @IBOutlet var userInitialsView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = UIBezierPath(ovalIn: userInitialsView.bounds).cgPath
        self.userInitialsView.layer.mask = maskLayer
        
        
    }
    
    
}
