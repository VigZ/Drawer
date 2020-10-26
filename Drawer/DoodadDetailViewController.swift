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
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        doodadLabel.text = doodad.name
        quantityLabel.text = String(doodad.quantity)
        descriptionLabel.text = doodad.doodadDescription
        if let image = doodad.img {
            imageView.image = UIImage(data: image)
        }
        else {
            imageView.image = UIImage(named: "product-placeholder")
        }
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func editDoodad(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateDoodad") as! CreateDoodadViewController
        
        vc.loadedDoodad = doodad
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteDoodad(_ sender: Any) {
        DatabaseManager.shareInstance.deleteObject(object: doodad)
       navigationController?.popToRootViewController(animated: true)
    }
    
}
