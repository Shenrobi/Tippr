//
//  ViewController.swift
//  Tippr
//
//  Created by Terrell Robinson on 2/23/17.
//  Copyright © 2017 TKYO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tipPercentageSlider: UISlider!
    @IBOutlet weak var tipPercentageLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    
    // MARK: Properties
    
    var tip = TipModel(billAmount: 0.0, tipPercent: 0.0)
    
    
    // MARK: Lifecycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTipCalculationValues()
        updateUI()
        hideKeyboardWhenTappedAround()
    
        
    }
    
    // MARK: IBActions
    
    @IBAction func billAmountWasChanged(_ sender: Any) {
        
        
        setTipCalculationValues()
        updateUI()
    }
    
    @IBAction func tipPercentageDidChange(_ sender: UISlider) {
        
        // Take the value and multiply it by the steps (rounds to the nearest whole number) and divide it by 100 (gives the slider a snappy feel)
        
        let steps: Float = 100
        let roundedValue = round(sender.value * steps) / steps
        sender.value = roundedValue
        
        setTipCalculationValues()
        updateUI()
    }
    
    // MARK: Helper Methods
    
    private func setTipCalculationValues() {
        tip.tipPercent = Double(tipPercentageSlider.value)
        tip.billAmount = ((textField.text)! as NSString).doubleValue
        tip.calculateTip()
        
    }

    private func updateUI() {
        tipLabel.text = String(format: "$%0.2f", tip.tipAmount)
        totalLabel.text = String(format: "$%0.2f", tip.totalAmount)
        tipPercentageLabel.text = "Tip: \(Int(tipPercentageSlider.value * 100))%"
    }

}

// Quick Extension

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}

