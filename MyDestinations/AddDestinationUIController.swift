//
//  AddDestinationController.swift
//  MyDestinations
//
//  Created by Terezija Umiljanovic on 11.05.2021..
//

import UIKit

protocol AddDestinationViewControllerDelegate: class {
    func created(newDestination: Destination)
}

class AddDestinationUIController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var descriptionInput: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    weak var delegate: AddDestinationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Unos nove destinacije"
        nameLabel.text = "Naziv:"
        descriptionLabel.text = "Opis:"
        saveBtn.setTitle("Spremi", for: .normal)
        nameInput.delegate = self
        descriptionInput.delegate = self
    }
    
    @IBAction func onSaveBtnClick(_ sender: Any) {
       
        guard let name = nameInput.text else{return}
        guard let description = descriptionInput.text else
        {return}
             
        guard name.count > 0 && description.count > 0 else {return}
        
        let destination = Destination(title: name, description: description)
        delegate?.created(newDestination: destination)
            navigationController?.popViewController(animated: true)
                	
    }
}

extension AddDestinationUIController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
