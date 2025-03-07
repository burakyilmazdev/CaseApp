//
//  UIViewController+Extension.swift
//  CaseApp
//
//  Created by Unica Fintech on 5.03.2025.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(alertText : String, alertMessage : String) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
