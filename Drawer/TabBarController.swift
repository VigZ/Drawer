//
//  TabBarController.swift
//  Drawer
//
//  Created by Kyle on 10/23/20.
//

import UIKit

class TabBarController: UITabBarController {
    
    let drawer = DrawerTableViewController()
    let second = SecondViewController()

    tabBarController.viewControllers = [first, second]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
