
//  Created by Cal Bass on 05/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit

class DistanceViewController: UIViewController {

    //Converts:
    //metre, km, mile, cm, mm, yard, inch
    
    let defaults = UserDefaults.standard
    
    //Stores the last value and last unit to be edited
    //Used when saving a conversion to register the base unit converted from
    var lastEditedUnit:String = ""
    var lastEditedValue:String = ""
    
    
    @IBOutlet weak var metreTextField: UITextField!
    @IBOutlet weak var kilometreTextField: UITextField!
    @IBOutlet weak var mileTextField: UITextField!
    @IBOutlet weak var centimetreTextField: UITextField!
    @IBOutlet weak var millimetreTextField: UITextField!
    @IBOutlet weak var yardTextField: UITextField!
    @IBOutlet weak var inchTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //These actions watch the text fields, if the content is edited
    //then set the last edited values and convert all other fields
    //using this fields unit and value
    @IBAction func metreInputChanged(_ sender: Any) {
        lastEditedUnit = " metres"
        lastEditedValue = metreTextField.text ?? "0"
        convertAllValues(input: metreTextField.text ?? "0", unit: UnitLength.meters)
    }
    
    @IBAction func kilometreInputChanged(_ sender: Any) {
        lastEditedUnit = "km"
        lastEditedValue = kilometreTextField.text ?? "0"
        convertAllValues(input: kilometreTextField.text ?? "0", unit: UnitLength.kilometers)
    }
    
    @IBAction func mileInputChanged(_ sender: Any) {
        lastEditedUnit = " miles"
        lastEditedValue = mileTextField.text ?? "0"
        convertAllValues(input: mileTextField.text ?? "0", unit: UnitLength.miles)
    }
    
    @IBAction func centimetreInputChanged(_ sender: Any) {
        lastEditedUnit = "cm"
        lastEditedValue = centimetreTextField.text ?? "0"
        convertAllValues(input: centimetreTextField.text ?? "0", unit: UnitLength.centimeters)
    }
    
    @IBAction func millimetreInputChanged(_ sender: Any) {
        lastEditedUnit = "mm"
        lastEditedValue = millimetreTextField.text ?? "0"
        convertAllValues(input: millimetreTextField.text ?? "0", unit: UnitLength.millimeters)
    }
    
    @IBAction func yardInputChanged(_ sender: Any) {
        lastEditedUnit = " yards"
        lastEditedValue = yardTextField.text ?? "0"
        convertAllValues(input: yardTextField.text ?? "0", unit: UnitLength.yards)
    }
    
    @IBAction func inchInputChanged(_ sender: Any) {
        lastEditedUnit = " inches"
        lastEditedValue = inchTextField.text ?? "0"
        convertAllValues(input: inchTextField.text ?? "0", unit: UnitLength.inches)
    }
    
    

    
    @IBAction func savePressed(_ sender: Any) {
        //If either is empty, no value to save or hasn't been edited
        if (lastEditedUnit == "" || lastEditedValue == "") {
            return
        }
        
        //Create a string to store all the other conversions and units
        let data = "\(metreTextField.text!)m = \(kilometreTextField.text!)km = \(mileTextField.text!) miles = \(centimetreTextField.text!)cm = \(millimetreTextField.text!)mm = \(yardTextField.text!) yards = \(inchTextField.text!)in"
        
        AppDefaults.saveConversion(unit: "Distance", converted: lastEditedValue + " " + lastEditedUnit, data: data)
        
        //Create alert to notify user
        self.present(AppDefaults.saveAlert(), animated: true, completion: nil)
    }
    
    
    //Convert any values into a measurement type to be converted to all other types
    func convertAllValues(input: String, unit: UnitLength) {
        let amountToConvert:Double? = Double(input)
        if let amountToConvert = amountToConvert {
            let measurement: Measurement<UnitLength> = Measurement(value: amountToConvert, unit: unit)
            convertToMetres(measurement)
            convertToKilometres(measurement)
            convertToMiles(measurement)
            convertToCentimetres(measurement)
            convertToMillimetres(measurement)
            convertToYards(measurement)
            convertToInches(measurement)
        }
        
    }
    
    
    //Store approproate values in their respective text fields and correct decimal places
    func convertToMetres(_ measurement:Measurement<UnitLength>) {
        metreTextField.text = measurement.converted(to: UnitLength.meters).value.prepare();
    }
    
    func convertToKilometres(_ measurement:Measurement<UnitLength>) {
        kilometreTextField.text = measurement.converted(to: UnitLength.kilometers).value.prepare();
    }
    
    func convertToMiles(_ measurement:Measurement<UnitLength>) {
        mileTextField.text = measurement.converted(to: UnitLength.miles).value.prepare();
    }
    
    func convertToCentimetres(_ measurement:Measurement<UnitLength>) {
        centimetreTextField.text = measurement.converted(to: UnitLength.centimeters).value.prepare();
    }
    
    func convertToMillimetres(_ measurement:Measurement<UnitLength>) {
        millimetreTextField.text = measurement.converted(to: UnitLength.millimeters).value.prepare();
    }
    
    func convertToYards(_ measurement:Measurement<UnitLength>) {
        yardTextField.text = measurement.converted(to: UnitLength.yards).value.prepare();
    }
    
    func convertToInches(_ measurement:Measurement<UnitLength>) {
        inchTextField.text = measurement.converted(to: UnitLength.inches).value.prepare();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.black.cgColor
    }


}

