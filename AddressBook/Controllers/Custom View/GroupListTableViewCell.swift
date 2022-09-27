//
//  GroupListTableViewCell.swift
//  AddressBook
//
//  Created by Esther on 9/26/22.
//

import UIKit

class GroupListTableViewCell: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var groupTitleLabel: UILabel!
    @IBOutlet weak var groupDetailLabel: UILabel!
    
    // Method called for building UI of cell
    func configureCell(with group: Group){
        groupTitleLabel.text = group.name
        groupDetailLabel.text = "\(GroupController.sharedInstance.groups.count)"
        
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
