//
//  ViewController.swift
//  Dog Of The Day
//
//  Created by Ekaterina Volkova on 27.06.2020.
//  Copyright © 2020 Ekaterina Volkova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var doggoImageView: UIImageView!
    
    let doggos = [#imageLiteral(resourceName: "Doberman-Pinscher"), #imageLiteral(resourceName: "Doberman-Pinschers1"), #imageLiteral(resourceName: "Yorkshire-Terrier"), #imageLiteral(resourceName: "Yorkshire-Terrier1"), #imageLiteral(resourceName: "German-Shepherd"), #imageLiteral(resourceName: "German-Shepherd1"), #imageLiteral(resourceName: "Beagle1"), #imageLiteral(resourceName: "Beagle"), #imageLiteral(resourceName: "Labrador-Retriever1"), #imageLiteral(resourceName: "Labrador-Retriever"), #imageLiteral(resourceName: "Russell-Terrier"), #imageLiteral(resourceName: "Russell-Terrier1"), #imageLiteral(resourceName: "Shiba-Inus1"), #imageLiteral(resourceName: "Shiba-Inu"), #imageLiteral(resourceName: "French-Bulldog1"), #imageLiteral(resourceName: "French-Bulldog"), #imageLiteral(resourceName: "Pug1"), #imageLiteral(resourceName: "Pug")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: instead of random strig use date hash
        // to show one randow dog a day
        doggoImageView.image = doggos.randomElement()
    }


}

