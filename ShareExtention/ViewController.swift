//
//  ViewController.swift
//  ShareExtention
//
//  Created by pankaj on 05/01/18.
//  Copyright © 2018 Infostretch. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        openImagePicker()
        let userDefault = UserDefaults(suiteName: "group.infostretch.shareKitDemo")
        let sharedArray = userDefault?.object(forKey: "SharedArray")
        if sharedArray != nil {
            NSLog(sharedArray as! String, "a")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

//MARK: Imagepicker Methods
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openImagePicker() {
        //VNTextObservation
        let picker = UIImagePickerController()
        picker.delegate = self as UIImagePickerControllerDelegate & UINavigationControllerDelegate
        picker.sourceType = .photoLibrary
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard (info[UIImagePickerControllerOriginalImage] as? UIImage) != nil
            else {
                fatalError("no image from image picker")
        }
    }
}
