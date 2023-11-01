//
//  Alert.swift
//  AlertApp
//
//  Created by Kate Volkova on 18.08.22.
//

import Foundation
import UIKit

struct Alert {
    private let alert: UIAlertController
    var alertController: UIAlertController {
        return alert
    }
    
    var VC: ViewController?
    
    init(title: String, message: String?) {
        alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    }
    
    func addAction(actionTitle: String, handler: @escaping ([String]) -> Void) {
        let action = UIAlertAction(title: actionTitle, style: .default) { action in
            if let textFields = alert.textFields {
                let fieldsData = textFields.map { $0.text }
                let allFilled = textFields.allSatisfy { textField in
                    textField.text != nil && textField.text != ""
                }
                
                if allFilled {
                    handler(fieldsData as! [String])
                } else {
                    self.present()
                }
            }
        }
        alert.addAction(action)
    }
    
    func addTextField(configurationHandler: ((UITextField) -> Void)? = nil) {
        alert.addTextField(configurationHandler: configurationHandler)
    }
    
    func present() {
        if let VC = VC {
            VC.present(alert, animated: true)
        } else {
            print("Can not present Alert, VC is required")
            return
        }
    }
}
