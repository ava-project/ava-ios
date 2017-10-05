//
//  EncoderQualityPickerViewController.swift
//  AVA
//
//  Created by Jean Sarda on 06/10/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import AVFoundation

class EncoderQualityPickerViewController: UIViewController {
    
    @IBOutlet var picker: UIPickerView!
    
    let values: [AVAudioQuality] = [.min, .low, .medium, .high, .max]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        let currentValue = UserDefaults.standard.integer(forKey: "encoderQuality")
        var i: Int = 0
        for value in values {
            if value.rawValue == currentValue {
                picker.selectRow(i, inComponent: 0, animated: false)
                break
            }
            i = i + 1
        }
        
    }
    
}

extension EncoderQualityPickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return values.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "Min"
        case 1:
            return "Low"
        case 2:
            return "Medium"
        case 3:
            return "High"
        case 4:
            return "Max"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(values[row].rawValue, forKey: "encoderQuality")
    }
    
}
