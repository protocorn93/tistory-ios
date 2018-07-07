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
    
    var viewModel:RecordViewModel = {
        return RecordViewModel()
    }()

    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var durationTimeLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeViewModel()
    }
    
    //MARK: Initiailize ViewModel
    func initializeViewModel(){
        viewModel.updateCurrentTime = { [weak self] (time) in
            DispatchQueue.main.async {
                self?.currentTimeLabel.text = time
            }
        }
        
        viewModel.updateDurationTime = { [weak self] (time) in
            DispatchQueue.main.async {
                self?.durationTimeLabel.text = time
            }
        }
        
        viewModel.setupSlider = { [weak self] (max) in
            DispatchQueue.main.async {
                self?.timeSlider.maximumValue = max
                self?.timeSlider.minimumValue = 0
            }
        }
        
        viewModel.updateSliderValue = { [weak self] (time) in
            DispatchQueue.main.async {
                self?.timeSlider.value = time
            }
        }
        
        viewModel.didEndPlaying = { [weak self] in
            self?.recordButton.isEnabled = true
            self?.stopButton.isEnabled = false
            self?.playButton.isEnabled = true
        }
    }
    
    //MARK: Start Recording
    @IBAction func startRecording(_ sender: UIButton){
        // Setup UI state
        recordButton.isEnabled = false
        stopButton.isEnabled = true
        playButton.isEnabled = false
        
        viewModel.startRecording()
    }

    //MARK:- Stop Recording
    @IBAction func stopRecord(_ sender: UIButton){
        // Setup UI state
        recordButton.isEnabled = true
        stopButton.isEnabled = false
        playButton.isEnabled = true
        // Stop
        viewModel.stopRecording()
    }
    
    //MARK: Play recorded audio
    @IBAction func playRecord(_ sender: UIButton){
        // Setup UI state
        recordButton.isEnabled = false
        // Get Recorded Audio Directory
        viewModel.playRecording()
    }
}
