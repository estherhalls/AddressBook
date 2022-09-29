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
    @IBOutlet weak var favoritesOnlyToggle: UISwitch!
    
    // Receiver Property:
    let groupController = GroupController.sharedInstance
    var groupReceiver: Group?
    
    private var filteredPeople: [Person] {
        return favoritesOnlyToggle.isOn ? groupReceiver?.people.filter { $0.isFavorite } ?? [] : groupReceiver?.people ?? []
    }
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        groupNameTextField.text = groupReceiver?.name
        favoritesOnlyToggle.isOn = false
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let groupReceiver = groupReceiver,
        let groupName = groupNameTextField.text
        else { return }
        groupController.update(groupToUpdate: groupReceiver, name: groupName)

    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredPeople.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "peopleCell", for: indexPath) as? PersonTableViewCell else { return UITableViewCell() }
        let person = filteredPeople[indexPath.row]
        cell.person = person
        cell.delegate = self

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let group = groupReceiver else {return}
            let person = filteredPeople[indexPath.row]
            PersonController.deletePerson(personToDelete: person, in: group)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }    
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "toPersonDetailVC",
              let PersonDetailViewController = segue.destination as? PersonDetailViewController,
              let selectedRow = tableView.indexPathForSelectedRow?.row else {return}
        let person = filteredPeople[selectedRow]
        PersonDetailViewController.person = person
    }
    
    // MARK: - Actions
    @IBAction func addPeopleButtonTapped(_ sender: UIBarButtonItem) {
        guard let group = groupReceiver else {return}
        PersonController.createPerson(group: group)
        tableView.reloadData()
    }

    @IBAction func favoritesOnlySwitchToggled(_ sender: UISwitch) {
        tableView.reloadData()
    }
} // End of Class

// MARK: PersonTableViewCellDelegate Conformance
extension PeopleTableViewController: PersonTableViewCellDelegate {
    
    func toggleFavoiriteButtonTapped(cell: PersonTableViewCell) {
        guard let person = cell.person else {return}
        PersonController.toggleFavorite(person: person)
        tableView.reloadData()
    }
} // End of Extension
