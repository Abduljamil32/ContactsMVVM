//
//  CreateViewController.swift
//  ContactsMVVM
//
//  Created by Avaz Mukhitdinov on 13/08/22.
//

import UIKit

class CreateViewController: UIViewController {

    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    
    var viewModel = CreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    // MARK: - Navigation

    
    @IBAction func createTapped(_ sender: Any) {
        viewModel.apiCreatePost(post: Contacts(name: nameText.text!, phone: phoneText.text!), handler: {isCreated in
            if isCreated{
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
       
    }
    
}
