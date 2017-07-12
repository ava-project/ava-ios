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

    override func viewDidLoad() {
        super.viewDidLoad()
//        var rtmpStream: RTMPStream = RTMPStream(connection: )
/*        let url = URL(string: "http://jeansarda.com")
        let streamerSettings = AVAStreamerSettings(mode: .rtmp, sampleRate: 44_100, bitRate: 32 * 1024, url: url!)
        var streamer = AVAStreamer(streamerSettings)
        print("Starting...")
        streamer.connect()*/
        let pushTalkView = AVAPushTalkView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
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
