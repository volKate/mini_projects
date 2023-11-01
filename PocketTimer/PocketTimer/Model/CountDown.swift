//
//  CountDown.swift
//  PocketTimer
//
//  Created by Kate Volkova on 5.08.22.
//

import Foundation

protocol Updating {
    func updateUI()
}

class CountDown {
    
    var delegate: Updating?
    
    // totaltime in seconds
    var totalTime = 0
    var timePassed = 0
    var isPaused = false
    var isFinished = false
    var timer: Timer?
    
    var timeLeft: Int {
        return totalTime - timePassed
    }
    
    var countDownLabel: String {
        let mins = timeLeft / 60
        let seconds = timeLeft % 60
        return String(format: "%02d", mins) + ":" + String(format: "%02d", seconds)
    }
    
    // time in mins
    func start(with time: Int) {
        // invalidate timer if there is one running
        timer?.invalidate()
        
        // convert min to sec & set totalTime & reset timePassed
        totalTime = time * 60
        timePassed = 0
        isFinished = false
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
    
    func reset() {
        timer?.invalidate()
        totalTime = 0
        timePassed = 0
        isPaused = false
        isFinished = true
    }
    
    @objc func tick() {
        if timePassed < totalTime {
            timePassed += 1
        } else {
            isFinished = true
        }
        
        delegate?.updateUI()
    }
    
    func pauseResume() {
        // ignore button press if no countDown is in progress
        if totalTime == 0 {
            return
        }
        
        if isPaused {
            resume()
        } else {
            pause()
        }
    }
    
    func pause() {
        isPaused = true
        // invalidate previous timer
        timer?.invalidate()
    }
    
    func resume() {
        isPaused = false
        // schedule new timer that will start from previous value
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(tick), userInfo: nil, repeats: true)
    }
}
