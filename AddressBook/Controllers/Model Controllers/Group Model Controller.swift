//
//  Group Model Controller.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import Foundation
class GroupController {
    
    // MARK: - Singleton
    static let sharedInstance = GroupController()
    
    // MARK: - SOT
    var groups: [Group] = []
    
    init() {
        loadContactsFromDisk()
    }
    
    // MARK: - CRUD
    func createGroup(name: String = "Untitled Group", people: [Person] = []){
        let groupCreated = Group(name: name, people: people)
        groups.append(groupCreated)
    
        saveContactsToDisk()
    }
    
    func updateGroup(groupToUpdate: Group, newName: String) {
        groupToUpdate.name = newName
        groupToUpdate.people = []
        
        saveContactsToDisk()
    }
    func deleteGroup(groupToDelete:Group) {
        guard let indexGroupToDelete = groups.firstIndex(of: groupToDelete) else {return}
        groups.remove(at: indexGroupToDelete)
        
        saveContactsToDisk()
    }
    
    // MARK: - Save to Persistent Storage
    private var fileURL: URL? {
        guard let documentsDirectoryURL =
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
                let finalURL = documentsDirectoryURL.appendingPathComponent("logs.json")
                return finalURL
    }
    
    func saveContactsToDisk() {
        guard let saveLocation = fileURL else {return}
        do {
            let data = try JSONEncoder().encode(groups)
            try data.write(to: saveLocation)
        } catch let error {
            print(error)
        }
        
    } // End of Save
    
    func loadContactsFromDisk() {
        guard let loadLocation = fileURL else {return}
        do {
            let data = try Data(contentsOf: loadLocation)
            let decodedGroups = try JSONDecoder().decode([Group].self, from: data)
            self.groups = decodedGroups
        } catch let error {
            print(error)
        }
    }
    
} // End of Class
