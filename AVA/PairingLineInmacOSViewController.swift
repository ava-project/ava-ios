//
//  PairingLineInmacOSViewController.swift
//  AVA
//
//  Created by Jean Sarda on 30/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class PairingLineInmacOSViewController: UIViewController {

    @IBOutlet weak var firstLabel: UILabel!
    @IBOutlet weak var secondLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        firstLabel.text = "mac_pairing_1".localized
        secondLabel.text = "mac_pairing_2".localized
        nextButton.setTitle("next".localized, for: .normal)
        navigationItem.title = "macOS"
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! HomeTabBarController
        let ptt = vc.childViewControllers.first as! AVAPushToTalkViewController

        ptt.connectionMode = .linein
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
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
