//
//  Contact.swift
//  ContactsMVVM
//
//  Created by Avaz Mukhitdinov on 13/08/22.
//

import Foundation

class Contacts: Decodable{
    var id : String? = ""
    var name: String? = ""
    var phone: String? = ""
    
    init(){}
    
    init(name: String, phone: String){
        self.name = name
        self.phone = phone
    }
    
    init(id: String, name: String, phone: String){
        self.id = id
        self.name = name
        self.phone = phone
    }
    
}
