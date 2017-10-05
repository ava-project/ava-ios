//
//  AVARecorder.swift
//  AVA
//
//  Created by Jean Sarda on 11/07/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import AVFoundation
import Starscream

protocol AVARecorderDelegate: class {
    
    func recorder(recorder: AVARecorder, didFinishRecording: Bool, at filePath: URL)
    func recorder(recorder: AVARecorder, didFailWhileEncoding: Bool)
    
}

class AVARecorder: NSObject {
    
    var recorder: AVAudioRecorder?
    var socket: WebSocket?
    var failedRetries = 0
    var delegate: AVARecorderDelegate?
    
    override init() {
        super.init()
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileUrl = path.appendingPathComponent("recording.wav")
        let session = AVAudioSession.sharedInstance()
        
        let d = UserDefaults.standard
        let sampleRate: Int = d.integer(forKey: "sampleRate")
        let channels: Int = d.integer(forKey: "numberOfChannels")
        let encoderQuality: Int = d.integer(forKey: "encoderQuality")
        
        do {
            
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
            try session.setActive(true)
            
            let settings = [
                AVFormatIDKey: Int(kAudioFormatLinearPCM),
                AVSampleRateKey: sampleRate,
                AVNumberOfChannelsKey: channels,
                AVEncoderAudioQualityKey: encoderQuality
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
        self.delegate?.recorder(recorder: self, didFinishRecording: flag, at: filePath)
        
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Error during recorder encode : \(error?.localizedDescription)")
    }
    
}
