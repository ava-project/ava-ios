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
    
    
    @IBOutlet weak var instructionsLabel: UILabel! {
        didSet {
            instructionsLabel.text = "tap_and_hold_instruction".localized
        }
    }
    @IBOutlet weak var infoLabel: UILabel!
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pushTalkView = AVAPushToTalkView(frame: view.frame)
        pushTalkView.delegate = self
        self.view.addSubview(pushTalkView)
        self.activityIndicatorView.isHidden = true
        self.navigationItem.title = "Connexion ✅"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        recorder = AVARecorder()
        recorder?.delegate = self
        
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
    
}

extension AVAPushToTalkViewController: AVAPushToTalkViewDelegate {
    
    func pushToTalkView(didReceiveTouchUp: Bool) {
        if self.connectionMode == .socket {
            recorder?.stop()
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.activityIndicatorView.stopAnimating()
            self.infoLabel.text = "📨"
        })

    }
    
    func pushToTalkView(didReceiveTouchDown: Bool) {
        if self.connectionMode == .socket {
            recorder?.record()
        }
        UIView.animate(withDuration: 0.1, animations: {
            self.activityIndicatorView.startAnimating()
            self.infoLabel.text = "🎤"
            self.infoLabel.isHidden = false
        })
    }
    
}

extension AVAPushToTalkViewController: AVARecorderDelegate {
    
    func recorder(recorder: AVARecorder, didFailWhileEncoding: Bool) {
        
    }
    
    func recorder(recorder: AVARecorder, didFinishRecording: Bool, at filePath: URL) {
        print("Recording ended")
        do {
            let data = try Data(contentsOf: filePath)
            
            switch self.connectionMode {
            case .socket:
                socket?.write(data: data) {
                    print("data written")
                }
                break
            case .linein:
                /*do {
                    self.player?.pause()
                    self.player = try AVAudioPlayer(data: data)
                    try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
                    try AVAudioSession.sharedInstance().setActive(true)
                    if let p = self.player {
                        print("playing")
                        p.play()
                    }
                } catch {
                    print("Error : \(error)")
                }*/
                
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
        self.infoLabel.text = "📨 ✅!"
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

