//
//  CreateProjectViewController.swift
//  Drawer
//
//  Created by Kyle on 10/26/20.
//

import UIKit

class CreateProjectViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var loadedProject: Project?
    
    var editMode: Bool = false
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var projectImage: UIImageView!
    
    @IBOutlet weak var createProject: UIButton!
    @IBOutlet weak var choosePhoto: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        descriptionField.delegate = self
        
        if loadedProject != nil {
            editMode = true
            nameField.isHidden = true
            presetFields()
        }

    }
    
    @IBAction func choosePhoto(_ sender: Any) {
        addNewImage()
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissEditor))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        navigationItem.rightBarButtonItem = nil
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }

    
    @objc func dismissEditor(){
        self.view.endEditing(true)
    }
    
    @IBAction func createProject(_ sender: Any) {
        guard let name = nameField.text else {
            //could show error flash message here to make sure fields are filled.
            return
        }
        // I don't like this at all. I would like to use extensions and use the Mirror API for object introspection and create the NSobjects from there.
        
        let dataDict = [
            "name": name,
            "projectDescription": descriptionField.text,
            "img": projectImage.image?.toData
        ] as [String : Any]
        
        if editMode {
            DatabaseManager.shareInstance.updateObject(identifier: name, dataMap: dataDict, entityDescription: "Project")
        }
        else {
            DatabaseManager.shareInstance.saveObject(dataMap:dataDict,entityDescription:"Project")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        
        navigationController?.popViewController(animated: true)
    }
    func addNewImage() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        projectImage.image = image
        dismiss(animated: true)
        
        
    }
    
    func presetFields(){
        nameField.text = loadedProject?.name
        descriptionField.text = loadedProject?.projectDescription
        if let imageData = loadedProject?.img {
            projectImage.image = UIImage(data: imageData)
        }
    }

}
