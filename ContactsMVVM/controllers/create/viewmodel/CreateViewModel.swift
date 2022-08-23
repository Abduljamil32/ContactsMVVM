//
//  CreateViewModel.swift
//  ContactsMVVM
//
//  Created by Avaz Mukhitdinov on 13/08/22.
//

import Foundation
import Bond

class CreateViewModel{
    var controller: BaseViewController!
    
    func apiCreatePost(post: Contacts, handler: @escaping (Bool)-> Void){
        controller?.showProgress()
        AFHttp.post(url: AFHttp.API_POST_CREATE, params: AFHttp.paramsPostCreate(post: post), handler: { response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
                handler(true)
            case let .failure(error):
                handler(false)
                print(error)
            }
        })
    }
}
