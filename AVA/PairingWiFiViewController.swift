//
//  PairingWiFiViewController.swift
//  AVA
//
//  Created by Jean Sarda on 23/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class PairingWiFiViewController: UIViewController {
    
    @IBOutlet weak var welcomeWifiLabel: UILabel!
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            nextButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            nextButton.backgroundColor = UIColor.clear
            nextButton.layer.borderWidth = 1.0
            nextButton.layer.cornerRadius = 8
            nextButton.layer.borderColor = UIColor.white.cgColor
            nextButton.tintColor = UIColor.white
            nextButton.setTitle("next".localized, for: .normal)
        }
    }
    
    @IBOutlet weak var iconImage: UIImageView! {
        didSet {
            iconImage.image = iconImage.image?.withRenderingMode(.alwaysTemplate)
            iconImage.tintColor = UIColor.white
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 255/255, green: 40/255, blue: 119/255, alpha: 1.0)
        self.navigationItem.title = "WiFi"
        welcomeWifiLabel.text = "welcome_wifi".localized
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
