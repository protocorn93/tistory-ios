//
//  DelegateViewController.swift
//  LetusGo-CodeDefragment
//
//  Created by 이동건 on 21/07/2018.
//  Copyright © 2018 이동건. All rights reserved.
//

import UIKit

class ImagePickerWrapper: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var onImagePicked: (UIImage?)->() = { _ in }
    
    func showImagePicker(on vc: UIViewController){
        let picker = UIImagePickerController()
        picker.delegate = self
        vc.present(picker, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let originalInfo = info[UIImagePickerController.InfoKey.originalImage]
        guard let originalImage = originalInfo as? UIImage else { return }
        onImagePicked(originalImage)
        picker.dismiss(animated: true, completion: nil)
    }
}

class DelegateViewController: UIViewController {
    
    var imagePicker: ImagePickerWrapper!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onLoadImage(){
        imagePicker = ImagePickerWrapper()
        imagePicker.showImagePicker(on: self)
        imagePicker.onImagePicked = { image in
            guard let image = image else { return }
        }
    }
}
