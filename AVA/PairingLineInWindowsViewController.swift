//
//  PairingLineInWindowsViewController.swift
//  AVA
//
//  Created by Jean Sarda on 30/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class PairingLineInWindowsViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBAction func nextAction(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! HomeTabBarController
        let ptt = vc.childViewControllers.first as! AVAPushToTalkViewController
        
        ptt.connectionMode = .linein
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        localize()
        navigationItem.title = "Windows"
    }
    
    private func localize() {
        firstLabel.text = "windows_pairing_1".localized
        secondLabel.text = "windows_pairing_2".localized
        nextButton.setTitle("next".localized, for: .normal)
    }

}
