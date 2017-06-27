//
//  PairingMainViewController.swift
//  AVA
//
//  Created by Jean Sarda on 23/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import Lottie

class PairingMainViewController: UIViewController {
    
    @IBOutlet weak var wifiButton: UIButton! {
        didSet {
            configure(button: wifiButton, color: UIColor.white)
        }
    }
    @IBOutlet weak var bluetoothButton: UIButton! {
        didSet {
            configure(button: bluetoothButton, color: UIColor.white)
        }
    }
    
    @IBOutlet weak var lineinButton: UIButton! {
        didSet {
            configure(button: lineinButton, color: UIColor.white)
        }
    }
    
    @IBOutlet weak var animHolder: UIView!
    var animView: LOTAnimationView?
    
    private func configure(button: UIButton, color: UIColor) {
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.backgroundColor = UIColor.clear
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 8
        button.layer.borderColor = color.cgColor
        button.tintColor = color
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(red: 255/255, green: 40/255, blue: 119/255, alpha: 1.0)
        self.navigationItem.title = "Pairing"
        //self.navigationItem.backBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        //self.navigationController?.navigationBar.backgroundColor = UIColor(red: 187/255, green: 29/255, blue: 88/255, alpha: 1.0)
        let anim = LOTAnimationView(name: "Watermelon")
    
        self.animView = anim
        self.animView?.contentMode = .scaleAspectFit
        self.animView?.backgroundColor = UIColor.clear

        self.animHolder.backgroundColor = UIColor.clear
        self.animHolder.addSubview(animView!)
        
        //let widthConstraint = NSLayoutConstraint(item: animView, attribute: .width, relatedBy: .equal, toItem: animHolder, attribute: .width, multiplier: 1, constant: 0).isActive = true
        //let heightConstraint = NSLayoutConstraint(item: animView, attribute: .height, relatedBy: .equal, toItem: animHolder, attribute: .height, multiplier: 1, constant: 0).isActive = true
        //self.play(anim: animView!)
        animView?.loopAnimation = true
        animView?.play()
    }
    
    func play(anim: LOTAnimationView) {
        print("Animation launched")
        anim.play(completion: { finished in
            self.play(anim: anim)
        })
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
