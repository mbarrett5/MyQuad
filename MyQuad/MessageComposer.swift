//
//  MessageComposer.swift
//  LearnFirebase
//
//  Created by Michael Barrett on 4/30/17.
//  Copyright © 2017 Michael Barrett. All rights reserved.
//

import Foundation
import MessageUI



class MessageComposer: NSObject, MFMessageComposeViewControllerDelegate {
    
    func configuredMessageComposeViewController(name: String, phoneNumber: String) -> MFMessageComposeViewController {
        let recipient = [phoneNumber]
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        messageComposeVC.recipients = recipient
        messageComposeVC.body = "Haha!! You have chore duty this week! Better luck next week, \(name) "
        return messageComposeVC
    }
    
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
