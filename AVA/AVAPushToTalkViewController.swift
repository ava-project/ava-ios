//
//  AVAStreamViewController.swift
//  AVA
//
//  Created by Jean Sarda on 18/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import Starscream
import AVFoundation
//import lf

enum AVAConnectionMode {
    case linein
    case socket
    case bluetooth
    case none
}

class AVAPushToTalkViewController: UIViewController {

    var recorder: AVARecorder?
    var address: String!
    var connectionMode: AVAConnectionMode = AVAConnectionMode.none
    
    var socket: WebSocket?
    var player: AVAudioPlayer?
    var failedRetries = 0
    
    
    
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recorder = AVARecorder()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        switch self.connectionMode {
        case .linein:
            self.initLineIn()
            break
        case .socket:
            self.initSocket()
            break
        default:
            break
        }
    }
    
    private func initLineIn() {
        
    }
    
    private func initSocket() {
        
        let servUrl = URL(string: String("ws://").appending(address))
        socket = WebSocket(url: servUrl!)
        socket?.delegate = self
        print("Connecting on \(servUrl?.absoluteString)")
        socket?.connect()
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
    
    func recorder(recorder: AVARecorder, didFailWhileEncoding: Bool) {
        
    }
    
    func recorder(recorder: AVARecorder, didFinishRecording: Bool, at filePath: URL) {
        do {
            let data = try Data(contentsOf: filePath)
            
            switch self.connectionMode {
            case .socket:
                socket?.write(data: data) {
                    print("data written")
                }
                break
            case .linein:
                do {
                    self.player = try AVAudioPlayer(data: data)
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                    try AVAudioSession.sharedInstance().setActive(true)
                    if let p = self.player {
                        p.play()
                    }
                } catch {
                    print("Error : \(error)")
                }
                
                break
            case .bluetooth:
                break
            case .none:
                break
            }
            
            //socket?.disconnect()
        } catch {
            print("Catched error \(error.localizedDescription)")
        }
        
        print("Recording ended")
    }
    
    
}

extension AVAPushToTalkViewController: WebSocketDelegate, WebSocketPongDelegate {
    
    func websocketDidConnect(socket: WebSocket) {
        print("Connected")
        failedRetries = 0
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("DidReceiveData")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("DidDisconnect with error : \(error.debugDescription)")
        self.infoLabel.text = "Sent!"
        /*DispatchQueue.main.asyncAfter(deadline: 0.5, execute: {
         self.activityIndicatorView.stopAnimating()
         self.infoLabel.isHidden = true
         })*/
        failedRetries += 1
        guard failedRetries < 5 else {
            // prompt error
            return
        }
        socket.connect()
        print("tried to reconnect")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("DidReceiveMessage on socket: \(socket.description) with text : \(text)")
    }
    
    func websocketDidReceivePong(socket: WebSocket, data: Data?) {
        print("PONG")
    }
    
}

