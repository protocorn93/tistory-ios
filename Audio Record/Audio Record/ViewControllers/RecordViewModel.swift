//
//  ViewModel.swift
//  Audio Record
//
//  Created by 이동건 on 07/07/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import Foundation
import AVKit

class RecordViewModel:NSObject {
    var audioPlayer: AVAudioPlayer?
    var audioRecorder: AVAudioRecorder!
    var recordingSession: AVAudioSession!
    var timer:Timer!
    
    var currentTime:String? {
        didSet{
            updateCurrentTime?(currentTime)
        }
    }
    
    var duration:String? {
        didSet{
            updateDurationTime?(duration)
        }
    }
    
    var sliderMaxmimum:Float = 0 {
        didSet{
            setupSlider?(sliderMaxmimum)
        }
    }
    
    var sliderValue:Float = 0 {
        didSet{
            updateSliderValue?(sliderValue)
        }
    }
    
    var isEndPlaying: Bool = false{
        didSet{
            if isEndPlaying {
                didEndPlaying?()
            }
        }
    }
    // Binding Closure
    var updateCurrentTime:((String?)->())?
    var updateDurationTime:((String?)->())?
    var setupSlider:((Float)->())?
    var updateSliderValue:((Float)->())?
    var didEndPlaying:(()->())?
    override init() {
        super.init()
        setupAudioSession()
    }
    
    func setupAudioSession(){
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
    
    func startRecording(){
        audioRecorder = nil
        // initialize time Label
        currentTime = "00:00"
        duration = "--:--"
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
    
    func stopRecording(){
        audioRecorder.stop()
    }
    
    func playRecording(){
        let path = getDirectory().appendingPathComponent("MothersVoice.m4a")
        isEndPlaying = false
        do {
            // Setup Audio Player
            audioPlayer = try AVAudioPlayer(contentsOf: path, fileTypeHint: "m4a")
            audioPlayer?.delegate = self
            audioPlayer?.volume = 1.0
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
            setupTimer()
            duration = updateTime(time: audioPlayer?.duration ?? 0)
        } catch let error as NSError {
            print("audioPlayer error: \(error.localizedDescription)")
        }
    }
    
    fileprivate func getDirectory()->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
}

extension RecordViewModel {
    //MARK: Update label
    func updateTime(time: TimeInterval) -> String{
        let minute = Int(time/60)
        let second = Int(time.truncatingRemainder(dividingBy: 60))
        let displayTime = String(format: "%02ld:%02ld", minute, second)
        return displayTime
    }
    
    //MARK: Setup Timer
    func setupTimer(){
        guard let audioPlayer = self.audioPlayer else {return}
        self.sliderMaxmimum = Float(audioPlayer.duration)
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer) in
            self.currentTime = self.updateTime(time: audioPlayer.currentTime)
            self.sliderValue = Float(audioPlayer.currentTime)
        })
        self.timer.fire()
    }
    
    //MARK: Timer to nil
    func invalidateTimer(){
        self.timer.invalidate()
        self.timer = nil
    }
}

extension RecordViewModel: AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        // initialize time Label
        duration = "--:--"
        currentTime = "00:00"
        invalidateTimer()
        isEndPlaying = true
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

