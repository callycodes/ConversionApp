//
//  SecondViewController.swift
//  ConversionApp
//
//  Created by Cal Bass on 05/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit

class WeightViewController: UIViewController {

    let defaults = UserDefaults.standard
    
    var lastEditedUnit:String = ""
    var lastEditedValue:String = ""
    
    @IBOutlet weak var kilogramsTextField: UITextField!
    @IBOutlet weak var gramsTextField: UITextField!
    @IBOutlet weak var ouncesTextField: UITextField!
    @IBOutlet weak var poundsTextField: UITextField!
    @IBOutlet weak var stonesTextField: UITextField!
    @IBOutlet weak var stonesPTextField: UITextField!
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    @IBAction func kilogramsInputChanged(_ sender: Any) {
        lastEditedUnit = "Kilograms"
        lastEditedValue = kilogramsTextField.text ?? "0"
        convertAllValues(input: kilogramsTextField.text ?? "0", unit: UnitMass.kilograms)
    }
    
    @IBAction func gramsInputChanged(_ sender: Any) {
        lastEditedUnit = "Grams"
        lastEditedValue = gramsTextField.text ?? "0"
        convertAllValues(input: gramsTextField.text ?? "0", unit: UnitMass.grams)
    }
    
    @IBAction func ouncesInputChanged(_ sender: Any) {
        lastEditedUnit = "Ounces"
        lastEditedValue = ouncesTextField.text ?? "0"
        convertAllValues(input: ouncesTextField.text ?? "0", unit: UnitMass.ounces)
    }
    
    @IBAction func poundsInputChanged(_ sender: Any) {
        lastEditedUnit = "Pounds"
        lastEditedValue = poundsTextField.text ?? "0"
         convertAllValues(input: poundsTextField.text ?? "0", unit: UnitMass.pounds)
    }
    
    @IBAction func stonesInputChanged(_ sender: Any) {
        let text = stonesTextField.text ?? "0"
        let textP = stonesPTextField.text ?? "0"
        lastEditedUnit = "Stone Pounds"
        lastEditedValue = text + "st " + textP + "lb"
        let total = convertStonesPoundsToStones(stones: text, pounds: textP)
        convertAllValues(input: total, unit: UnitMass.stones)
    }
    
    @IBAction func stonesPInputChanged(_ sender: Any) {
        
        let text = stonesTextField.text ?? "0"
        let textP = stonesPTextField.text ?? "0"
        lastEditedUnit = "Stone Pounds"
        lastEditedValue = text + "st " + textP + "lb"
        let total = convertStonesPoundsToStones(stones: text, pounds: textP)
        convertAllValues(input: total, unit: UnitMass.stones)
    }
    
    func convertStonesPoundsToStones(stones:String, pounds:String) -> String {
        let stonesVal = Measurement(value: Double(stones) ?? 0, unit: UnitMass.stones)
        let poundsVal = Measurement(value: Double(pounds) ?? 0, unit: UnitMass.pounds)
        let stoneTotal = stonesVal.value + poundsVal.converted(to: UnitMass.stones).value
        return String(stoneTotal)
    }
    
    @IBAction func savePressed(_ sender: Any) {
        if (lastEditedUnit == "" || lastEditedValue == "") {
            return
        }
        
        let data = "\(kilogramsTextField.text!)KG = \(gramsTextField.text!)g = \(ouncesTextField.text!) oz =  \(poundsTextField.text!) lb = " +
            stonesTextField.text! + "st " + stonesPTextField.text! + "lb"
        AppDefaults.saveConversion(unit: "Weight", converted: lastEditedValue + " " + lastEditedUnit, data: data)
        self.present(AppDefaults.saveAlert(), animated: true, completion: nil)
    }
    
    func convertAllValues(input: String, unit: UnitMass) {
        let amountToConvert:Double? = Double(input)
        if let amountToConvert = amountToConvert {
            let measurement: Measurement<UnitMass> = Measurement(value: amountToConvert, unit: unit)
            convertToKilograms(measurement)
            convertToGrams(measurement)
            convertToOunces(measurement)
            convertToPounds(measurement)
            convertToStones(measurement)
        }
        
    }
    
    func convertToKilograms(_ measurement:Measurement<UnitMass>) {
        kilogramsTextField.text = measurement.converted(to: UnitMass.kilograms).value.prepare();
    }
    
    func convertToGrams(_ measurement:Measurement<UnitMass>) {
        gramsTextField.text = measurement.converted(to: UnitMass.grams).value.prepare();
    }
    
    func convertToOunces(_ measurement:Measurement<UnitMass>) {
        ouncesTextField.text = measurement.converted(to: UnitMass.ounces).value.prepare();
    }
    
    func convertToPounds(_ measurement:Measurement<UnitMass>) {
        poundsTextField.text = measurement.converted(to: UnitMass.pounds).value.prepare();
    }
    
    func convertToStones(_ measurement:Measurement<UnitMass>) {
        let stones = measurement.converted(to: UnitMass.stones).value
        let poundsUnconverted = stones.truncatingRemainder(dividingBy: 1)
        let pounds = Measurement(value: poundsUnconverted, unit: UnitMass.stones).converted(to: UnitMass.pounds).value
        
        
        stonesTextField.text = String(format: "%.0f", floor(stones));
        stonesPTextField.text = pounds.prepare()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        // Do any additional setup after loading the view.
        saveButton.layer.borderWidth = 1
        saveButton.layer.borderColor = UIColor.black.cgColor
    }


}

