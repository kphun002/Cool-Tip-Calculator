//
//  SettingsViewController.swift
//  Cool Tip Calculator
//
//  Created by Karol Phung on 7/11/20.
//  Copyright © 2020 Karol Phung. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var defaultTipSegmentedControl: UISegmentedControl!
    @IBOutlet weak var splitNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let store = UserDefaults.standard
        
        let indexOfDefaultTip = store.integer(forKey: "indexOfDefaultTip")
        defaultTipSegmentedControl.selectedSegmentIndex = indexOfDefaultTip
        
        let defaultSplit = store.integer(forKey: "split")
        splitNumber.text = String(defaultSplit)
    }

    @IBAction func defaultTipChanged(_ sender: Any) {
        let indexOfDefaultTip = defaultTipSegmentedControl.selectedSegmentIndex
        
        let store = UserDefaults.standard
        store.set(indexOfDefaultTip, forKey: "indexOfDefaultTip")
        store.set(true, forKey: "defaultTipChanged")
    }
    
    @IBAction func decreaseDefaultSplit(_ sender: Any) {
        let split = Int(splitNumber.text!) ?? 0
        if (split > 1) {
            splitNumber.text = String(split - 1)
            
            let newSplit = splitNumber.text
            let store = UserDefaults.standard
            store.set(newSplit, forKey: "split")
            store.set(true, forKey: "defaultSplitChanged")
        }
    }
    
    @IBAction func increaseDefaultSplit(_ sender: Any) {
        let split = Int(splitNumber.text!) ?? 0
        splitNumber.text = String(split + 1)
        
        let newSplit = splitNumber.text
        let store = UserDefaults.standard
        store.set(newSplit, forKey: "split")
        store.set(true, forKey: "defaultSplitChanged")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
