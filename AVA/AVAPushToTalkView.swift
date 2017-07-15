//
//  AVAPushTalkView.swift
//  AVA
//
//  Created by Jean Sarda on 11/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit

protocol AVAPushToTalkViewDelegate: class {
    func pushToTalkView(didReceiveTouchDown: Bool)
    func pushToTalkView(didReceiveTouchUp: Bool)
}

class AVAPushToTalkView: NibSettable {
    
    var delegate: AVAPushToTalkViewDelegate?
    
    @IBOutlet weak var mainView: UIView!
    
    @IBAction func actionButtonDown(_ sender: Any) {
        delegate?.pushToTalkView(didReceiveTouchDown: true)
    }
    
    @IBAction func actionButtonUpInside(_ sender: Any) {
        delegate?.pushToTalkView(didReceiveTouchUp: true)
    }
    
    @IBAction func actionButtonUpOutside(_ sender: Any) {
        delegate?.pushToTalkView(didReceiveTouchUp: true)
    }
    
    
    override func setupUI() {
        super.setupUI()
    }
    
}

extension AVAPushToTalkView: UIGestureRecognizerDelegate {
    
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
