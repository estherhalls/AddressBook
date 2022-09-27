//
//  PeopleTableViewController.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import UIKit

class PeopleTableViewController: UITableViewController {
    // MARK: - Outlets
    @IBOutlet weak var groupNameTextField: UITextField!
    
    // Receiver Property:
    var groupReceiver: Group?
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupNameTextField.text = groupReceiver?.name
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let groupReceiver = groupReceiver,
        let groupName = groupNameTextField.text
        else { return }
        GroupController.sharedInstance.updateGroup(groupToUpdate: groupReceiver, newName: groupName)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return groupReceiver?.people.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath)
        let person = groupReceiver?.people[indexPath.row]
        cell.textLabel?.text = person?.name

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = groupReceiver else {return}
            let person = group.people[indexPath.row]
            PersonController.deletePerson(personToDelete: person, group: group)
            tableView.deleteRows(at: [indexPath], with: .fade)
        
        }    
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPersonDetailVC",
              let PersonDetailViewController = segue.destination as? PersonDetailViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row
        else {return}
        let person = groupReceiver?.people[selectedRow]
        PersonDetailViewController.person = person
    }
    
    // MARK: - Actions
    @IBAction func addPeopleButtonTapped(_ sender: Any) {
        guard let group = groupReceiver else {return}
        PersonController.createPerson(group: group)
        tableView.reloadData()
    }

} // End of Class
