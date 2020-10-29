//
//  ProjectDoodadCell.swift
//  Drawer
//
//  Created by Kyle on 10/28/20.
//

import UIKit

class ProjectDoodadCell: UITableViewCell {
    
    var baseQuantity: Int = 0
    
    var currentQuantity: Int = 0 {
        didSet {
            quantityLabel.text = String(currentQuantity)
        }
    }
    
    var cellHasBeenEdited:Bool {
        return currentQuantity != 0
    }
    
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
        
        if currentQuantity > 0 {
            currentQuantity -= 1
        }
        else {
            return
        }
    }
    
    @IBAction func increaseCount(_ sender: Any) {
        if currentQuantity < baseQuantity {
            currentQuantity += 1
        }
        else {
            return
        }
    }
}
