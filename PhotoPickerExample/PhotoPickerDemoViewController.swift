//
//  PhotoPickerDemoViewController.swift
//  PhotoPickerExample
//
//  Created by Ken Boreham on 7/30/19.
//  Copyright © 2019 Ken Boreham. All rights reserved.
//

import UIKit

class PhotoPickerDemoViewController: UIViewController {
    @IBOutlet private var photoView: UIImageView!
    @IBOutlet private var savedPhotosButton: UIButton!
    @IBOutlet private var photoLibraryButton: UIButton!
    @IBOutlet private var cameraButton: UIButton!
    
    private var picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        
        savedPhotosButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
        photoLibraryButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
    }
    
    @IBAction func openCamera(_ sender: Any) {
        picker.sourceType = .camera
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func openSavedPhotos(_ sender: Any) {
        picker.sourceType = .savedPhotosAlbum
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func openPhotoLibrary(_ sender: Any) {
        picker.sourceType = .photoLibrary
        present(picker, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let optionsView = segue.destination as? OptionsTableViewController else { return }
        optionsView.picker = picker
    }
}

extension PhotoPickerDemoViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let image = info[.editedImage] as? UIImage {
            photoView.image = image
        } else if let original = info[.originalImage] as? UIImage {
            photoView.image = original
        }
    }
}

// UIImagePickerController delegate property also requires conformance to
// both UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension PhotoPickerDemoViewController: UINavigationControllerDelegate {
}
