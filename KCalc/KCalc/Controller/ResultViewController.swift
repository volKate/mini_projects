//
//  ResultViewController.swift
//  KCalc
//
//  Created by Kate Volkova on 8.08.22.
//

import UIKit

class ResultViewController: UIViewController {
    var kcalValue: Int = 0

    @IBOutlet weak var kcalLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kcalLabel.text = "\(kcalValue)kcal"
        adviceLabel.text = "\(kcalValue) is your daily need in calories to maintain your current state."
    }
    
    @IBAction func recalculatePressed(_ sender: UIButton) {
        dismiss(animated: true)
    }

}
