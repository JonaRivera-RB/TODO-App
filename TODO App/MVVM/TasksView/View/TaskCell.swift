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
        button.backgroundColor = .red
       
        return button
    }()
    
    private var titleTaskLabel: UILabel = {
        let title = UILabel()
        title.text = "title"
        title.numberOfLines = 0
        title.font = UIFont.boldSystemFont(ofSize: 20)
        title.textColor = .black
        
        return title
    }()
    
    private var dateTaskLabel: UILabel = {
        let title = UILabel()
        title.text = "date task"
        title.numberOfLines = 0
        title.font = UIFont.systemFont(ofSize: 14)
        title.textColor = .black
        
        return title
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
