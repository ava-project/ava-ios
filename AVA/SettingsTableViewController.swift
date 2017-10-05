//
//  SettingsTableViewController.swift
//  AVA
//
//  Created by Jean Sarda on 30/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var settings: [String] = ["sampleRate", "numberOfChannels", "encoderQuality"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingName = settings[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = settingName//NSLocalizedString(settingName, comment: "")

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingName = settings[indexPath.row]
        
        switch settingName {
        case "sampleRate":
            let vc = storyboard?.instantiateViewController(withIdentifier: "sampleRatePickerVC") as! SampleRatePickerViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "numberOfChannels":
            let vc = storyboard?.instantiateViewController(withIdentifier: "numberOfChannelsPickerVC") as! NumberOfChannelsPickerViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case "encoderQuality":
            let vc = storyboard?.instantiateViewController(withIdentifier: "encoderQualityPickerVC") as! EncoderQualityPickerViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
    }
    
}
