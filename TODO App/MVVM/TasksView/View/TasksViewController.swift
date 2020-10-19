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
        button.setImage(UIImage(named: "add"), for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        button.tintColor = .white
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
        table.sectionHeaderHeight = UITableView.automaticDimension
        table.estimatedSectionHeaderHeight = 25
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
    
    private var emptyMessageTittleLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstans.ups
        label.font = UIFont.boldSystemFont(ofSize: 35)
        return label
    }()
    
    private var emptyMessageBodyLabel: UILabel = {
        let label = UILabel()
        label.text = AppConstans.emptyTableViewMessage
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private var warningImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "piso-mojado")
        return image
    }()
    
    private var tasksViewModel = TasksViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    private var isSearchMode: Bool {
        return searchController.isActive && !searchController.searchBar.text!.isEmpty
    }
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar(largeTitleColor: .white, backgoundColor: AppConstans.Colors.mainColor.hexStringToUIColor(), tintColor: .white, title: AppConstans.mainTitle, preferredLargeTitle: true)
        
        setupSearchControllerInNavigationController()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        tasksViewModel.retriveTasksList()
        bind()
    }
    
    //MARK: - UI
    private func configureUI() {
        
        view.backgroundColor = AppConstans.Colors.backgroundColorForViews.hexStringToUIColor()
        
        view.addSubview(tableView)
        tableView.anchor(top: self.view.safeAreaLayoutGuide.topAnchor, left: self.view.leftAnchor, bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor)
        
        view.addSubview(addTaskButton)
        addTaskButton.anchor(bottom: self.view.safeAreaLayoutGuide.bottomAnchor, right: self.view.rightAnchor, paddingBottom: 20, paddingRight: 20)
        
        let stackMessageEmptyTasks = UIStackView(arrangedSubviews: [emptyMessageTittleLabel, emptyMessageBodyLabel])
        stackMessageEmptyTasks.axis = .vertical
        stackMessageEmptyTasks.distribution = .equalCentering
        stackMessageEmptyTasks.alignment = .center
        stackMessageEmptyTasks.spacing = 10
        
        view.addSubview(stackMessageEmptyTasks)
        stackMessageEmptyTasks.center(inView: view)
        
        view.addSubview(warningImage)
        warningImage.centerX(inView: view)
        warningImage.anchor(bottom: stackMessageEmptyTasks.topAnchor, paddingBottom: 10, width: 80, height: 100)
        
    }
    
    private func setupSearchControllerInNavigationController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        let scb = searchController.searchBar
        scb.tintColor = UIColor.white
        scb.barTintColor = UIColor.white
        
        if let textfield = scb.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.white
            textfield.backgroundColor = UIColor.white
            
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
            
        }
        
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = AppConstans.Colors.mainColor.hexStringToUIColor()
        }
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    //MARK: - Helpers
    private func bind() {
        tasksViewModel.refreshData = { [weak self] in
            self?.tableView.isHidden = self?.tasksViewModel.tasks.count ?? 0 > 0 ? false : true
            self?.warningImage.isHidden = self?.tasksViewModel.tasks.count ?? 0 > 0 ? true : false
            self?.emptyMessageTittleLabel.isHidden = self?.tasksViewModel.tasks.count ?? 0 > 0 ? true : false
            self?.emptyMessageBodyLabel.isHidden = self?.tasksViewModel.tasks.count ?? 0 > 0 ? true : false
            self?.tableView.reloadData()
        }
    }
    
    //MARK: - Handle
    @objc func searchTask() {
        
    }
    
    @objc func addTaskButtonTapped() {
        let controller = AddTaskViewController()
        
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
}


//MARK: - UITableViewDataSource, UITableViewDelegate
extension TasksViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let labelText = tasksViewModel.nameForSections[section]
        let rect = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 44)
        let header = UIView(frame:rect)
        header.backgroundColor = UIColor.clear
        
        let label = UILabel()
        label.text = labelText
        label.textColor = .lightGray
        label.font = UIFont(name: "Avenir-Black", size: 20) ?? UIFont.boldSystemFont(ofSize: 20)
        header.addSubview(label)
        label.centerY(inView: header, paddingLeft: 10)
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return isSearchMode ? 1 : tasksViewModel.tasks.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isSearchMode ? tasksViewModel.filteredTask.count : tasksViewModel.tasks[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? TaskCell else { fatalError() }
        
        cell.task = isSearchMode ? tasksViewModel.filteredTask[indexPath.row] : tasksViewModel.tasks[indexPath.section][indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sizeheightHeader = 40
        return CGFloat(sizeheightHeader)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        let sizeHeightFooter = 40
        return CGFloat(sizeHeightFooter)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sizeHeight = 80
        return CGFloat(sizeHeight)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .none
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "DELETE") { (contextualAction, view, boolValue) in
            self.tasksViewModel.removeTask(task: self.tasksViewModel.tasks[indexPath.section][indexPath.row])
            self.bind()
        }
        
        let addAction = UIContextualAction(style: .normal, title: "COMPLETED") { (contextualAction, view, boolValue) in
            self.tasksViewModel.completeTask(task: self.tasksViewModel.tasks[indexPath.section][indexPath.row])
            self.bind()
        }
        
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        addAction.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        
        let swipeActions = UISwipeActionsConfiguration(actions: [ deleteAction, addAction])
        
        return swipeActions
    }
}

extension TasksViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        tasksViewModel.filteredTask = tasksViewModel.tasks[0].filter({ ($0.taskDescription?.contains(searchText) ?? false)
        })
        
        bind()
    }
    
}
