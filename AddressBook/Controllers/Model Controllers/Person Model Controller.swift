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
    
    static func updatePerson(personToUpdate: Person, newName: String, newAddress: String) {
        personToUpdate.name = newName
        personToUpdate.address = newAddress
        
        GroupController.sharedInstance.saveContactsToDisk()
    }
    static func deletePerson(personToDelete:Person, group:Group) {
        guard let indexPersonToDelete = group.people.firstIndex(of: personToDelete) else {return}
        group.people.remove(at: indexPersonToDelete)
        
        GroupController.sharedInstance.saveContactsToDisk()
    }
    
} // End of Class
