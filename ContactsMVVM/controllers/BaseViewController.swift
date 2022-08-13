//
//  BaseViewController.swift
//  ContactsMVVM
//
//  Created by Avaz Mukhitdinov on 13/08/22.
//
import JGProgressHUD
import UIKit

class BaseViewController: UIViewController {
    
    let hud = JGProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func appDelegate()-> AppDelegate {
        return UIApplication.shared.delete as! AppDelegate
    }

    func sceneDelegate()-> SceneDelegate {
        return ((UIApplication.shared.connectedScenes.first!.delete as? SceneDelegate)!)
    }
    
    func showProgress(){
        if !hud.isVisible{
            hud.textLabel.text = "Loading..."
            hud.show(in: self.view)
        }
    }
    
    func hideProgress(){
        if hud.isVisible{
            hud.dismiss()
        }
    }
}
