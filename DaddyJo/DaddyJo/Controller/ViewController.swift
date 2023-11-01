//
//  ViewController.swift
//  DaddyJo
//
//  Created by Kate Volkova on 10.08.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var jokeLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    
    var jokeManager = JokeManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchField.delegate = self
        jokeManager.delegate = self
        jokeManager.fetchJoke()
    }

    @IBAction func refreshPressed(_ sender: UIButton) {
        jokeManager.fetchJoke()
    }
}

// MARK: - UITextFieldDelegate

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return true
        } else {
            textField.placeholder = "Type something..."
            return false
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let theme = textField.text
        if let theme = theme {
            jokeManager.fetchJoke(about: theme)
        }
        textField.text = ""
        textField.placeholder = "Search"
    }
}

// MARK: - JokeManagerDelegate

extension ViewController: JokeManagerDelegate {
    func didLoadJoke(_ joke: String) {
        DispatchQueue.main.async {
            self.jokeLabel.text = joke
        }
    }
}
