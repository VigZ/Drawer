//
//  DoodadDetailViewController.swift
//  Drawer
//
//  Created by Kyle on 10/20/20.
//

import UIKit

class DoodadDetailViewController: UIViewController {
    
    var doodad: Doodad!
    
    @IBOutlet weak var doodadLabel: UILabel!
    
    @IBOutlet weak var quantityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doodadLabel.text = doodad.name
        quantityLabel.text = String(doodad.quantity)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
