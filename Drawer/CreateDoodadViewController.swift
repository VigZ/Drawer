//
//  CreateDoodadViewController.swift
//  Drawer
//
//  Created by Kyle on 10/20/20.
//

import UIKit

class CreateDoodadViewController: UIViewController, UITextFieldDelegate {
    
    var loadedDoodad: Doodad?
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var quantityField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        quantityField.delegate = self

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEditor))
        navigationItem.rightBarButtonItem = doneButton
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        navigationItem.rightBarButtonItem = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func dismissEditor(){
        self.view.endEditing(true)
    }
    
    @IBAction func createDoodad(_ sender: Any) {
        guard let name = nameField.text, let quantity = quantityField.text  else {
            //could show error flash message here to make sure fields are filled.
            return
        }
        // I don't like this at all. I would like to use extensions and use the Mirror API for object introspection and create the NSobjects from there.
        let quantInt = Int(quantity)
        
        let dataDict = [
            "name": name,
            "quantity": quantInt
        ] as [String : Any]
        

        DatabaseManager.shareInstance.saveObject(dataMap:dataDict,entityDescription:"Doodad")
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        navigationController?.popViewController(animated: true)
        
        
    }
    

}

