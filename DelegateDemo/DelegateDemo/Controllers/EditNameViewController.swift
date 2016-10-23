//
//  EditNameViewController.swift
//  DelegateDemo
//
//  Created by Oscar Swanros on 10/16/16.
//  Copyright © 2016 Pacific3. All rights reserved.
//

import UIKit

private extension Selector {
    static let saveButtonTapped = #selector(EditNameViewController.saveButtonTapped)
    
}

protocol EditNameViewControllerDelegate: class {
    func editNameViewControllerDidFinish(newName: String)
    func editNameViewControllerDidCancel()
}

class EditNameViewController: UIViewController {
    
    weak var delegate: EditNameViewControllerDelegate?
    
    private lazy var saveButton: UIBarButtonItem = UIBarButtonItem(
        title: "Save",
        style: .done, 
        target: self, 
        action: .saveButtonTapped
    )
    
    private lazy var nameTextField: UITextField = {
        let t = UITextField()
        t.translatesAutoresizingMaskIntoConstraints =  false
        return t
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationItem.rightBarButtonItem = saveButton
        navigationController?.navigationBar.isTranslucent = false
        
        view.addSubview(nameTextField)
        nameTextField.becomeFirstResponder()
        
        NSLayoutConstraint.activate(
            [
                nameTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: view.layoutMargins.top),
                nameTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                nameTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                nameTextField.heightAnchor.constraint(equalToConstant: 40)
            ]
        )
    }
    
    @objc
    fileprivate func saveButtonTapped() {
        delegate?.editNameViewControllerDidFinish(newName: nameTextField.text!)
    }
}
