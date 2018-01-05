//
//  PairingLineInLinuxViewController.swift
//  AVA
//
//  Created by Jean Sarda on 30/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class PairingLineInLinuxViewController: UIViewController {

    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func ubuntuAction(_ sender: Any) {
        let url = URL(string: "https://doc.ubuntu-fr.org/audio")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func debianAction(_ sender: Any) {
        let url = URL(string: "https://wiki.debian.org/fr/SoundConfiguration")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func fedoraAction(_ sender: Any) {
        let url = URL(string: "https://ask.fedoraproject.org/en/question/42921/how-do-i-configure-my-mic-on-f20/")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
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

        nextButton.setTitle("next".localized, for: .normal)
        titleLabel.text = "linux_pairing".localized
        navigationItem.title = "Linux"
    }

    

}
