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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let store = UserDefaults.standard
        
        let showLastBill = store.bool(forKey: "showLastBill")
        let indexOfDefaultTip = store.integer(forKey: "indexOfDefaultTip")
        let defaultTipChanged = store.bool(forKey: "defaultTipChanged")
        
        if (showLastBill) {
            let lastBill = store.double(forKey: "lastBill")
            billField.text = String(format: "%.2f", lastBill)
        }
        
        if (defaultTipChanged) {
            tipControl.selectedSegmentIndex = indexOfDefaultTip
            calculateTip()
            store.set(false, forKey: "defaultTipChanged")
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
        calculateTip()
    }
    
    fileprivate func calculateTip() {
        let bill = Double(billField.text!) ?? 0
        
        let tipPercentages = [0.15, 0.18, 0.2]
        
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
}

