//
//  PersonDetailViewController.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import UIKit

class PersonDetailViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    
    // Receiver Property:
    var person: Person?
    
    // MARK: - Lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateViews()
    }
    
    func updateViews() {
        guard let person = person else { return }
        nameTextField.text = person.name
        addressTextField.text = person.address
    }
    
    // MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let person = person,
              let name = nameTextField.text,
              let address = addressTextField.text else { return }
        PersonController.updatePerson(personToUpdate: person, name: name, address: address)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: Any) {
    }
    
} // End of Class
