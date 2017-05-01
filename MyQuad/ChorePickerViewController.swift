//
//  PlatformPickerViewController.swift
//  LearnFirebase
//
//  Created by Michael Barrett on 4/26/17.
//  Copyright © 2017 Michael Barrett. All rights reserved.
//

import UIKit

class ChorePickerViewController: UIViewController {

    @IBOutlet weak var homeBarButton: UIBarButtonItem!
    @IBOutlet weak var backBarButton: UIBarButtonItem!
    @IBOutlet var arrowheadSwipeGestureRecognizer: UISwipeGestureRecognizer!
    @IBOutlet weak var directionsLabel: UILabel!
    @IBOutlet weak var arrowhead: UIImageView!
    @IBOutlet weak var devinButton: UIButton!
    @IBOutlet weak var mikeyButton: UIButton!
    @IBOutlet weak var kyleButton: UIButton!
    @IBOutlet weak var kieranButton: UIButton!
    
    
    
    
    let textMessageRecipients = ["1-513-340-3477", "1-401-487-4659","1-401-330-8668","1-401-743-1099"]
    var rotatedBy = 1.0
    var personPicked = ""
    let deadlineTime = DispatchTime.now() + 4
    let messageComposer = MessageComposer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func degreesToRadians(degrees: Int) -> Double {
        return Double(degrees + 360) * (.pi / 180)
    }
    
    func displayErrorNoText() {
        let alertController = UIAlertController(title: "Cannot Send Message", message: "Your device is not able to send messages.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        present(alertController, animated: true, completion: nil)
    }
    
    

    @IBAction func arrowheadSwiped(_ sender: UISwipeGestureRecognizer) {
        let randomAngle = Double(arc4random_uniform(361) + 360)
        rotatedBy = randomAngle * .pi / 180
        print(rotatedBy)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = Float(rotatedBy)
        rotationAnimation.duration = 2.0
        rotationAnimation.isRemovedOnCompletion = false
        rotationAnimation.fillMode = kCAFillModeForwards
        rotationAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        
        self.arrowhead.layer.add(rotationAnimation, forKey: nil)
        
        switch rotatedBy {
        case degreesToRadians(degrees: 0)...degreesToRadians(degrees: 90):
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.personPicked = "Mikey"
                self.directionsLabel.text = "Chores for \(self.personPicked)!"
                self.mikeyButton.isEnabled = true
                self.mikeyButton.setTitle("Tap to Text Him", for: .normal)
                
                self.kyleButton.isEnabled = false
                self.devinButton.isEnabled = false
                self.kieranButton.isEnabled = false

            }
        case degreesToRadians(degrees: 90)...degreesToRadians(degrees: 180):
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.personPicked = "Kyle"
                self.directionsLabel.text = "Chores for \(self.personPicked)!"
                self.kyleButton.isEnabled = true
                self.kyleButton.setTitle("Tap to Text Him", for: .normal)
                
                self.devinButton.isEnabled = false
                self.kieranButton.isEnabled = false
                self.mikeyButton.isEnabled = false
                
            }
        case degreesToRadians(degrees: 180)...degreesToRadians(degrees: 270):
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.personPicked = "Kieran"
                self.directionsLabel.text = "Chores for \(self.personPicked)!"
                self.kieranButton.isEnabled = true
                self.kieranButton.setTitle("Tap to Text Him", for: .normal)

                self.mikeyButton.isEnabled = false
                self.kyleButton.isEnabled = false
                self.devinButton.isEnabled = false
            }
        case degreesToRadians(degrees: 270)...degreesToRadians(degrees: 360):
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.personPicked = "Devin"
                self.directionsLabel.text = "Chores for \(self.personPicked)!"
                self.devinButton.isEnabled = true
                self.devinButton.setTitle("Tap to Text Him", for: .normal)
                
                self.kieranButton.isEnabled = false
                self.mikeyButton.isEnabled = false
                self.kyleButton.isEnabled = false

                
            }
        default:
            print("Fail")
        
    }
        arrowheadSwipeGestureRecognizer.isEnabled = false
        backBarButton.isEnabled = false
        backBarButton.title = "No Cheating!"
    

    }

    @IBAction func devinButtonPressed(_ sender: UIButton) {
        homeBarButton.isEnabled = true
        
        if (messageComposer.canSendText()) {
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(name: "Devin", phoneNumber: textMessageRecipients[3])
            present(messageComposeVC, animated: true, completion: nil)
            
        } else {
            displayErrorNoText()
        }
    }
    
    @IBAction func mikeyButtonPressed(_ sender: UIButton) {
        homeBarButton.isEnabled = true
        
        if (messageComposer.canSendText()) {
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(name: "Mikey", phoneNumber: textMessageRecipients[0])
            present(messageComposeVC, animated: true, completion: nil)
        } else {
          displayErrorNoText()
        }

    }
    
    @IBAction func kyleButtonPressed(_ sender: UIButton) {
        homeBarButton.isEnabled = true
        
        if (messageComposer.canSendText()) {
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(name: "Kyle", phoneNumber: textMessageRecipients[1])
            present(messageComposeVC, animated: true, completion: nil)
        } else {
            displayErrorNoText()
        }
    }
    
    @IBAction func kieranButtonPressed(_ sender: UIButton) {
        homeBarButton.isEnabled = true
        
        if (messageComposer.canSendText()) {
            let messageComposeVC = messageComposer.configuredMessageComposeViewController(name: "Kieran", phoneNumber: textMessageRecipients[2])
            present(messageComposeVC, animated: true, completion: nil)

        } else {
            displayErrorNoText()
        }
    }

}
