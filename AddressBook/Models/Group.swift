//
//  Group.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import Foundation
class Group: Codable {
    let id: UUID
    var name: String
    var people: [Person]
    
    init(id: UUID = UUID(), name: String, people: [Person] = []){
        self.id = id
        self.name = name
        self.people = people
    } // End of Init
    
} // End of Class

//Extending Group function to adopt and conform to the equatable protocol. Allows comparison of objects so that we can index and delete entries in the model controller
extension Group: Equatable {
    static func == (lhs: Group, rhs: Group) -> Bool {
        return lhs.id == rhs.id
    }
}

