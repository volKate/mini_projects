//
//  ViewController.swift
//  AlertApp
//
//  Created by Kate Volkova on 18.08.22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var greetingLabel: UILabel!
    @IBOutlet weak var addNumbersLabel: UILabel!
    @IBOutlet weak var reverseTextLabel: UILabel!
    @IBOutlet weak var guessNumberLabel: UILabel!
    
    var guessNumber: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentNameAlert()
    }
    
    func presentNameAlert(again: Bool = false) {
        var alert = Alert(title: "Hello", message: "Enter your name")
        alert.VC = self
        alert.addAction(actionTitle: "Start") { fieldsData in
            if let name = fieldsData.first {
                self.greetingLabel.text = "Hello, \(name)"
            }
        }
        
        alert.addTextField { nameField in
            nameField.autocapitalizationType = .words
        }
        
        alert.present()
    }
}

// MARK: - Add numbers game
extension ViewController {
    @IBAction func addNumbersPressed(_ sender: UIButton) {
        presentAddNumbersAlert()
    }
    
    func presentAddNumbersAlert() {
        var alert = Alert(title: "Add numbers", message: nil)
        alert.VC = self
        alert.addAction(actionTitle: "Calculate") { fieldsData in
            if fieldsData.count == 2, let firstNumber = Int(fieldsData.first!), let secondNumber = Int(fieldsData.last!) {
                let sum = Int(firstNumber) + Int(secondNumber)
                self.addNumbersLabel.text = "Sum: \(sum)"
            } else {
                self.addNumbersLabel.text = "Ooops, something went wrong.."
            }
        }
        
        alert.addTextField { nameField in
            nameField.keyboardType = .numberPad
            nameField.placeholder = "Enter first number"
        }
        alert.addTextField { nameField in
            nameField.keyboardType = .numberPad
            nameField.placeholder = "Enter second number"
        }
        
        alert.present()
    }
}

// MARK: - Reverse text game
extension ViewController {
    @IBAction func reverseTextPressed(_ sender: UIButton) {
        var alert = Alert(title: "Reverse text", message: nil)
        alert.VC = self
        alert.addAction(actionTitle: "Reverse") { fieldsData in
            if let text = fieldsData.first {
                self.reverseTextLabel.text = "Reversed: " + String(text.reversed())
            }
        }
        
        alert.addTextField { nameField in
            nameField.placeholder = "Enter your text"
        }
        
        alert.present()
    }
}

// MARK: - Guess number game
extension ViewController {
    @IBAction func guessNumberPressed(_ sender: UIButton) {
        var alert = Alert(title: "Guess number", message: "I'm thinking of a number between 1 and 100.")
        alert.VC = self
        alert.addAction(actionTitle: "Guess") { fieldsData in
            if self.guessNumber == nil {
                self.guessNumber = Int.random(in: 1...100)
            }
            if let userNumber = Int(fieldsData.first!) {
                var result: String
                if userNumber == self.guessNumber {
                    result = "You won!"
                    self.guessNumber = nil
                } else if userNumber < self.guessNumber! {
                    result = "My number is grater"
                } else {
                    result = "My number is less"
                }
                
                self.guessNumberLabel.text = result
            }
        }
        
        alert.addTextField { nameField in
            nameField.placeholder = "Enter your number"
            nameField.keyboardType = .numberPad
        }
        
        alert.present()
    }
}

