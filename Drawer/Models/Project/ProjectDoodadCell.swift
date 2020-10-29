//
//  ProjectDoodadCell.swift
//  Drawer
//
//  Created by Kyle on 10/28/20.
//

import UIKit

class ProjectDoodadCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    

    @IBOutlet weak var decreaseCountButton: UIButton!
    
    @IBOutlet weak var increaseCountButton: UIButton!
    @IBOutlet weak var quantityLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func decreaseCount(_ sender: Any) {
    }
    
    @IBAction func increaseCount(_ sender: Any) {
    }
}
