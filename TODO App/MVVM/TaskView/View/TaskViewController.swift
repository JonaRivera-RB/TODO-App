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
    
    //MARK: - Properties
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
        tfield.font = UIFont.boldSystemFont(ofSize: 25)
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
        button.setTitle(AppConstans.save, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor.white, for: .normal)
        
        return button
    }()
    
    private var taskDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .lightGray
        label.text = AppConstans.taskCompletionDate
        label.numberOfLines = 0
        return label
    }()
    
    private var separateView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        
        return view
    }()
    
    private var taskCompletionDate: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: UIControl.Event.valueChanged)
        return datePicker
    }()
    
    private lazy var errorView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.addSubview(errorLabel)
        errorLabel.center(inView: view)
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = AppConstans.errorDate
       return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: AppConstans.Colors.mainColor.hexStringToUIColor(), tintColor: .white, title: AppConstans.addTaskTitle, preferredLargeTitle: false)
        
        hideKeyboardWhenTappedAround()
        setupNavigationBar()
        setupUI()
        
        taskDescriptionLabel.becomeFirstResponder()
        taskDescriptionLabel.addDoneButtonOnKeyboard()
    }
    
    //MARK: - Functions
    private func setupUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(addTaskButton)
        addTaskButton.anchor( left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 20, paddingBottom: 20, paddingRight: 20, height: 50)
        
        view.addSubview(mainLabel)
        mainLabel.anchor(top: self.view.topAnchor, paddingTop: 15)
        mainLabel.centerX(inView: view)
        
        view.addSubview(taskDescriptionLabel)
        taskDescriptionLabel.heightAnchor.constraint(equalToConstant: 200).isActive = true
        taskDescriptionLabel.anchor(top: mainLabel.bottomAnchor, left: self.view.leftAnchor, right: self.view.rightAnchor, paddingTop: 20, paddingLeft: 10, paddingRight: 20)
        
        view.addSubview(separateView)
        separateView.anchor(top: taskDescriptionLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20, height: 1)
        
        view.addSubview(taskDateLabel)
        taskDateLabel.anchor(top: separateView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 20, paddingRight: 20)
        
        view.addSubview(taskCompletionDate)
        taskCompletionDate.anchor(top: taskDateLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingRight: 10)
        
        view.addSubview(errorView)
        errorView.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, height: 50)
        errorView.isHidden = true
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.barTintColor = AppConstans.Colors.mainColor.hexStringToUIColor()
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAction))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    
    //MARK: - Handlers
    @objc func cancelAction() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func datePickerValueChanged(sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        print("DEBUG date \(dateFormatter.string(from: sender.date))")
    }
}
