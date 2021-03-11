
//  Created by Cal Bass on 05/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit

class VolumeViewController: UIViewController {

    //Converts:
    //UK gallon, litre, UK pint, fluid ounce, millilitre
    
    let defaults = UserDefaults.standard
    
    //Stores the last value and last unit to be edited
    //Used when saving a conversion to register the base unit converted from
    var lastEditedUnit:String = ""
    var lastEditedValue:String = ""
    
    
    @IBOutlet weak var gallonTextField: UITextField!
    @IBOutlet weak var litreTextField: UITextField!
    @IBOutlet weak var fluidOunceTextField: UITextField!
    @IBOutlet weak var millilitreTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //These actions watch the text fields, if the content is edited
    //then set the last edited values and convert all other fields
    //using this fields unit and value
    @IBAction func gallonInputChanged(_ sender: Any) {
        lastEditedUnit = "gallons"
        lastEditedValue = gallonTextField.text ?? "0"
        convertAllValues(input: gallonTextField.text ?? "0", unit: UnitVolume.gallons)
    }
    
    @IBAction func litreInputChanged(_ sender: Any) {
        lastEditedUnit = "litres"
        lastEditedValue = litreTextField.text ?? "0"
        convertAllValues(input: litreTextField.text ?? "0", unit: UnitVolume.liters)
    }
    
    @IBAction func fluidOunceInputChanged(_ sender: Any) {
        lastEditedUnit = "fluid ounces"
        lastEditedValue = fluidOunceTextField.text ?? "0"
        convertAllValues(input: fluidOunceTextField.text ?? "0", unit: UnitVolume.fluidOunces)
    }
    
    @IBAction func millilitresInputChanged(_ sender: Any) {
        lastEditedUnit = "ml"
        lastEditedValue = millilitreTextField.text ?? "0"
        convertAllValues(input: millilitreTextField.text ?? "0", unit: UnitVolume.milliliters)
    }
    
    

    
    @IBAction func savePressed(_ sender: Any) {
        //If either is empty, no value to save or hasn't been edited
        if (lastEditedUnit == "" || lastEditedValue == "") {
            return
        }
        
        //Create a string to store all the other conversions and units
        let data = "\(gallonTextField.text!) gallons = \(litreTextField.text!) litres = \(fluidOunceTextField.text!) fluid ounces = \(millilitreTextField.text!)ml"
        
        AppDefaults.saveConversion(unit: "Volume", converted: lastEditedValue + " " + lastEditedUnit, data: data)
        
        //Create alert to notify user
        self.present(AppDefaults.saveAlert(), animated: true, completion: nil)
    }
    
    
    //Convert any values into a measurement type to be converted to all other types
    func convertAllValues(input: String, unit: UnitVolume) {
        let amountToConvert:Double? = Double(input)
        if let amountToConvert = amountToConvert {
            let measurement: Measurement<UnitVolume> = Measurement(value: amountToConvert, unit: unit)
            convertToGallons(measurement)
            convertToLitres(measurement)
            convertToFluidOunces(measurement)
            convertToMillilitres(measurement)
        }
        
    }
    
    
    //Store approproate values in their respective text fields and correct decimal places
    func convertToGallons(_ measurement:Measurement<UnitVolume>) {
        gallonTextField.text = measurement.converted(to: UnitVolume.gallons).value.prepare();
    }
    
    func convertToLitres(_ measurement:Measurement<UnitVolume>) {
        litreTextField.text = measurement.converted(to: UnitVolume.liters).value.prepare();
    }
    
    func convertToFluidOunces(_ measurement:Measurement<UnitVolume>) {
        fluidOunceTextField.text = measurement.converted(to: UnitVolume.fluidOunces).value.prepare();
    }
    
    func convertToMillilitres(_ measurement:Measurement<UnitVolume>) {
        millilitreTextField.text = measurement.converted(to: UnitVolume.milliliters).value.prepare();
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.black.cgColor
    }


}

