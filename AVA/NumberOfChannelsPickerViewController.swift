//
//  NumberOfChannelsPickerViewController.swift
//  AVA
//
//  Created by Jean Sarda on 06/10/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class NumberOfChannelsPickerViewController: UIViewController {
    
    @IBOutlet var picker: UIPickerView!
    
    let values: [Int] = [1, 2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        let currentValue = UserDefaults.standard.integer(forKey: "numberOfChannels")
        if let currentIndex = values.index(of: currentValue) {
            picker.selectRow(currentIndex, inComponent: 0, animated: false)
        }
    }
    
}

extension NumberOfChannelsPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(values[row])"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(values[row], forKey: "numberOfChannels")
    }
    
}
