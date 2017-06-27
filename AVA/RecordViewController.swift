//
//  RecordViewController.swift
//  AVA
//
//  Created by Jean Sarda on 08/04/2017.
//  Copyright © 2017 Jean Sarda. All rights reserved.
//

import UIKit
import AudioKit

class RecordViewController: UIViewController {

    var recorder: AKNodeRecorder!
    var player: AKAudioPlayer!
    var tape: AKAudioFile!
    var micBooster: AKBooster!
    //var moogLadder: AKMoogLadder!
    var delay: AKDelay!
    var mic: AKMicrophone!
    
    var state = State.readyToRecord
    
    @IBOutlet var inputPlot: AKNodeOutputPlot!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var mainButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var loopButton: UIButton!
    
    
    enum State {
        case readyToRecord
        case recording
        case readyToPlay
        case playing
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // View setup
        
        // AudioKit setup
        AKAudioFile.cleanTempDirectory()
        /// Enum of available buffer lengths
        // shortest, very short, short, medium, long, very long, huge, longest
        /// from Shortest: 2 power 5 samples (32 samples = 0.7 ms @ 44100 kz)
        /// to Longest: 2 power 12 samples (4096 samples = 92.9 ms @ 44100 Hz)
        AKSettings.bufferLength = .long
        do {
            try AKSettings.setSession(category: .playAndRecord, with: .allowBluetoothA2DP)
        } catch {
            AKLog("Could not set audio session")
        }
        
        AKSettings.defaultToSpeaker = true
        
        // Patching
        mic = AKMicrophone()
        inputPlot.node = mic
        inputPlot.plotType = .buffer
        let micMixer = AKMixer(mic)
        micBooster = AKBooster(micMixer)

        // Set the lvl of mic monitoring
        micBooster.gain = 0
        recorder = try? AKNodeRecorder(node: micMixer)
        if let file = recorder.audioFile {
            player = try? AKAudioPlayer(file: file)
        }
        player.looping = true
        player.completionHandler = playingEnded
        
        //moogLadder = AKMoogLadder(player)
        
        let mainMixer = AKMixer(player, micBooster)

        
        AudioKit.output = mainMixer
        AudioKit.start()
        
        // setup ui
        setupUIForRecording()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playingEnded() {
        DispatchQueue.main.async {
            //self.setupUIForPlaying ()
        }
    }
    
    struct Constants {
        static let empty = ""
    }
    
    @IBAction func mainButtonTouched(_ sender: UIButton) {
        print("\(String(describing: player.audioFileBuffer))")

        switch state {
        case .readyToRecord :
            infoLabel.text = "Recording"
            mainButton.setTitle("Stop", for: .normal)
            state = .recording
            // microphone will be monitored while recording
            // only if headphones are plugged
            if AKSettings.headPhonesPlugged {
                micBooster.gain = 1
            }
            do {
                try recorder.record()
            } catch { print("Errored recording.") }
            
        case .recording :
            // Microphone monitoring is muted
            micBooster.gain = 0
            do {
                try player.reloadFile()
            } catch { print("Errored reloading.") }
            
            let recordedDuration = player != nil ? player.audioFile.duration  : 0
            if recordedDuration > 0.0 {
                recorder.stop()
                player.audioFile.exportAsynchronously(name: "TempTestFile.m4a",
                                                      baseDir: .documents,
                                                      exportFormat: .m4a) {_, exportError in
                                                        if let error = exportError {
                                                            print("Export Failed \(error)")
                                                        } else {
                                                            print("Export succeeded")
                                                        }
                }
                setupUIForPlaying ()
            }
        case .readyToPlay :
            player.play()
            infoLabel.text = "Playing..."
            mainButton.setTitle("Stop", for: .normal)
            state = .playing
        case .playing :
            player.stop()
            setupUIForPlaying()
        }
    }
    
    @IBAction func resetButtonTouched(_ sender: UIButton) {
        player.stop()
        do {
            try recorder.reset()
        } catch { print("Errored resetting.") }
        
        //try? player.replaceFile((recorder.audioFile)!)
        setupUIForRecording()
    }

    @IBAction func loopButtonTouched(_ sender: UIButton) {
        if player.looping {
            player.looping = false
            sender.setTitle("Loop is Off", for: .normal)
        } else {
            player.looping = true
            sender.setTitle("Loop is On", for: .normal)
            
        }
    }
    
    func setupUIForRecording () {
        state = .readyToRecord
        infoLabel.text = "Ready to record"
        mainButton.setTitle("Record", for: .normal)
        resetButton.isEnabled = false
        inputPlot.node = mic
        inputPlot.color = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        //resetButton.isHidden = true
        
        micBooster.gain = 0
    }
    
    func setupUIForPlaying () {
        let recordedDuration = player != nil ? player.audioFile.duration  : 0
        infoLabel.text = "Recorded: \(String(format: "%0.1f", recordedDuration)) seconds"
        mainButton.setTitle("Play", for: .normal)
        state = .readyToPlay
        //resetButton.isHidden = false
        resetButton.isEnabled = true
        inputPlot.node = player
        inputPlot.color = UIColor(red: 28/255, green: 29/255, blue: 25/255, alpha: 1.0)
        //frequencySlider.value = moogLadder.cutoffFrequency
        //resonanceSlider.value = moogLadder.resonance
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
