//
//  DetailViewController.swift
//  LearnFirebase
//
//  Created by Michael Barrett on 4/25/17.
//  Copyright © 2017 Michael Barrett. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var descriptionView: UITextView!
    @IBOutlet weak var itemTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var listItem: String?
    var descriptionItem: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let listItem = listItem {
            itemTextField.text = listItem
            descriptionView.text = descriptionItem
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayError() {
        let alertController = UIAlertController(title: "Cannot Save", message: "You must include a title and description of your memory.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        listItem = itemTextField.text
        descriptionItem = descriptionView.text
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController!.popViewController(animated: true)
        }
    }

    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        if let text = descriptionView.text {
            
        } else {
            displayError()
        }
    }
}
