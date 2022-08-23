//
//  testingTests.swift
//  testingTests


import XCTest
@testable import ContactsMVVM

class testingTests: XCTestCase {
    
    let home = HomeViewModel()
    let create = CreateViewModel()
    let edit = EditViewModel()
    
    
    func testApiList(){
        let ex = expectation(description: "testApiList")
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result{
            case .success:
                XCTAssertNotNil(response)
                ex.fulfill()
                
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        waitForExpectations(timeout: 10){(error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testApiListCount(){
        let ex = expectation(description: "testApiListCount")
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result{
            case .success:
                let posts = try! JSONDecoder().decode([Contacts].self, from: response.data!)
                XCTAssertEqual(posts.count, 20)
                ex.fulfill()
                
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        waitForExpectations(timeout: 10){(error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }

    
    func apiPostCreated(){
        let ex = expectation(description: "apiPostCreated")
        
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result{
            case .success:
                func api(post: Contacts){
                    self.create.apiCreatePost(post: post, handler: {isCreated in
                        XCTAssertEqual(isCreated, true)
                    })
                }
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        waitForExpectations(timeout: 10){(error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testApiPostDeleted(){
        let ex = expectation(description: "testApiPostDeleted")
        
        AFHttp.get(url: AFHttp.API_POST_LIST, params: AFHttp.paramsEmpty(), handler: { response in
            switch response.result{
            case .success:
                func api(post: Contacts){
                    self.home.apiPostDelete(post: post, handler: {isDeleted in
                        XCTAssertEqual(isDeleted, true)
                    })
                }
                ex.fulfill()
            case let .failure(error):
                XCTAssertNil(error)
                ex.fulfill()
            }
        })
        waitForExpectations(timeout: 10){(error) in
            if let error = error {
                XCTFail("error: \(error)")
            }
        }
    }
    
    func testApiPostEdited(){
        let ex = expectation(description: "testApiPostEdited")
        
        func apiPostUpdate(post: Contacts, handler: @escaping (Bool) -> Bool) {
            
            AFHttp.put(url: AFHttp.API_POST_UPDATE + post.id!, params: AFHttp.paramsPostUpdate(post: post), handler: { response in
                switch response.result{
                case .success:
                    func api(post: Contacts){
                        self.edit.apiEditPost(post: post, handler: {isEdited in
                            XCTAssertEqual(isEdited, true)
                        })
                    }
                    ex.fulfill()
                case let .failure(error):
                    handler(false)
                    XCTAssertFalse(false)
                    ex.fulfill()
                }
            })
            waitForExpectations(timeout: 10){(error) in
                if let error = error {
                    XCTFail("error: \(error)")
                }
            }
        }
        
        
    }
    
}
