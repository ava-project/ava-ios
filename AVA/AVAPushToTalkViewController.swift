//
//  AVAStreamViewController.swift
//  AVA
//
//  Created by Jean Sarda on 18/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
//import lf

class AVAPushToTalkViewController: UIViewController {

    var recorder: AVARecorder?
    var address: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recorder = AVARecorder(url: address)
        let pushTalkView = AVAPushToTalkView(frame: view.frame)
        pushTalkView.delegate = self
        self.view.addSubview(pushTalkView)
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

extension AVAPushToTalkViewController: AVAPushToTalkViewDelegate {
    
    func pushToTalkView(didReceiveTouchUp: Bool) {
        recorder?.stop()
        
    }
    
    func pushToTalkView(didReceiveTouchDown: Bool) {
        recorder?.record()
    }
    
}
