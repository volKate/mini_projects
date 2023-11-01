//
//  ViewController.swift
//  PocketTimer
//
//  Created by Kate Volkova on 3.08.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var pauseResumeButton: UIButton!
    
    var countDown = CountDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        countDown.delegate = self
        resetTimer()
    }

    @IBAction func timeSelected(_ sender: UIButton) {
        let time = Int(sender.currentTitle ?? "")
        if let time = time {
            countDown.start(with: time)

            // update totalTimeLabel with selected value
            totalTimeLabel.text = "\(time) MIN"
            // set timeLeftLabel immediately to avoid 1sec delay
            timerLabel.text = countDown.countDownLabel
            updatePauseResumeButton()
        }
    }
    
    @IBAction func pauseResumePressed(_ sender: UIButton) {
        countDown.pauseResume()
        updatePauseResumeButton()
    }
    
    @IBAction func cancelPressed(_ sender: UIButton) {
        resetTimer()
    }
    
    func resetTimer() {
        countDown.reset()
        
        timerLabel.text = countDown.countDownLabel
        updatePauseResumeButton()
    }
    
    func updatePauseResumeButton() {
        let actionTitle = (countDown.isPaused || countDown.isFinished) ? "resume" : "pause"
        pauseResumeButton.setTitle(actionTitle, for: .normal)
    }
}

extension ViewController: Updating {
    @objc func updateUI() {
        if countDown.isFinished {
            resetTimer()
            // TODO: play sound?
        } else {
            timerLabel.text = countDown.countDownLabel
        }
    }
}

