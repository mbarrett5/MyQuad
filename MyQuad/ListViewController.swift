//
//  ViewController.swift
//  LearnFirebase
//
//  Created by Michael Barrett on 4/25/17.
//  Copyright © 2017 Michael Barrett. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class ListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var listArray = ["Exercise", "Do Homework", "Motivate Myself"]
    var listItemArray = [ListItem]()
    var itemsRef: FIRDatabaseReference!
    var userEmail = ""
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        itemsRef = FIRDatabase.database().reference(withPath: "items")
        
        itemsRef.observe(.value, with: { snapshot in
            self.listItemArray = []
            for child in snapshot.children {
                let itemSnapshot = child as! FIRDataSnapshot
                let newListItem = ListItem()
                let itemValue = itemSnapshot.value as! [String: AnyObject]
                newListItem.listItem = itemValue["listItem"] as! String
                newListItem.postedBy = itemValue["postedBy"] as! String
                newListItem.description = itemValue["description"] as! String
                newListItem.listItemKey = itemSnapshot.key
                self.listItemArray.append(newListItem)
                
            }
            self.tableView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   // override func viewDidAppear(_ animated: Bool) {
     //   print(">>>>> ListVC has appeared")
        
       // if GIDSignIn.sharedInstance().hasAuthInKeychain() {
         //   print("Signed in from ListVC")
           // let userEmail = (FIRAuth.auth()?.currentUser?.email)!
            //let displayName = (FIRAuth.auth()?.currentUser?.displayName)!
            //print("uuuuu userEmail = \(userEmail) and displayName = \(displayName)")
        //} else {
          //  performSegue(withIdentifier: "ToLogin", sender: nil)
        //}
    //}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier! {
        case "ToEditItem":
            let destination = segue.destination as! DetailViewController
            let indexPath = tableView.indexPathForSelectedRow
            destination.listItem = listItemArray[(indexPath?.row)!].listItem
            destination.descriptionItem = listItemArray[(indexPath?.row)!].description
        case "ToAddItem":
            if let selectedRow = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedRow, animated: true)
            }
        case "ToLogin":
            print("Performing segue ToLogin")
        default:
            print("unexpected segue! ERROR!")
            
        }
    }
    
    @IBAction func unwindFromDetailVC(sender: UIStoryboardSegue) {
        if let userEmail = FIRAuth.auth()?.currentUser?.email {
            self.userEmail = userEmail
        } else {
            self.userEmail = ""
        }
        
        
        if let source = sender.source as? DetailViewController, let newItem = source.listItem, let newDescription = source.descriptionItem {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                let index = selectedIndexPath.row
                //updating an edited cell
                listItemArray[index].listItem = newItem
                listItemArray[index].postedBy = userEmail
                listItemArray[index].description = newDescription
                let listItemKey = listItemArray[index].listItemKey
                
                self.itemsRef.child(listItemKey).setValue(["listItem": newItem, "postedBy": userEmail, "description": newDescription])
                
            } else {
                let newListItem = ListItem()
                newListItem.listItem = newItem
                newListItem.postedBy = userEmail
                newListItem.description = newDescription
                //Put on list to show
                listItemArray.append(newListItem)
                
                //Write to Firebase Database
                let itemID = self.itemsRef.childByAutoId()
                itemID.setValue(["listItem": newListItem.listItem, "postedBy": newListItem.postedBy, "description": newListItem.description])
            }
            tableView.reloadData()
        } else {
            print("You failed")
        }
    }
    

    
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = listItemArray[indexPath.row].listItem
        cell.detailTextLabel?.text = listItemArray[indexPath.row].postedBy
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItemArray.count
    }
    
    //deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let listItemKey = listItemArray[indexPath.row].listItemKey
            self.itemsRef.child(listItemKey).removeValue()
        }
    }
}
