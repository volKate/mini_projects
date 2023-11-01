//
//  ViewController.swift
//  KCalc
//
//  Created by Kate Volkova on 7.08.22.
//

import UIKit

class CalculateViewController: UIViewController {
    var age: Int = 24
    var gender: Activity.Gender = .Male
    var activityStr = Activity.Sedentary.label
    
    var kcalPerDay = 0
    
    
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var heightSlider: UISlider!
    @IBOutlet weak var weightSlider: UISlider!
    
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    
    @IBOutlet weak var activityButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActivityMenu()
    }
    
    @IBAction func heightChanged(_ sender: UISlider) {
        ageTextField.endEditing(true)
        heightLabel.text = String(Int(sender.value)) + "cm"
    }
    
    @IBAction func weightChanged(_ sender: UISlider) {
        ageTextField.endEditing(true)
        weightLabel.text = String(Int(sender.value)) + "kg"
    }
    
    @IBAction func ageChanged(_ sender: UITextField) {
        if let ageStr = sender.text,
           let age = Int(ageStr) {
            self.age = age
        }
    }
    
    @IBAction func genderButtonPressed(_ sender: UIButton) {
        ageTextField.endEditing(true)
        maleButton.isSelected = false
        femaleButton.isSelected = false
        
        sender.isSelected = true
        
        if let genderStr = sender.titleLabel?.text?.lowercased(),
           let gender = Activity.Gender(rawValue: genderStr) {
            self.gender = gender
        }
    }
    
    func activityChanged(to action: UIAction) {
        activityStr = action.title
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        let height = Int(heightSlider.value)
        let weight = Int(weightSlider.value)
        
        let calorieCalculator = CalorieCalculator(height: height, weight: weight, age: age, activity: activityStr, gender: gender)
        kcalPerDay = calorieCalculator.getCaloriesPerDay()
        
        performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToResult" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.kcalValue = kcalPerDay
        }
    }
    
    func setupActivityMenu() {
        let menu = UIMenu(title: "", options: .displayInline, children: [
            UIAction(title: Activity.Sedentary.label, state: .on, handler: activityChanged),
            UIAction(title: Activity.LowActive(gender: .Male).label, state: .on, handler: activityChanged),
            UIAction(title: Activity.Active.label, state: .on, handler: activityChanged),
            UIAction(title: Activity.VeryActive(gender: .Male).label, state: .on, handler: activityChanged)
        ])
        activityButton.showsMenuAsPrimaryAction = true
        activityButton.menu = menu
    }
}

