//
//  ViewController.swift
//  Cool Tip Calculator
//
//  Created by Karol Phung on 7/11/20.
//  Copyright © 2020 Karol Phung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var customTipView: UIView!
    @IBOutlet weak var customTip: UITextField!
    @IBOutlet weak var splitNumber: UILabel!
    @IBOutlet weak var splitContainerView: UIView!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let store = UserDefaults.standard
        
        let indexOfDefaultTip = store.integer(forKey: "indexOfDefaultTip")
        tipControl.selectedSegmentIndex = indexOfDefaultTip
        
        let defaultSplit = store.integer(forKey: "split")
        splitNumber.text = String(defaultSplit)
        
        splitContainerView.layer.cornerRadius = 15.0
        minusButton.layer.cornerRadius = minusButton.frame.height / 2.0
        plusButton.layer.cornerRadius = plusButton.frame.height / 2.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let store = UserDefaults.standard
        
        let showLastBill = store.bool(forKey: "showLastBill")
        let defaultTipChanged = store.bool(forKey: "defaultTipChanged")
        let defaultSplitChanged = store.bool(forKey: "defaultSplitChanged")
        
        if (showLastBill) {
            let lastBill = store.double(forKey: "lastBill")
            billField.text = String(format: "%.2f", lastBill)
        }
        
        if (defaultTipChanged) {
            let indexOfDefaultTip = store.integer(forKey: "indexOfDefaultTip")
            tipControl.selectedSegmentIndex = indexOfDefaultTip
            customTipView.isHidden = true
            calculateTip()
            store.set(false, forKey: "defaultTipChanged")
        }
        
        if (defaultSplitChanged) {
            let defaultSplit = store.integer(forKey: "split")
            splitNumber.text = String(defaultSplit)
            calculateTip()
            store.set(false, forKey: "defaultSplitChanged")
        }
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func didChangeBill(_ sender: Any) {
        let store = UserDefaults.standard
        let bill = billField.text
        store.set(bill, forKey: "lastBill")
        calculateTip()
    }
    
    @IBAction func didChangeTip(_ sender: Any) {
        if (tipControl.selectedSegmentIndex == 3) {
            customTipView.isHidden = false
        }
        else {
            customTipView.isHidden = true
        }
        calculateTip()
    }
    
    @IBAction func didChangeCustom(_ sender: Any) {
        calculateTip()
    }
    
    @IBAction func decreaseSplit(_ sender: Any) {
        let split = Int(splitNumber.text!) ?? 0
        if (split > 1) {
            splitNumber.text = String(split - 1)
            calculateTip()
        }
    }
    
    @IBAction func increaseSplit(_ sender: Any) {
        let split = Int(splitNumber.text!) ?? 0
        splitNumber.text = String(split + 1)
        calculateTip()
    }
    
    fileprivate func calculateTip() {
        let bill = Double(billField.text!) ?? 0
        
        let tip: Double
        
        if (tipControl.selectedSegmentIndex == 3) {
            let custom = Double(customTip.text!) ?? 0
            tip = bill * custom * 0.01
        }
        else {
            let tipPercentages = [0.15, 0.18, 0.2]
            tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        }
        
        let split = Double(splitNumber.text!) ?? 0
        let total = (bill + tip) / split
        
        tipLabel.text = String(format: "%.2f", tip)
        totalLabel.text = String(format: "%.2f", total)
    }
}

