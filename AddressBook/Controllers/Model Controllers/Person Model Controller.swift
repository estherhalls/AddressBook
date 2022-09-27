//
//  Person Model Controller.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import Foundation
class PersonController {
    
    // MARK: - CRUD
    static func createPerson(name: String = "New Contact", address: String = "", group: Group){
        let person = Person(name: name, address: address)
        group.people.append(person)
        GroupController.sharedInstance.saveContactsToDisk()
    }
    
    static func updatePerson(personToUpdate: Person, name: String, address: String) {
        personToUpdate.name = name
        personToUpdate.address = address
        
        GroupController.sharedInstance.saveContactsToDisk()
    }
    static func deletePerson(personToDelete: Person, in group: Group) {
        guard let index = group.people.firstIndex(of: personToDelete) else {return}
        group.people.remove(at: index)
        
        GroupController.sharedInstance.saveContactsToDisk()
    }
    
} // End of Class
