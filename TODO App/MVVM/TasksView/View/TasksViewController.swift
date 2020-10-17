//
//  ViewController.swift
//  TODO App
//
//  Created by Jonathan Rivera Misael on 16/10/20.
//

import UIKit

class TasksViewController: UIViewController {
    
    //MARK: - Properties
    private var addTaskButton: UIButton = {
        let button = UIButton(type: .system)
        button.setDimensions(width: 70, height: 70)
        button.layer.cornerRadius = 70 / 2
        button.backgroundColor = AppConstans.Colors.mainColor.hexStringToUIColor()
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 10
        button.layer.shadowColor = UIColor(white: 0.0, alpha: 0.45).cgColor
        button.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        button.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = AppConstans.Colors.backgroundColorForViews.hexStringToUIColor()
        table.register(TaskCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        
        return table
    }()
    
    private lazy var footerView: UIView = {
        
        let view = UIView()
        view.addSubview(footerLabel)
        view.backgroundColor = AppConstans.Colors.backgroundColorForViews.hexStringToUIColor()
        footerLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        footerLabel.centerX(inView: view)
        
        return view
    }()
    
    private var footerLabel: UILabel = {
        
        let label = UILabel()
        label.text = AppConstans.madeWith
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 15)
        
        return label
    }()

    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar(largeTitleColor: .white, backgoundColor: AppConstans.Colors.mainColor.hexStringToUIColor(), tintColor: .white, title: AppConstans.mainTitle, preferredLargeTitle: true)
        
        righBarbutton()
        configureUI()
    }
    
    
    //MARK: - Helpers
    private func configureUI() {
        
        view.backgroundColor = AppConstans.Colors.backgroundColorForViews.hexStringToUIColor()
        
        view.addSubview(tableView)
        
        tableView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor)
        
        view.addSubview(addTaskButton)
        
        addTaskButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingBottom: 20, paddingRight: 20)
    }
    
    private func righBarbutton() {
       let button = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchTask))
       navigationItem.rightBarButtonItem = button
   }
    
    
    //MARK: - Handle
    @objc func searchTask() {
        
    }
    
    @objc func addTaskButtonTapped() {
        let controller = TaskViewController()
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TaskCell else { fatalError() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sizeHeightFooter = 40
        return CGFloat(sizeHeightFooter)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
