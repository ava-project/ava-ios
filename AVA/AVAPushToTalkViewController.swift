//
//  AVAStreamViewController.swift
//  AVA
//
//  Created by Jean Sarda on 18/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import Starscream
//import lf

class AVAPushToTalkViewController: UIViewController {

    var recorder: AVARecorder?
    var address: String!
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recorder = AVARecorder(url: address)
        recorder?.delegate = self
        let pushTalkView = AVAPushToTalkView(frame: view.frame)
        pushTalkView.delegate = self
        self.view.addSubview(pushTalkView)
        self.activityIndicatorView.isHidden = true
        self.navigationItem.title = "Connected"
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
        UIView.animate(withDuration: 0.1, animations: {
            self.activityIndicatorView.stopAnimating()
            //self.activityIndicatorView.isHidden = true
            self.infoLabel.text = "Sending"
//            self.infoLabel.isHidden = true
        })

    }
    
    func pushToTalkView(didReceiveTouchDown: Bool) {
        recorder?.record()
        UIView.animate(withDuration: 0.1, animations: {
            self.activityIndicatorView.startAnimating()
            //self.activityIndicatorView.isHidden = false
            self.infoLabel.text = "Recording"
            self.infoLabel.isHidden = false
        })
    }
    
}

extension AVAPushToTalkViewController: AVARecorderDelegate {
    
    func recorder(recorder: AVARecorder, didConnectOn socket: WebSocket) {
        
    }
    
    func recorder(recorder: AVARecorder, didDisconnectOn socket: WebSocket, with error: NSError?) {
        self.infoLabel.text = "Sent!"
        /*DispatchQueue.main.asyncAfter(deadline: 0.5, execute: {
            self.activityIndicatorView.stopAnimating()
            self.infoLabel.isHidden = true
        })*/
    }
    
    func recorder(recorder: AVARecorder, didFailWhileEncoding: Bool) {
        
    }
    
    func recorder(recorder: AVARecorder, didReceivePong on: WebSocket) {
        
    }
    
    func recorder(recorder: AVARecorder, didReceiveData data: Data, on: WebSocket) {
        
    }
    
    func recorder(recorder: AVARecorder, didReceiveMessage message: String, on: WebSocket) {
        
    }
    
    func recorder(recorder: AVARecorder, didFinishRecording: Bool, at filePath: URL) {
        
    }
    
    
}
