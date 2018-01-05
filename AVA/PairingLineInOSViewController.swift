//
//  PairingLineInOSViewController.swift
//  AVA
//
//  Created by Jean Sarda on 30/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class PairingLineInOSViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet var macOSButton: UIButton! {
        didSet {
            macOSButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            macOSButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            macOSButton.backgroundColor = UIColor.clear
            macOSButton.layer.borderWidth = 1.0
            macOSButton.layer.cornerRadius = 8
            macOSButton.layer.borderColor = UIColor.white.cgColor
            macOSButton.tintColor = UIColor.white
        }
    }
    @IBOutlet var windowsButton: UIButton! {
        didSet {
            windowsButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            windowsButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            windowsButton.backgroundColor = UIColor.clear
            windowsButton.layer.borderWidth = 1.0
            windowsButton.layer.cornerRadius = 8
            windowsButton.layer.borderColor = UIColor.white.cgColor
            windowsButton.tintColor = UIColor.white
        }
    }
    @IBOutlet var linuxButton: UIButton! {
        didSet {
            linuxButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            linuxButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            linuxButton.backgroundColor = UIColor.clear
            linuxButton.layer.borderWidth = 1.0
            linuxButton.layer.cornerRadius = 8
            linuxButton.layer.borderColor = UIColor.white.cgColor
            linuxButton.tintColor = UIColor.white
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 255/255, green: 40/255, blue: 119/255, alpha: 1.0)
        welcomeLabel.text = "welcome_line_in".localized
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
