
//  Created by Cal Bass on 05/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit

class TemperatureViewController: UIViewController {

    
    let defaults = UserDefaults.standard
    
    //Stores the last value and last unit to be edited
    //Used when saving a conversion to register the base unit converted from
    var lastEditedUnit:String = ""
    var lastEditedValue:String = ""
    
    
    @IBOutlet weak var celsiusTextField: UITextField!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBOutlet weak var kelvinTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //These actions watch the text fields, if the content is edited
    //then set the last edited values and convert all other fields
    //using this fields unit and value
    @IBAction func celsiusInputChanged(_ sender: Any) {
        lastEditedUnit = "°C"
        lastEditedValue = celsiusTextField.text ?? "0"
        convertAllValues(input: celsiusTextField.text ?? "0", unit: UnitTemperature.celsius)
    }
    
    @IBAction func fahrenheitInputChanged(_ sender: Any) {
        lastEditedUnit = "°F"
        lastEditedValue = fahrenheitTextField.text ?? "0"
        convertAllValues(input: fahrenheitTextField.text ?? "0", unit: UnitTemperature.fahrenheit)
    }
    
    @IBAction func kelvinInputChanged(_ sender: Any) {
        lastEditedUnit = "Kelvin"
        lastEditedValue = kelvinTextField.text ?? "0"
        convertAllValues(input: kelvinTextField.text ?? "0", unit: UnitTemperature.kelvin)
    }
    
    

    
    @IBAction func savePressed(_ sender: Any) {
        //If either is empty, no value to save or hasn't been edited
        if (lastEditedUnit == "" || lastEditedValue == "") {
            return
        }
        
        //Create a string to store all the other conversions and units
        let data = "\(celsiusTextField.text!)°C = \(fahrenheitTextField.text!)°F = \(kelvinTextField.text!) Kelvin"
        
        AppDefaults.saveConversion(unit: "Temperature", converted: lastEditedValue + " " + lastEditedUnit, data: data)
        
        //Create alert to notify user
        self.present(AppDefaults.saveAlert(), animated: true, completion: nil)
    }
    
    
    //Convert any values into a measurement type to be converted to all other types
    func convertAllValues(input: String, unit: UnitTemperature) {
        let amountToConvert:Double? = Double(input)
        if let amountToConvert = amountToConvert {
            let measurement: Measurement<UnitTemperature> = Measurement(value: amountToConvert, unit: unit)
            convertToCelsius(measurement)
            convertToFahrenheit(measurement)
            convertToKelvin(measurement)
        }
        
    }
    
    
    //Store approproate values in their respective text fields and correct decimal places
    func convertToCelsius(_ measurement:Measurement<UnitTemperature>) {
        celsiusTextField.text = measurement.converted(to: UnitTemperature.celsius).value.prepare();
    }
    
    func convertToFahrenheit(_ measurement:Measurement<UnitTemperature>) {
        fahrenheitTextField.text = measurement.converted(to: UnitTemperature.fahrenheit).value.prepare();
    }
    
    func convertToKelvin(_ measurement:Measurement<UnitTemperature>) {
        kelvinTextField.text = measurement.converted(to: UnitTemperature.kelvin).value.prepare();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.black.cgColor
    }


}

