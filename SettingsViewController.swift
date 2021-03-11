//
//  SecondViewController.swift
//  ConversionApp
//
//  Created by Cal Bass on 05/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var decimalSlider: UISlider!
    
    @IBOutlet weak var currentText: UILabel!
    
    @IBAction func sliderChanged(_ sender: Any) {
        AppDefaults.setDecimalPlaces(places: Int(decimalSlider.value))
        currentText.text = "Currently set to: " + String(AppDefaults.getDecimalPlaces())
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        decimalSlider.value = Float(AppDefaults.getDecimalPlaces())
            
        currentText.text = "Currently set to: " + String(AppDefaults.getDecimalPlaces())
        // Do any additional setup after loading the view.
    }


}

