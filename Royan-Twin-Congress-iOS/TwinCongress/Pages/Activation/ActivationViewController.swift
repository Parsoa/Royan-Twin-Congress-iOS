//
//  ActivationViewController.swift
//  TwinCongress
//
//  Created by Mohammad Amin Borghei on 8/24/17.
//  Copyright © 2017 Royan. All rights reserved.
//

import UIKit
import ChameleonFramework

class ActivationViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var activationTextField: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.theme
        errorLabel.config(text: "Sorry, the code you've entered is incorrect.", size: 14, textColorIn: UIColor.red)
        errorLabel.isHidden = true
        titleLabel.config(text: "Please enter activation code", size: 17, textColorIn: UIColor.white)
        
        checkButton.setTitle("Check", for: .normal)
        checkButton.addTarget(self, action: #selector(checkActivation), for: .touchUpInside)
        activationTextField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        activationTextField.returnKeyType = .go
        activationTextField.delegate = self
    }

    func checkActivation() {
        activationTextField.resignFirstResponder()
        if Activation.checkAndActivate(code: activationTextField.text ?? "") {
            present(UIViewController.root(), animated: true, completion: nil)
        } else {
            errorLabel.isHidden = false
        }
    }
    
    func textChanged() {
        errorLabel.isHidden = true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        checkActivation()
        return true
    }

}
