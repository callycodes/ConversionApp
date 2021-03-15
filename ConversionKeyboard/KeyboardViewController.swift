//
//  KeyboardViewController.swift
//  ConversionKeyboard
//
//  Created by Cal Bass on 10/03/2021.
//  Copyright © 2021 Cally Codes. All rights reserved.
//


import UIKit

class KeyboardViewController: UIInputViewController {

    @IBOutlet var nextKeyboardButton: UIButton!
    
    @IBOutlet var buttons: [UIButton]!
    
    var proxy : UITextDocumentProxy!
    
    @IBOutlet var keyboardView: UIView!
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }
    
    @IBAction func nextKeyboardPressed(_ sender: UIButton) {
        advanceToNextInputMode()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        if let title = sender.titleLabel!.text {
            proxy.insertText(title)
        } else {
            return
        }
    }
    
    @IBAction func deletePressed(_ sender: Any) {
        proxy.deleteBackward()
    }
    
    func paintButtons() {
        
        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        proxy = textDocumentProxy as UITextDocumentProxy
        //self.nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)

        // Perform custom UI setup here
        
        loadInterface()
        paintButtons()
        
        /*self.nextKeyboardButton.addTarget(self, action: #selector(handleInputModeList(from:with:)), for: .allTouchEvents)*/
        
        
        
    }
    
    func loadInterface(){
        let keyboardNib = UINib(nibName: "KeyboardView", bundle: nil)
        keyboardView = keyboardNib.instantiate(withOwner: self, options: nil)        [0] as! UIView
       //keyboardView.frame.size = view.frame.size
        keyboardView.frame.size = CGSize(width: 320, height: 160)
        view.addSubview(keyboardView)
    }
    
    
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
        //self.nextKeyboardButton.setTitleColor(textColor, for: [])
    }

}
