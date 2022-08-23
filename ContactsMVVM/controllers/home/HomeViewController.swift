//
//  HomeViewController.swift
//  ContactsMVVM
//
//  Created by Avaz Mukhitdinov on 13/08/22.
//

import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        viewModel.apiPostList()
    }

    // MARK: - Methods
    
    func initView(){
        initNavs()
        bindViewModel()
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }

    func bindViewModel(){
        viewModel.controller = self
        viewModel.items.bind(to: self) {strongSelf, _ in
            strongSelf.tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    
    func initNavs() {
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Contacts"
    }
    
    func callCreateViewcontroller(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func callEditViewController(post: Contacts){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
        vc.viewModel.editContact = post
    }
    
    // MARK: -- Actions
    
    @objc func leftTapped() {
        viewModel.apiPostList()
    }
    
    @objc func rightTapped() {
        callCreateViewcontroller()
    }
    
    // MARK: -- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return viewModel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let item = viewModel.items.value[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("ContactTableViewCell", owner: self, options: nil)?.first as! ContactTableViewCell
        
        cell.nameLabel.text = item.name
        cell.phoneLabel.text = item.phone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, post: viewModel.items.value[indexPath.row])
        ])
    }
    
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, post: viewModel.items.value[indexPath.row])
        ])
    }
    
    
    
    // MARK: Contextual ACtions
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, post: Contacts)-> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Delete") { (action, swipeButtonView, completion) in
            print("Delete Here")
            
            completion(true)
            self.viewModel.apiPostDelete(post: post, handler: {isDeleted in
                if isDeleted{
                    self.viewModel.apiPostList()
                }
            })
        }
    }
    
    
    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath, post: Contacts)-> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("Complete Here")
            
            completion(true)
            self.callEditViewController(post: post)
        }
    }

}
