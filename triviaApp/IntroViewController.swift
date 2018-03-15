//
//  IntroViewController.swift
//  triviaApp
//
//  Created by Michael Berend on 15/03/2018.
//  Copyright © 2018 Michael Berend. All rights reserved.
//

import UIKit

class IntroViewController: UIViewController {
    
    // create outlets for the name field and the button
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    /// hide start button
    override func viewDidLoad() {
        startButton.isHidden = true
        super.viewDidLoad()
    }

    /// let result screen unwind to start screen (in its original state)
    @IBAction func unwindToIntro(unwindSegue: UIStoryboardSegue) {
        startButton.isHidden = true
        nameField.isHidden = false
        nameField.text = ""
        
    }
    
    /// save submitted name, hide field and show start button
    @IBAction func nameFieldSumbitted(_ sender: UITextField) {
        NameScore.shared.name = nameField.text
        nameField.isHidden = true
        startButton.isHidden = false
    }

}
