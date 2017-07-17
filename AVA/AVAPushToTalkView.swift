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
    
    var activityIndicatorView: UIActivityIndicatorView?
    
    @IBAction func actionButtonDown(_ sender: Any) {
        delegate?.pushToTalkView(didReceiveTouchDown: true)
       /* UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = UIColor(red: 255/255, green: 40/255, blue: 119/255, alpha: 0.5)
        })*/
    }
    
    @IBAction func actionButtonUpInside(_ sender: Any) {
        delegate?.pushToTalkView(didReceiveTouchUp: true)
       /* UIView.animate(withDuration: 0.1, animations: {
            self.backgroundColor = UIColor.clear
        })*/
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
