//
//  EditViewModel.swift
//  ContactsMVVM
import Bond
import Foundation

class EditViewModel{
    var controller: BaseViewController!
    var editContact: Contacts?
    
    func apiEditPost(post: Contacts, handler: @escaping (Bool) -> Void){
        controller?.showProgress()
        AFHttp.put(url: AFHttp.API_POST_UPDATE + post.id!, params: AFHttp.paramsPostUpdate(post: post), handler: { response in
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
