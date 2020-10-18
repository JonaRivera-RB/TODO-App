//
//  TaskCell.swift
//  TODO App
//
//  Created by Jonathan Rivera Misael on 17/10/20.
//  Copyright © 2020 Jonathan Rivera. All rights reserved.
//

import Foundation
import UIKit

class TaskCell: UITableViewCell {
    
    //MARK: - Properties
    
    var task: TASK? {
        didSet {
            configure()
        }
    }
    private lazy var mainView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(white: 1.0, alpha: 0.4).cgColor
        view.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        view.layer.shadowOpacity = 0.27
        view.layer.shadowRadius = 3.0
        return view
    }()
    
    private var doneButton: UIButton = {
        let size: CGFloat = 20.0
        let button = UIButton(type: .system)
        button.setDimensions(width: size, height: size)
        button.layer.cornerRadius = size / 2
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius =  size / 2
        button.layer.masksToBounds = false
        
        return button
    }()
    
    private var titleTaskLabel: UILabel = {
        let title = UILabel()
        title.text = "title"
        title.numberOfLines = 0
        title.font = UIFont(name: "Avenir-Black", size: 20) ?? UIFont.boldSystemFont(ofSize: 30)
        title.textColor = .black
        
        return title
    }()
    
    private var dateTaskLabel: UILabel = {
        let date = UILabel()
        date.text = "date task"
        date.numberOfLines = 0
        date.font = UIFont(name: "Avenir-Medium", size: 14) ?? UIFont.boldSystemFont(ofSize: 30)
        date.textColor = .black
        
        return date
    }()
    
    private lazy var taskCompletedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = "#d14f9f".hexStringToUIColor().withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(white: 1.0, alpha: 0.4).cgColor
        view.layer.shadowColor = UIColor(white: 0.0, alpha: 0.5).cgColor
        view.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        view.layer.shadowOpacity = 0.27
        view.layer.shadowRadius = 3.0
        
        view.addSubview(taskCompleteLabel)
        taskCompleteLabel.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 5, paddingLeft: 5, paddingBottom: 5, paddingRight: 5)
        return view
    }()
    
    private var taskCompleteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Avenir-Black", size: 30) ?? UIFont.boldSystemFont(ofSize: 30)
        label.text = "COMPLETED"
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    //MARK: -Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = AppConstans.Colors.backgroundColorForViews.hexStringToUIColor()
        
        addSubview(mainView)
        mainView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        mainView.addSubview(doneButton)
        doneButton.anchor(left: mainView.leftAnchor, paddingLeft: 10)
        doneButton.centerY(inView: mainView)
        
        let stack = UIStackView(arrangedSubviews: [titleTaskLabel, dateTaskLabel])
        stack.axis = .vertical
        stack.spacing = 2
        
        mainView.addSubview(stack)
        stack.anchor(top: mainView.topAnchor, left: doneButton.rightAnchor, bottom: mainView.bottomAnchor, right: mainView.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
        
        addSubview(taskCompletedBackgroundView)
        taskCompletedBackgroundView.anchor(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, paddingTop: 5, paddingLeft: 10, paddingBottom: 5, paddingRight: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        guard let task = task else { return }
        let viewModel = TaskCellViewModel(task: task)
        
        titleTaskLabel.text = viewModel.description
        dateTaskLabel.text = viewModel.date
        doneButton.backgroundColor = viewModel.doneButtonBackgroundColor
        taskCompletedBackgroundView.isHidden = viewModel.isHiddenBackgroundView
    }
}
