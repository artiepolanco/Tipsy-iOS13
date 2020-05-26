//
//  CalculatorViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var zeroPctButton: UIButton!
    @IBOutlet weak var tenPctButton: UIButton!
    @IBOutlet weak var twentyPctButton: UIButton!
    @IBOutlet weak var splitNumberLabel: UILabel!
    
    var tipSelected = 0.1
    var splitNumberPeople = 2
    var splitBillTotal: Float = 0.0
    
    @IBAction func tipChanged(_ sender: UIButton) {
        
        billTextField.endEditing(true)
        zeroPctButton.isSelected = false
        tenPctButton.isSelected = false
        twentyPctButton.isSelected = false
        
        let buttonPressed = sender.titleLabel?.text!
        
        if buttonPressed ==  "0%" {
            zeroPctButton.isSelected = true
            tipSelected = 0.0
        } else if buttonPressed == "10%" {
            tenPctButton.isSelected = true
            tipSelected = 0.1
        } else {
            twentyPctButton.isSelected = true
            tipSelected = 0.2
        }
        
        
                        
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        
        splitNumberPeople = Int(sender.value)
        splitNumberLabel.text = String(format: "%.f", sender.value)
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
        let billTextFieldAsNumber = Float(billTextField.text!) ?? 0.0
        
        let pctInPct = billTextFieldAsNumber * Float(tipSelected)
        
        splitBillTotal = (billTextFieldAsNumber + pctInPct) / Float(splitNumberPeople)
        
        print(splitBillTotal)
        
        self.performSegue(withIdentifier: "goToResults", sender: self)
        

    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToResults" {
            let destinationVC = segue.destination as! ResultsViewController
            destinationVC.totalSplitBill = splitBillTotal
            destinationVC.numberOfPeople = splitNumberPeople
            destinationVC.percentage = Int(tipSelected * 100)
        }
    }
    
    
}

