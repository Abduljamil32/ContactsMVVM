//
//  EditViewController.swift
//  ContactsMVVM
//
//  Created by Avaz Mukhitdinov on 13/08/22.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var newNameTex: UITextField!
    @IBOutlet weak var newPhoneText: UITextField!
    var viewModel = EditViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }

    func initView(){
        newNameTex.text = viewModel.editContact?.name
        newPhoneText.text = viewModel.editContact?.phone
    }
    
    // MARK: - Actions

    
    @IBAction func editTapped(_ sender: Any) {
        viewModel.apiEditPost(post: Contacts(id: (viewModel.editContact?.id!)!,name: newNameTex.text!, phone: newPhoneText.text!))
        self.navigationController?.dismiss(animated: true)
    }
    
}
