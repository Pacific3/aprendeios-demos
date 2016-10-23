//
//  NameViewController.swift
//  DelegateDemo
//
//  Created by Oscar Swanros on 10/16/16.
//  Copyright © 2016 Pacific3. All rights reserved.
//

import UIKit

class NameViewController: UIViewController {
    fileprivate lazy var nameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .gray
        l.textAlignment = .center
        l.text = "Tap \"Edit\" now"
        return l
    }()
    
    private lazy var editButton: UIBarButtonItem = UIBarButtonItem(
        title: "Edit",
        style: .done,
        target: self, 
        action: #selector(NameViewController.editButtonTapped)
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Name"
        
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.rightBarButtonItem = editButton
        
        view.addSubview(nameLabel)
        
        NSLayoutConstraint.activate(
            [
                nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
                nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                nameLabel.heightAnchor.constraint(equalToConstant: 40)
            ]
        )
    }
    
    @objc
    func editButtonTapped() {
        let edit = EditNameViewController()
        edit.delegate = self
        
        let vc = UINavigationController(rootViewController: edit)
        
        present(vc, animated: true, completion: nil)
    }
}

//extension NameViewController: EditNameViewControllerDelegate {
//    func editNameViewControllerDidCancel() {
//        dismiss(animated: true, completion: nil)
//    }
//    
//    func editNameViewControllerDidFinish(newName: String) {
//        nameLabel.text = newName
//        
//        dismiss(animated: true, completion: nil)
//    }
//}
