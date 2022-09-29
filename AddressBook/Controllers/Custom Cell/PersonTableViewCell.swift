//
//  personTableViewCell.swift
//  AddressBook
//
//  Created by Esther on 9/28/22.
//

import UIKit

protocol PersonTableViewCellDelegate: AnyObject {
    func toggleFavoriteButtonTapped(cell: PersonTableViewCell)
}

class PersonTableViewCell: UITableViewCell {
    
    // MARK: - Outlets

    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
  
    
    // MARK: - Properties
    weak var delegate: PersonTableViewCellDelegate?
    // Property Observer - run if an event is triggered that changes the value of a property
    var person: Person? {
        didSet {
            updateViews()
        }
    }
    
    // MARK: - Methods
    func updateViews() {
        guard let person = person else {return}
        personNameLabel.text = person.name
        // Ternary Operator!
        let favoriteImageName = person.isFavorite ? "star.fill" : "star"
        let favoriteImage = UIImage(systemName: favoriteImageName)
        favoriteButton.setImage(favoriteImage, for: .normal)
    }
    
    // MARK: - Actions
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        delegate?.toggleFavoriteButtonTapped(cell: self)
    }
    
} // End of Class
