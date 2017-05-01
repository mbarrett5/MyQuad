//
//  MContactViewController.swift
//  LearnFirebase
//
//  Created by Michael Barrett on 4/26/17.
//  Copyright © 2017 Michael Barrett. All rights reserved.
//

import UIKit
import ContactsUI

protocol AddContactViewControllerDelegate {
    func didFetchContacts(contacts: [CNContact])
}

class MContactViewController: UIViewController, UIPickerViewDelegate, CNContactPickerDelegate {
    
    var delegate: AddContactViewControllerDelegate!
    var contacts = [CNContact]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    func didFetchContacts(contacts: [CNContact]) {
        for contact in contacts {
            self.contacts.append(contact)
            print("@@@@\(contact)")
        }
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        delegate.didFetchContacts(contacts: [contact])
        navigationController?.popViewController(animated: true)
    }

    @IBAction func contactButtonPressed(_ sender: UIButton) {
        let contactPickerViewController = CNContactPickerViewController()
        
        
        contactPickerViewController.delegate = self
        contactPickerViewController.displayedPropertyKeys = [CNContactGivenNameKey,CNContactPhoneNumbersKey]
        
        present(contactPickerViewController, animated: true, completion: nil)
    }

}
