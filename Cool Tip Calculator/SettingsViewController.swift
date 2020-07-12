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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let store = UserDefaults.standard
        let indexOfDefaultTip = store.integer(forKey: "defaultTip")
        defaultTipSegmentedControl.selectedSegmentIndex = indexOfDefaultTip
    }

    @IBAction func defaultTipChanged(_ sender: Any) {
        let indexOfDefaultTip = defaultTipSegmentedControl.selectedSegmentIndex
        
        let store = UserDefaults.standard
        store.set(indexOfDefaultTip, forKey: "defaultTip")
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
