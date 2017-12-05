//
//  ViewController.swift
//  UserDefault-1
//
//  Created by 이동건 on 2017. 12. 5..
//  Copyright © 2017년 이동건. All rights reserved.
//

import UIKit

struct Setting {
    enum State:String{
        case Vibrate
        case Sound
        case Bright
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var vibrateSwitch: UISwitch!
    @IBOutlet weak var soundSwitch: UISwitch!
    @IBOutlet weak var brightSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setState()
    }
    
    func setState(){
        let userDefault = UserDefaults.standard
        if let vibrate = userDefault.value(forKey: Setting.State.Vibrate.rawValue),
            let sound = userDefault.value(forKey: Setting.State.Sound.rawValue),
            let bright = userDefault.value(forKey: Setting.State.Bright.rawValue){
            self.vibrateSwitch.isOn = vibrate as! Bool
            self.soundSwitch.isOn = sound as! Bool
            self.brightSlider.value = bright as! Float
        }else{
            // Default Value
            vibrateSwitch.isOn = true
            soundSwitch.isOn = true
            brightSlider.value = 0.5
        }
    }
}

extension ViewController {
    @IBAction func saveBtnTapped(_ sender: Any) {
        UserDefaults.standard.set(vibrateSwitch.isOn, forKey: Setting.State.Vibrate.rawValue)
        UserDefaults.standard.set(soundSwitch.isOn, forKey: Setting.State.Sound.rawValue)
        UserDefaults.standard.set(brightSlider.value, forKey: Setting.State.Bright.rawValue)
    
        navigationController?.popViewController(animated: true)
    }
}

