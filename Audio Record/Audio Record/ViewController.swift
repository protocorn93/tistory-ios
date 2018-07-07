//
//  ViewController.swift
//  Audio Record
//
//  Created by 이동건 on 05/07/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController{
    
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder!
    var recordingSession: AVAudioSession!
    var timer:Timer!

    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup AudioSession for Recording
        recordingSession = AVAudioSession.sharedInstance()
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission{
                print("ACCEPTED")
            }
        }
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default, options: [.allowBluetooth, .allowBluetoothA2DP])
            try recordingSession.overrideOutputAudioPort(.speaker)
        }catch {
            print(error.localizedDescription)
        }
    }
    
    func getDirectory()->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    //MARK: Start Recording
    @IBAction func startRecord(_ sender: UIButton){
        // Setup UI state
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        playButton.isEnabled = false
        // initialize audioRecorder
        audioRecorder = nil
        // initialize time Label
        self.durationTimeLabel.text = "--:--"
        self.currentTimeLabel.text = "00:00"
        // Setup file storage directory
        let fileName = getDirectory().appendingPathComponent("MothersVoice.m4a")
        // Recorder Condition Settings
        let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        // setup Recorder
        do{
            audioRecorder = try AVAudioRecorder(url: fileName, format: AVAudioFormat(settings: settings)!)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            // Record
            audioRecorder.record()
        }catch let error{
            print(error.localizedDescription)
        }

    }

    //MARK:- Stop Recording
    @IBAction func stopRecord(_ sender: UIButton){
        // Setup UI state
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        playButton.isEnabled = true
        // Stop
        audioRecorder.stop()
    }
    
    //MARK: Play recorded audio
    @IBAction func playRecord(_ sender: UIButton){
        if !audioRecorder.isRecording{
            // Setup UI state
            recordButton.isEnabled = false
            // Get Recorded Audio Directory
            let path = getDirectory().appendingPathComponent("MothersVoice.m4a")
            do {
                // Setup Audio Player
                audioPlayer = try AVAudioPlayer(contentsOf: path, fileTypeHint: "m4a")
                audioPlayer?.delegate = self
                audioPlayer?.volume = 1.0
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                setupTimer()
                self.updateTime(at: self.durationTimeLabel, time: audioPlayer?.duration ?? 0)
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
}
//MARK:- Timer
extension ViewController {
    //MARK: Update label
    func updateTime(at timeLabel: UILabel , time: TimeInterval){
        let minute = Int(time/60)
        let second = Int(time.truncatingRemainder(dividingBy: 60))
        let currentTime = String(format: "%02ld:%02ld", minute, second)
        timeLabel.text = currentTime
    }
    
    //MARK: Setup Timer
    func setupTimer(){
        guard let audioPlayer = self.audioPlayer else {return}
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer) in
            self.updateTime(at: self.currentTimeLabel, time: audioPlayer.currentTime)
            self.timeSlider.value = Float(audioPlayer.currentTime)
            self.timeSlider.maximumValue = Float(audioPlayer.duration)
            self.timeSlider.minimumValue = 0
        })
        self.timer.fire()
    }
    
    //MARK: Timer to nil
    func invalidateTimer(){
        self.timer.invalidate()
        self.timer = nil
    }
}


//MARK:- Delegate
extension ViewController: AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // Setup UI state
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        // initialize time Label
        self.durationTimeLabel.text = "--:--"
        self.currentTimeLabel.text = "00:00"
        
        print("Finish Playing")
        invalidateTimer()
    }
    
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        print("Audio Play Decode Error")
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        print("Finish Recrding")
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        print("Audio Record Encode Error")
    }
}
