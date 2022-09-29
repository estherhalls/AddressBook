//
//  GroupTableViewController.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import UIKit

class GroupTableViewController: UITableViewController {
    
    let groupController = GroupController.sharedInstance
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupController.groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        let group = groupController.groups[indexPath.row]
        cell.textLabel?.text = group.name
        cell.detailTextLabel?.text = "\(group.people.count) People"
//        cell.configureCell(with: group)
        
        return cell
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let group = groupController.groups[indexPath.row]
            groupController.delete(groupToDelete: group)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
     
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        guard segue.identifier == "toPeopleTableVC",
              let peopleTableViewController = segue.destination as? PeopleTableViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row
        else { return }
        let group = groupController.groups[selectedRow]
        peopleTableViewController.groupReceiver = group
                
    }
    // MARK: - Actions

    @IBAction func addGroupButtonTapped(_ sender: UIBarButtonItem) {
        groupController.create()
        tableView.reloadData()
    }
} // End of Class
