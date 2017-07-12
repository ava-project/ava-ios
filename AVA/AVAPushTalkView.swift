//
//  AVAPushTalkView.swift
//  AVA
//
//  Created by Jean Sarda on 11/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

class AVAPushTalkView: NibSettable {
    
    let gestureRecognizer = UITapGestureRecognizer()
    
    let recorder = AVARecorder()
    
    var isRecording: Bool = false
    
    @IBOutlet weak var mainView: UIView!
    
    @IBAction func actionButtonTapped(_ sender: Any) {
        if isRecording {
            recorder.stop()
            isRecording = false
        } else {
            recorder.record()
            isRecording = true
        }
    }
    
    override func setupUI() {
        super.setupUI()
        gestureRecognizer.numberOfTapsRequired = 1

//        let touchGesture = UIGesture
        /*let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapView(_:)))
        tapGesture.delegate = self
        self.addGestureRecognizer(tapGesture)*/
    }
    
    func tapView(_ sender: UITapGestureRecognizer) {
        print("Received tap, state: \(sender.state)")
    }
    
}

extension AVAPushTalkView: UIGestureRecognizerDelegate {
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        print("shouldBegin")
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive press: UIPress) -> Bool {
        print("shouldReceive press")
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("shouldReceive touch")
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
