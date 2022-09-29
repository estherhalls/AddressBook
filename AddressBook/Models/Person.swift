//
//  Person.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import Foundation
class Person: Codable {
    let id: UUID
    var name: String
    var address: String
    var isFavorite: Bool
    
    // Member-wise Initializer:
    init(id: UUID = UUID(), name: String, address: String, isFavorite: Bool = false){
        self.id = id
        self.name = name
        self.address = address
        self.isFavorite = isFavorite
    } // End of Init
    
} // End of Class

//Extending Person function to adopt and conform to the equatable protocol. Allows comparison of objects so that we can index and delete entries in the model controller
extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.id == rhs.id
    }
}
