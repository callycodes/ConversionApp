//
//  AppDefaults.swift
//  ConversionApp
//
//  Created by Cal Bass on 10/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit

class AppDefaults {
    
    
    struct Conversion: Codable {
        var converted: String
        var data: String
        
        init(converted : String, data: String) {
            self.converted = converted
            self.data = data
        }
    }
    
    public static func setDecimalPlaces(places:Int) {
        UserDefaults.standard.set(places, forKey: "decimalPlaces")
    }
    
    public static func getDecimalPlaces() -> Int {
        var places = UserDefaults.standard.integer(forKey: "decimalPlaces")
        
        if places < 2 {
            places = 2
            setDecimalPlaces(places: 2)
        }
        
        return places
    }
    

    public static func saveAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Notification", message: "Your conversion has been saved!", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        return alert
    }
    
    public static func saveConversion(unit: String, converted: String, data: String){
        var conversionArray: [Conversion] = getConversions(for: unit)
        
        print("Conversion Current: " + String(conversionArray.count))
        
        if conversionArray.count >= 5 {
            conversionArray.removeLast()
        }
        
        conversionArray.insert(Conversion(converted: converted, data: data), at: 0)
        
        print("Now: " + String(conversionArray.count))
        let conversionData = try! JSONEncoder().encode(conversionArray)
        UserDefaults.standard.set(conversionData, forKey: "conversions-" + unit)
        
       

        
        
    }

        
    
        
    public static func getString(unit: String) -> String {
        let conversions = getConversions(for: unit)
        var data = ""
        for conversion:Conversion in conversions {
            data = data + "Converted: " + conversion.converted + " - To: " + conversion.data + " / "
        }
        return data
    }
    
    public static func getConversions(for unit: String) -> [Conversion] {
        guard let conversionData = UserDefaults.standard.data(forKey: "conversions-" + unit) else { return [] }
        let converionArray = try! JSONDecoder().decode([Conversion].self, from: conversionData)
        return converionArray
    }

}

