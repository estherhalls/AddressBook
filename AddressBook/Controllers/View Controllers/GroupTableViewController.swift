//
//  GroupTableViewController.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import UIKit

class GroupTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GroupController.sharedInstance.groups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath) as? GroupListTableViewCell else {return UITableViewCell()}
        let group = GroupController.sharedInstance.groups[indexPath.row]
        cell.configureCell(with: group)
        
        return cell
    }
    

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let group = GroupController.sharedInstance.groups[indexPath.row]
            GroupController.sharedInstance.deleteGroup(groupToDelete: group)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
     
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // IIDOO
        if segue.identifier == "toPeopleTableVC" {
            if let index = tableView.indexPathForSelectedRow {
                if let destination = segue.destination as? PeopleTableViewController {
                    let groupToSend = GroupController.sharedInstance.groups[index.row]
                    destination.groupReceiver = groupToSend
                }
            }
        }
    }

    @IBAction func addGroupButtonTapped(_ sender: Any) {
        GroupController.sharedInstance.createGroup()
        tableView.reloadData()
    }
} // End of Class
