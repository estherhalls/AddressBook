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
    private(set) var groups: [Group] = []
    
    init() {
        loadContactsFromDisk()
    }
    
    // MARK: - CRUD
    func create(name: String = "Untitled Group", people: [Person] = []){
        let group = Group(name: name, people: people)
        groups.append(group)
        saveContactsToDisk()
    }
    
    func update(groupToUpdate: Group, name: String) {
        groupToUpdate.name = name
        saveContactsToDisk()
    }
    
    func delete(groupToDelete:Group) {
        guard let index = groups.firstIndex(of: groupToDelete) else { return }
        groups.remove(at: index)
        saveContactsToDisk()
    }
    
    // MARK: - Save to Persistent Storage
    private var fileURL: URL? {
        guard let documentsDirectory =
                FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        let url = documentsDirectory.appendingPathComponent("addressbook.json")
        return url
    }
    
    func saveContactsToDisk() {
        guard let saveLocation = fileURL else { return }
        do {
            let data = try JSONEncoder().encode(groups)
            try data.write(to: saveLocation)
        } catch let error {
            print(error)
        }
        
    } // End of Save
    
    func loadContactsFromDisk() {
        guard let loadLocation = fileURL else { return }
        do {
            let data = try Data(contentsOf: loadLocation)
            let decodedGroups = try JSONDecoder().decode([Group].self, from: data)
            self.groups = decodedGroups
        } catch let error {
            print(error)
        }
    }
    
} // End of Class
