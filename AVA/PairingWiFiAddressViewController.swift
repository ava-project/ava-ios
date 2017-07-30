//
//  PairingWiFiAddressViewController.swift
//  AVA
//
//  Created by Jean Sarda on 15/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class PairingWiFiAddressViewController: UIViewController {

    
    
    
    @IBOutlet weak var addressTextField: UITextField!
    
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            nextButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            nextButton.backgroundColor = UIColor.clear
            nextButton.layer.borderWidth = 1.0
            nextButton.layer.cornerRadius = 8
            nextButton.layer.borderColor = UIColor.white.cgColor
            nextButton.tintColor = UIColor.white
        }
    }
    
    @IBOutlet weak var iconImage: UIImageView! {
        didSet {
            iconImage.image = iconImage.image?.withRenderingMode(.alwaysTemplate)
            iconImage.tintColor = UIColor.white
        }
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        print("NEXT, value : \(addressTextField.text)")
        guard let addr = addressTextField.text else {
            return
        }
        guard addr != "" else {
            //TODO: - show error
            return
        }
        
        let sb = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = sb.instantiateInitialViewController() as! HomeTabBarController
        let ptt = vc.childViewControllers.first as! AVAPushToTalkViewController
        ptt.address = addr
        self.navigationController?.pushViewController(vc, animated: true)
        //self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        addressTextField.delegate = self
        self.addObservers()
        self.view.backgroundColor = UIColor(red: 255/255, green: 40/255, blue: 119/255, alpha: 1.0)
        self.navigationItem.title = "WiFi"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func keyboardWillShow(_ notification: NSNotification?) {
        let kbRect = notification?.userInfo?["UIKeyboardBoundsUserInfoKey"] as! CGRect
        let kbHeight = kbRect.size.height
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomConstraint.constant = kbHeight + 20
        })
        
    }
    
    func keyboardWillHide(_ notification: NSNotification?) {
        UIView.animate(withDuration: 0.3, animations: {
            self.bottomConstraint.constant = 20
        })
    }

    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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


extension PairingWiFiAddressViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addressTextField.resignFirstResponder()
        return true
    }
    
}
