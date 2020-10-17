//
//  TaskViewController.swift
//  TODO App
//
//  Created by Jonathan Rivera Misael on 17/10/20.
//  Copyright © 2020 Jonathan Rivera. All rights reserved.
//

import Foundation
import UIKit

class TaskViewController: UIViewController {
    
    private var mainLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = AppConstans.whatAreYouPlanning
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var taskDescriptionLabel: UITextView = {
        let tfield = UITextView()
        tfield.keyboardType = .default
        tfield.font = UIFont.boldSystemFont(ofSize: 20)
        tfield.textColor = .black
        tfield.translatesAutoresizingMaskIntoConstraints = true
        tfield.sizeToFit()
        tfield.isScrollEnabled = true
        tfield.isEditable = true
        
        return tfield
    }()
    
    private lazy var addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppConstans.Colors.mainColor.hexStringToUIColor()
        button.setTitle("SAVE", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: AppConstans.Colors.mainColor.hexStringToUIColor(), tintColor: .white, title: AppConstans.addTaskTitle, preferredLargeTitle: false)
        
        hideKeyboardWhenTappedAround()
        setupNavigationBar()
        setupUI()
        
        taskDescriptionLabel.becomeFirstResponder()
        taskDescriptionLabel.addDoneButtonOnKeyboard()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(addTaskButton)
        addTaskButton.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 50)
        
        view.addSubview(mainLabel)
        mainLabel.anchor(top: self.view.topAnchor, paddingTop: 10)
        mainLabel.centerX(inView: view)
        
        view.addSubview(taskDescriptionLabel)
        taskDescriptionLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        taskDescriptionLabel.anchor(top: mainLabel.bottomAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 20)
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = AppConstans.Colors.mainColor.hexStringToUIColor()
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
}
