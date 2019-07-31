//
//  OptionsTableViewController.swift
//  PhotoPickerExample
//
//  Created by Ken Boreham on 7/31/19.
//  Copyright © 2019 Ken Boreham. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    var picker: UIImagePickerController!
    
    // General options
    @IBOutlet private var allowsEditingSwitch: UISwitch!
    
    // Camera options
    @IBOutlet private var useFrontCameraSwitch: UISwitch!
    @IBOutlet private var flashSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allowsEditingSwitch.isOn = picker.allowsEditing
        
        configureCameraOptions()
    }
    
    func configureCameraOptions() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            useFrontCameraSwitch.isOn = false
            useFrontCameraSwitch.isEnabled = false
            flashSwitch.isOn = false
            flashSwitch.isEnabled = false
            return
        }
        
        picker.sourceType = .camera
        useFrontCameraSwitch.isOn = picker.cameraDevice == .front
        useFrontCameraSwitch.isEnabled = UIImagePickerController.isCameraDeviceAvailable(.front) && UIImagePickerController.isCameraDeviceAvailable(.rear)
        flashSwitch.isOn = picker.cameraFlashMode == .on
        updateFlashOption()
    }

    @IBAction private func allowsEditingChanged(_ sender: Any) {
        picker.allowsEditing = allowsEditingSwitch.isOn
    }
    
    @IBAction private func useFrontCameraChanged(_ sender: Any) {
        switch useFrontCameraSwitch.isOn {
        case true:
            picker.cameraDevice = .front
        case false:
            picker.cameraDevice = .rear
        }
        
        updateFlashOption()
    }
    
    private func updateFlashOption() {
        let available = UIImagePickerController.isFlashAvailable(for: picker.cameraDevice)
        flashSwitch.isEnabled = available
        if !available {
            flashSwitch.isOn = false
        }
    }
    
    @IBAction private func flashChanged(_ sender: Any) {
        switch flashSwitch.isOn {
        case true:
            picker.cameraFlashMode = .on
        case false:
            picker.cameraFlashMode = .off
        }
    }
    
    //================
    // Other Options
    //================
    // picker.cameraCaptureMode = .photo
    // picker.cameraOverlayView = nil
    // picker.cameraViewTransform = CGAffineTransform(a: 1.0, b: 0.5, c: 1.0, d: 0.5, tx: 1, ty: 1)
    
    // picker.imageExportPreset = .compatible
    // picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)
    // picker.showsCameraControls = true
    // picker.startVideoCapture()
    // picker.stopVideoCapture()
    // picker.takePicture()
    // picker.videoExportPreset = "what?"
    // picker.videoMaximumDuration = 10
    // picker.videoQuality = .type640x480
}
