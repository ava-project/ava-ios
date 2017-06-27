//
//  SplashViewController.swift
//  AVA
//
//  Created by Jean Sarda on 09/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {

    @IBOutlet weak var viewOne: UIView!
    @IBOutlet weak var viewTwo: UIView!
    @IBOutlet weak var viewThree: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let animationView = LOTAnimationView(name: "A")
        self.viewOne.addSubview(animationView)
        animationView.play(completion: { finished in
            let V = LOTAnimationView(name: "V")
            self.viewTwo.addSubview(V)
            V.play(completion: { finished in
                let T = LOTAnimationView(name: "A")
                self.viewThree.addSubview(T)
                T.play(completion: { finished in
                    
                })
            })
            print("Animation finished")
            //self.performSegue(withIdentifier: segueIdentifier, sender: self)
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
