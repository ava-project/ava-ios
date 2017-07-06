//
//  AVARTMPStreamer.swift
//  AVA
//
//  Created by Jean Sarda on 18/06/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import AVFoundation
import lf

class AVARTMPStreamer {

    let connection: RTMPConnection = RTMPConnection()
    var stream: RTMPStream?
    
    required init(settings: AVAStreamerSettings) {
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeAudio)
        stream = RTMPStream(connection: connection)
        stream?.audioSettings = [
            "muted": false,
            "bitrate": settings.bitRate,
            "sampleRate": settings.sampleRate
        ]
        stream?.recorderSettings = [
            AVMediaTypeAudio: [
                AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                AVSampleRateKey: 0,
                AVNumberOfChannelsKey: 0
            ]
        ]
        stream?.attachAudio(captureDevice) { error in
            print("Error while attaching audio : \(error)")
        }
        connection.connect("rtmp://0.0.0.0/app", arguments: nil)
        stream?.publish("AVAstream")
        print("Started")
        
    }
    
    
    
}
