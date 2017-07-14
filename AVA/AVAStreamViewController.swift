//
//  AVAStreamViewController.swift
//  AVA
//
//  Created by Jean Sarda on 18/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
//import lf

class AVAStreamViewController: UIViewController {

    let recorder = AVARecorder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pushTalkView = AVAPushTalkView(frame: view.frame)
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

extension AVAStreamViewController: AVAPushTalkViewDelegate {
    
    func pushTalkView(didReceiveTouchUp: Bool) {
        recorder.stop()
        
    }
    
    func pushTalkView(didReceiveTouchDown: Bool) {
        recorder.record()
    }
    
}
