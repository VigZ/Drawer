//
//  ProjectDetailViewController.swift
//  Drawer
//
//  Created by Kyle on 10/26/20.
//

import UIKit

class ProjectDetailViewController: UIViewController {
    
    var project: Project!
    
    @IBOutlet weak var projectLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var projectImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        projectLabel.text = project.name
        descriptionLabel.text = project.projectDescription
        if let image = project.img {
            projectImageView.image = UIImage(data: image)
        }
        else {
            projectImageView.image = UIImage(named: "product-placeholder")
        }

    }
    
    @IBAction func editProject(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateProject") as! CreateProjectViewController
        
        vc.loadedProject = project
        navigationController?.pushViewController(vc, animated: true)
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
