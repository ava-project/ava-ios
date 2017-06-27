//
//  AVAHLSStreamer.swift
//  AVA
//
//  Created by Jean Sarda on 18/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import AVFoundation

import lf

class AVAHLSStreamer {

    var stream: HTTPStream = HTTPStream()
    
    required init(settings: AVAStreamerSettings) {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
        
        stream.attachAudio(captureDevice) { error in
            print(error)
        }
        stream.audioSettings = [
            "muted": false,
            "bitrate": settings.bitRate,
            "sampleRate": settings.sampleRate
        ]
        stream.recorderSettings = [
            AVMediaTypeAudio: [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 0,
                AVNumberOfChannelsKey: 0
            ]
        ]
        stream.publish("AVAstream")
        
        var httpService:HLSService = HLSService(domain: "", type: "_http._tcp", name: "lf", port: 8080)
        httpService.startRunning()
        httpService.addHTTPStream(stream)
        
        print("Started")
        
    }
    
    
    
}
