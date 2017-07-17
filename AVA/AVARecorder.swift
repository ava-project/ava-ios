//
//  AVARecorder.swift
//  AVA
//
//  Created by Jean Sarda on 11/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import AVFoundation
import Starscream
import SocketRocket

protocol AVARecorderDelegate: class {
    
    func recorder(recorder: AVARecorder, didFinishRecording: Bool, at filePath: URL)
    func recorder(recorder: AVARecorder, didFailWhileEncoding: Bool)
    func recorder(recorder: AVARecorder, didConnectOn socket: WebSocket)
    func recorder(recorder: AVARecorder, didDisconnectOn socket: WebSocket, with error: NSError?)
    func recorder(recorder: AVARecorder, didReceivePong on: WebSocket)
    func recorder(recorder: AVARecorder, didReceiveData data: Data, on: WebSocket)
    func recorder(recorder: AVARecorder, didReceiveMessage message: String, on: WebSocket)
    
}

class AVARecorder: NSObject {
    
    var recorder: AVAudioRecorder?
    var socket: WebSocket?
    var failedRetries = 0
    var delegate: AVARecorderDelegate?
    
    init(url: String) {
        super.init()
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = path.appendingPathComponent("recording.wav")
        let session = AVAudioSession.sharedInstance()
        
        let servUrl = URL(string: "ws://\(url)")
        socket = WebSocket(url: servUrl!)
        socket?.delegate = self
        print("Connecting on \(servUrl?.absoluteString)")
        socket?.connect()
        
        do {
            
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
            let settings = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVSampleRateKey: 44100,
                AVNumberOfChannelsKey: 2,
                AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
            ]
            
            recorder = try AVAudioRecorder(url: fileUrl, settings: settings)
            recorder?.delegate = self
        } catch {
            print("err : \(error)")
        }
    }
    
    deinit {
        
    }
    
    func record() {
        recorder?.record()
    }
    
    func stop() {
        recorder?.stop()
    }
    
}

extension AVARecorder: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        let filePath = recorder.url
        do {
            let data = try Data(contentsOf: filePath)
            
            socket?.write(data: data) {
                print("data written")
            }

            //socket?.disconnect()
        } catch {
            print("Catched error \(error.localizedDescription)")
        }
        
        print("Recording ended")
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Error during recorder encode : \(error?.localizedDescription)")
    }
    
}

extension AVARecorder: WebSocketDelegate, WebSocketPongDelegate {
    
    func websocketDidConnect(socket: WebSocket) {
        print("Connected")
        failedRetries = 0
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        print("DidReceiveData")
    }
    
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("DidDisconnect with error : \(error.debugDescription)")
        self.delegate?.recorder(recorder: self, didDisconnectOn: socket, with: error)
        failedRetries += 1
        guard failedRetries < 5 else {
            // prompt error
            return
        }
        socket.connect()
        print("tried to reconnect")
    }
    
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("DidReceiveMessage with text : \(text)")
    }
    
    func websocketDidReceivePong(socket: WebSocket, data: Data?) {
        print("PONG")
    }
    
}
