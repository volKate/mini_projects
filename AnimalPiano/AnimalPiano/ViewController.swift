//
//  ViewController.swift
//  AnimalPiano
//
//  Created by Kate Volkova on 1.08.22.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var player: AVAudioPlayer!

    @IBAction func keyPressed(_ sender: UIButton) {
        let keyId = sender.accessibilityIdentifier
        playSound(forKey: keyId)
    }
    
    func playSound(forKey soundName: String?) {
        if let soundName = soundName {
            let url = Bundle.main.url(forResource: soundName, withExtension: "wav")!
            player = try! AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            player.play()
        }
    }
    
}

