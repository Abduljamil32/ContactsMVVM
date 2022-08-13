//
//  EditViewModel.swift
//  ContactsMVVM
import Bond
import Foundation

class EditViewModel{
    var controller: BaseViewController!
    
    func apiEditPost(post: Contacts){
        controller?.showProgress()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + post.id!, params: AFHttp.paramsPostUpdate(post: post), handler: { response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                print(response.result)
                
            case let .failure(error):
                print(error)
            }
        })
    }
}
