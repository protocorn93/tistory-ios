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
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordingSession = AVAudioSession.sharedInstance()
        AVAudioSession.sharedInstance().requestRecordPermission { (hasPermission) in
            if hasPermission{
                print("ACCEPTED")
            }
        }
    }
    
    func getDirectory()->URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = paths[0]
        return documentDirectory
    }
    
    
    @IBAction func startRecord(_ sender: UIButton){
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        playButton.isEnabled = false
        audioRecorder = nil

        let fileName = getDirectory().appendingPathComponent("MothersVoice.m4a")
        let settings = [AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 12000, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue]
        
        do{
            audioRecorder = try AVAudioRecorder(url: fileName, format: AVAudioFormat(settings: settings)!)
            audioRecorder.delegate = self
            audioRecorder.prepareToRecord()
            let isRecording = audioRecorder.record()
            print(isRecording)
        }catch let error{
            print(error.localizedDescription)
        }

    }

    @IBAction func stopRecord(_ sender: UIButton){
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        playButton.isEnabled = true
        
        audioRecorder.stop()
//        audioRecorder = nil
    }
    
    @IBAction func playRecord(_ sender: UIButton){
        if audioRecorder.isRecording == false {
            recordButton.isEnabled = false
            
            let path = getDirectory().appendingPathComponent("MothersVoice.m4a")
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: path, fileTypeHint: AVFileType.m4a.rawValue)
                audioPlayer?.delegate = self
                print(audioPlayer?.duration)
                print(audioPlayer?.volume)
                audioPlayer?.volume = 1.0
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
                print(audioPlayer?.url)
            } catch let error as NSError {
                print("audioPlayer error: \(error.localizedDescription)")
            }
        }
    }
}

extension ViewController: AVAudioPlayerDelegate, AVAudioRecorderDelegate{
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        
        print("Finish Playing")
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
