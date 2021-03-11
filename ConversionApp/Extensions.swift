//
//  Extensions.swift
//  ConversionApp
//
//  Created by Cal Bass on 10/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit



extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension Double {
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    public func prepare() -> String {
        var val = self
        val = val.rounded(toPlaces: AppDefaults.getDecimalPlaces())
        return String(val)
    }
    
}

extension String {
    public func prepare() -> String {
        var val = Double(self)!
        val = val.rounded(toPlaces: AppDefaults.getDecimalPlaces())
        return String(val)
    }
    
    
}

