
//  Created by Cal Bass on 05/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit

class SpeedViewController: UIViewController {

    //Converts
    //metres/sec, km/hour, miles/hour, nautical miles/hour (knot)
    
    let defaults = UserDefaults.standard
    
    //Stores the last value and last unit to be edited
    //Used when saving a conversion to register the base unit converted from
    var lastEditedUnit:String = ""
    var lastEditedValue:String = ""
    
    
    @IBOutlet weak var metresTextField: UITextField!
    @IBOutlet weak var kphTextField: UITextField!
    @IBOutlet weak var mphTextField: UITextField!
    @IBOutlet weak var knotsTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    //These actions watch the text fields, if the content is edited
    //then set the last edited values and convert all other fields
    //using this fields unit and value
    @IBAction func metresInputChanged(_ sender: Any) {
        lastEditedUnit = "metres/sec"
        lastEditedValue = metresTextField.text ?? "0"
        convertAllValues(input: metresTextField.text ?? "0", unit: UnitSpeed.metersPerSecond)
    }
    
    @IBAction func kphInputChanged(_ sender: Any) {
        lastEditedUnit = "kph"
        lastEditedValue = kphTextField.text ?? "0"
        convertAllValues(input: kphTextField.text ?? "0", unit: UnitSpeed.kilometersPerHour)
    }
    
    @IBAction func mphInputChanged(_ sender: Any) {
        lastEditedUnit = "mph"
        lastEditedValue = mphTextField.text ?? "0"
        convertAllValues(input: mphTextField.text ?? "0", unit: UnitSpeed.milesPerHour)
    }
    
    @IBAction func knotsInputChanged(_ sender: Any) {
        lastEditedUnit = "knots"
        lastEditedValue = knotsTextField.text ?? "0"
        convertAllValues(input: knotsTextField.text ?? "0", unit: UnitSpeed.knots)
    }
    
    

    
    @IBAction func savePressed(_ sender: Any) {
        //If either is empty, no value to save or hasn't been edited
        if (lastEditedUnit == "" || lastEditedValue == "") {
            return
        }
        
        //Create a string to store all the other conversions and units
        let data = "\(metresTextField.text!) metres/sec = \(kphTextField.text!)kph = \(mphTextField.text!) mph = \(knotsTextField.text!) knots"
        
        AppDefaults.saveConversion(unit: "Speed", converted: lastEditedValue + " " + lastEditedUnit, data: data)
        
        //Create alert to notify user
        self.present(AppDefaults.saveAlert(), animated: true, completion: nil)
    }
    
    
    //Convert any values into a measurement type to be converted to all other types
    func convertAllValues(input: String, unit: UnitSpeed) {
        let amountToConvert:Double? = Double(input)
        if let amountToConvert = amountToConvert {
            let measurement: Measurement<UnitSpeed> = Measurement(value: amountToConvert, unit: unit)
            convertToMetres(measurement)
            convertToKph(measurement)
            convertToMph(measurement)
            convertToKnots(measurement)
        }
        
    }
    
    
    //Store approproate values in their respective text fields and correct decimal places
    func convertToMetres(_ measurement:Measurement<UnitSpeed>) {
        metresTextField.text = measurement.converted(to: UnitSpeed.metersPerSecond).value.prepare();
    }
    
    func convertToKph(_ measurement:Measurement<UnitSpeed>) {
        kphTextField.text = measurement.converted(to: UnitSpeed.kilometersPerHour).value.prepare();
    }
    
    func convertToMph(_ measurement:Measurement<UnitSpeed>) {
        mphTextField.text = measurement.converted(to: UnitSpeed.milesPerHour).value.prepare();
    }
    
    func convertToKnots(_ measurement:Measurement<UnitSpeed>) {
        knotsTextField.text = measurement.converted(to: UnitSpeed.knots).value.prepare();
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.black.cgColor
    }


}

