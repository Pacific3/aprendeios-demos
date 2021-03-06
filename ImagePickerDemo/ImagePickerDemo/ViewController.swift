//
//  ViewController.swift
//  ImagePickerDemo
//
//  Created by Oscar Swanros on 11/5/16.
//  Copyright © 2016 Pacific3. All rights reserved.
//

import UIKit
import MobileCoreServices

private extension Selector {
    static let openPickerButtonTapped = #selector(ViewController.openPickerButtonTapped)
}

class ViewController: UIViewController {
    private lazy var openPickerButton: UIBarButtonItem = {
        let b = UIBarButtonItem(
            title: "Open Picker",
            style: .done,
            target: self, 
            action: .openPickerButtonTapped
        )
        return b
    }()
    
    fileprivate lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        return i
    }()

    fileprivate lazy var imagePicker: UIImagePickerController = {
        let i = UIImagePickerController()
        i.delegate = self
        return i
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = openPickerButton
        view.addSubview(imageView)
        
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: view.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
            ]
        )
    }
}


//MARK: - Objc Functions
extension ViewController {
    @objc
    fileprivate func openPickerButtonTapped() {
        let sheet = UIAlertController(
            title: "Open ImagePicker",
            message: "Select one...",
            preferredStyle: .actionSheet
        )
        sheet.addAction(UIAlertAction(title: "Camera Roll", style: .default, handler: { action in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        }))
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            sheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
                self.imagePicker.sourceType = .camera
                self.present(self.imagePicker, animated: true, completion: nil)
            }))
        }
        sheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(sheet, animated: true, completion: nil)
    }
}


//MARK: - Image Picker Delegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        defer {
            dismiss(animated: true, completion: nil)
        }
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
        imageView.image = image
    }
}
