//
//  FirstViewController.swift
//  ConversionApp
//
//  Created by Cal Bass on 05/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//

import UIKit

class ConversionsViewController: UIViewController {

    @IBOutlet weak var WeightViewContainer: UIView!
    @IBOutlet weak var TemperatureViewContainer: UIView!
    @IBOutlet weak var DistanceViewContainer: UIView!
    @IBOutlet weak var SpeedViewContainer: UIView!
    @IBOutlet weak var VolumeViewContainer: UIView!
    
    @IBOutlet weak var ContainerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupContainers()
    }
    
    func setupContainers() {
        hideContainers()
        
        showView(WeightViewContainer)
    }
    
    func hideContainers() {
        WeightViewContainer.alpha = 0
        TemperatureViewContainer.alpha = 0
        DistanceViewContainer.alpha = 0
        SpeedViewContainer.alpha = 0
        VolumeViewContainer.alpha = 0
    }
    
    func showView(_ view:UIView) {
        view.alpha = 1
    }

    
    @IBAction func TemperatureButton(_ sender: Any) {
        hideContainers()
        showView(TemperatureViewContainer)
    }
    
    @IBAction func WeightButton(_ sender: Any) {
        hideContainers()
        showView(WeightViewContainer)
    }
    
    @IBAction func DistanceButton(_ sender: Any) {
        hideContainers()
        showView(DistanceViewContainer)
    }
    
    @IBAction func SpeedButton(_ sender: Any) {
        hideContainers()
        showView(SpeedViewContainer)
    }
    
    @IBAction func VolumeButton(_ sender: Any) {
        hideContainers()
        showView(VolumeViewContainer)
    }
    
}

