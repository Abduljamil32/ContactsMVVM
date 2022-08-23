//
//  HomeViewModel.swift
//  ContactsMVVM

import Foundation
import Bond

class HomeViewModel{
    var controller: BaseViewController!
    var items = Observable<[Contacts]>([])
    
    func apiPostList(){
        controller?.showProgress()
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { [self] response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                let posts = try! JSONDecoder().decode([Contacts].self, from: response.data!)
                self.items.value = posts
            case let .failure(error):
                print(error)
                
            }
        })
    }
    
    func apiPostDelete(post: Contacts, handler: @escaping (Bool)-> Void){
        controller?.showProgress()
        
        AFHttp.del(url: AFHttp.API_POST_DELETE + post.id!, params: AFHttp.paramsEmpty(), handler: { [self] response in
            self.controller?.hideProgress()
            switch response.result{
            case .success:
                handler(true)
                print(response.result)
                self.apiPostList()
                
            case let .failure(error):
                handler(false)
                print(error)
               
            }
        })
    }
}
