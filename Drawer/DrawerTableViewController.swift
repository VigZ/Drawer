//
//  DrawerTableViewController.swift
//  Drawer
//
//  Created by Kyle on 10/19/20.
//

import UIKit
import CoreData

class DrawerTableViewController: UITableViewController, UISearchControllerDelegate {
    
    var doodads = [Doodad]()
    var filteredDoodads = [Doodad]()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var isSearchBarEmpty: Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
      return searchController.isActive && !isSearchBarEmpty
    }
    
    let dbManager = DatabaseManager.shareInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadList(notification:)), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewDoodad))
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Doodads"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        
        
        doodads = dbManager.fetchObjects(entityDescription: "Doodad").compactMap { $0 as? Doodad }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if isFiltering {
           return filteredDoodads.count
         }
        return doodads.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "doodadCell", for: indexPath)
        
        let doodad: Doodad
        if isFiltering {
            doodad = filteredDoodads[indexPath.row]
          } else {
            doodad = doodads[indexPath.row]
          }
        cell.textLabel!.text =
        doodad.value(forKeyPath: "name") as? String


        return cell
    }
    
    func filterContentForSearchText(_ searchText: String) {
      filteredDoodads = doodads.filter { (doodad: Doodad) -> Bool in
        return doodad.name!.lowercased().contains(searchText.lowercased())
      }
      
      tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "DoodadDetail") as! DoodadDetailViewController
        let doodad: Doodad
        if isFiltering {
            doodad = filteredDoodads[indexPath.row]
        }
        else {
            doodad = doodads[indexPath.row]
        }
        
        vc.doodad = doodad
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func addNewDoodad(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "CreateDoodad") as! CreateDoodadViewController
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc func reloadList(notification: NSNotification){
        
        tableView.reloadData()
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension DrawerTableViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    
    let searchBar = searchController.searchBar
    filterContentForSearchText(searchBar.text!)
  }
}
