import Foundation
import Alamofire

private let IS_TESTER = true
private let DEP_SER = "https://62d909509088313935996a65.mockapi.io/"
private let DEV_SER = "https://62d909509088313935996a65.mockapi.io/"

let headers: HTTPHeaders = [
    "Accept": "application/json",
]

class AFHttp {
    
    // MARK : - AFHttp Requests
    
    class func get(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .get, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func post(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .post, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func put(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .put, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    class func del(url:String,params: Parameters,handler: @escaping (AFDataResponse<Any>) -> Void){
        AF.request(server(url: url), method: .delete, parameters: params,headers: headers).validate().responseJSON(completionHandler: handler)
    }
    
    // MARK : - AFHttp Methods
    class func server(url: String) -> URL{
        if(IS_TESTER){
            return URL(string: DEV_SER + url)!
        }
        return URL(string: DEP_SER + url)!
    }
    
    // MARK : - AFHttp Apis
    static let API_POST_LIST = "contacts"
    static let API_POST_SINGLE = "contacts/" //id
    static let API_POST_CREATE = "contacts"
    static let API_POST_UPDATE = "contacts/" //id
    static let API_POST_DELETE = "contacts/" //id
    
    
    // MARK : - AFHttp Params
    class func paramsEmpty() -> Parameters {
        let parameters: Parameters = [
            :]
        return parameters
    }
    
    class func paramsPostCreate(post: Contacts) -> Parameters {
            let parameters: Parameters = [
                "name": post.name!,
                "phone": post.phone!
//                "userId": post.userId!
            ]
            return parameters
        }
    
    class func paramsPostUpdate(post: Contacts) -> Parameters {
        let parameters: Parameters = [
            "id": post.id!,
            "name": post.name!,
            "phone": post.phone!
        
        ]
        return parameters
    }
    
}

