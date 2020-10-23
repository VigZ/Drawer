//
//  ProjectCell.swift
//  Drawer
//
//  Created by Kyle on 10/22/20.
//

import UIKit

class ProjectCell: UITableViewCell {

    @IBOutlet weak var projectImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
