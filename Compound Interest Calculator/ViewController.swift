//
//  ViewController.swift
//  Compound Interest Calculator
//
//  Created by YAUHENI IVANIUK on 2/16/17.
//  Copyright © 2017 YauheniIvaniuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var missingVarOutl: UISegmentedControl!
    
    @IBOutlet weak var textFieldOutl1: UITextField!
    @IBOutlet weak var textFieldOutl2: UITextField!
    @IBOutlet weak var textFieldOutl3: UITextField!
    @IBOutlet weak var textFieldOutl4: UITextField!
    @IBOutlet weak var finelInterestLbl: UILabel!
    
    var firstTextField = Double()
    var secondTextField = Double()
    var thirdTextField = Double()
    var fourthTextField = Double()
    
    var finalInterest = Double()
    var units = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupPlaceHolder()
        
        textFieldOutl1.delegate = self
        textFieldOutl2.delegate = self
        textFieldOutl3.delegate = self
        textFieldOutl4.delegate = self
        
        view.endEditing(true)
        
        
    }

    func assignValue() -> Bool {
        if !textFieldOutl1.hasText || !textFieldOutl2.hasText || !textFieldOutl3.hasText || !textFieldOutl4.hasText {
            return false
        } else {
        
        firstTextField = Double(textFieldOutl1.text!)!
        secondTextField = Double(textFieldOutl2.text!)! / 100
        thirdTextField = Double(textFieldOutl3.text!)!
        fourthTextField = Double(textFieldOutl4.text!)!
        return true
        }
    }
    
    func calculateFinalAmount() {
        // A = P(1 + r/n)nt
        finalInterest = firstTextField * pow(1 + (secondTextField / thirdTextField), thirdTextField * fourthTextField)
        units = "$"
    }
    
    func calculatePrincipalAmount() {
        //P = A / (1 + r/n)nt
        finalInterest = firstTextField / pow(1 + (secondTextField / thirdTextField), thirdTextField * fourthTextField)
        units = "$"
    }
    
    func calculateTimeAmount() {
        finalInterest = log(fourthTextField / firstTextField) / log(1 + (secondTextField / thirdTextField))
        finalInterest = finalInterest / thirdTextField
        
        units = " years"
    }
    
    func setupPlaceHolder() {
        textFieldOutl2.placeholder = "Percent interest rate"
        textFieldOutl3.placeholder = "Times compounded per per year"
        switch missingVarOutl.selectedSegmentIndex {
        case 0:
            textFieldOutl1.placeholder = "Principal amount"
            textFieldOutl4.placeholder = "Years invested"
            finelInterestLbl.text = "0$"
        case 1:
            textFieldOutl1.placeholder = "Final amount"
            textFieldOutl4.placeholder = "Years invested"
            finelInterestLbl.text = "0$"
        case 2:
            textFieldOutl1.placeholder = "Principal amount"
            textFieldOutl4.placeholder = "Final amount"
            finelInterestLbl.text = "0 years"
        default:
            break
        }
        textFieldOutl1.text?.removeAll()
        textFieldOutl2.text?.removeAll()
        textFieldOutl3.text?.removeAll()
        textFieldOutl4.text?.removeAll()
    }
    
    @IBAction func chooseMissingPressed(_ sender: Any) {
        setupPlaceHolder()
        view.endEditing(true)
    }
    
    
    @IBAction func calculatePressed(_ sender: Any) {
        
        if assignValue() == true {
            switch missingVarOutl.selectedSegmentIndex {
            case 0:
                calculateFinalAmount()
            case 1:
                calculatePrincipalAmount()
            case 2:
                calculateTimeAmount()
            default:
                break
            }
            finelInterestLbl.text = String(format: "%0.2f", finalInterest) + (units)
        }
        
        view.endEditing(true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldOutl1.resignFirstResponder()
        textFieldOutl2.resignFirstResponder()
        textFieldOutl3.resignFirstResponder()
        textFieldOutl4.resignFirstResponder()
        return true
    }

}

