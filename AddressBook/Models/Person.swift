//
//  Person.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import Foundation
class Person {
    let id: UUID
    var name: String
    var address: String
    
    // Member-wise Initializer:
    init(id: UUID = UUID(), name: String, address: String){
        self.id = id
        self.name = name
        self.address = address
    } // End of Init
    
} // End of Class

//Extending Person function to adopt and conform to the equatable protocol. Allows comparison of objects so that we can index and delete entries in the model controller
extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id &&
        lhs.name == rhs.name &&
        lhs.address == rhs.address
    }
}
