//
//  SecondViewController.swift
//  ConversionApp
//
//  Created by Cal Bass on 05/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit
import SwiftUI

class HistoryViewController: UIViewController {

    @IBOutlet var vStack: UIStackView!
    var currentUnitSelected = "Weight"
    
    
    @IBAction func toolbarPressed(_ sender: UIBarButtonItem) {
        currentUnitSelected = sender.title ?? "Weight"
        
        print("Button pressed")
        print(sender.title ?? "na")
        updateVStack()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateVStack()
    }
    
    private func updateVStack() {
        
        for view in vStack.subviews{
            view.removeFromSuperview()
        }
        
        let conversions = AppDefaults.getConversions(for: currentUnitSelected)
        
        if conversions.count == 0 {
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            label.center = CGPoint(x: 160, y: 285)
            label.textAlignment = .center
            label.text = "Sorry, no conversions here!"
            vStack.addArrangedSubview(label)
            return
        }
        
        var y = 30
        
        for conversion in conversions {
            let label = UITextView(frame: CGRect(x: 30, y: y, width: 350, height: 130))
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 19.0)
            label.text = "\(conversion.converted) converts too: \n \(conversion.data)"
            vStack.addSubview(label)
            y = y + 140
        }
        
        print("Updated")
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var test: UILabel!
    
}

