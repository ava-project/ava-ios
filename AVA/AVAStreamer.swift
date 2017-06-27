//
//  AVAStreamer.swift
//  AVA
//
//  Created by Jean Sarda on 18/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import AVFoundation
import lf

class AVAStreamer {
    
    var settings: AVAStreamerSettings?
    var muted: Bool = false
    var rtmpStreamer: AVARTMPStreamer?
    
    //MARK: - Initializers
    required init(_ settings: AVAStreamerSettings) {
        self.settings = settings
        self.setupAudioSession()
    }
    
    deinit {
        
    }
    
    func connect() {
        guard let s = settings else {
            return
        }
        switch s.mode {
        case .rtmp:
            self.connectRTMP()
            break
        case .hls:
            self.connectHLS()
            break
        }
    }
    
    //MARK: - Private Setup
    
    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setPreferredSampleRate((self.settings?.sampleRate)!)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayAndRecord)
            try AVAudioSession.sharedInstance().setMode(AVAudioSessionModeDefault)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("ERROR THROWN while setting up Audio Session : \(error)")
        }
    }
    
    //MARK: - Private functions
    
    private func connectRTMP() {
        print("Starting RTMP connection")
        self.rtmpStreamer = AVARTMPStreamer(settings: self.settings!)
    }
    
    private func connectHLS() {
        let streamer = AVAHLSStreamer(settings: self.settings!)
    }
    
}

struct AVAStreamerSettings {
    let mode: AVAStreamerMode
    let sampleRate: Double // 44_100
    let bitRate: Int // 32*1024
    let url: URL
}

enum AVAStreamerMode {
    case rtmp
    case hls
}
