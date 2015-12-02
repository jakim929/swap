//
//  ContactPanelViewController.swift
//  Swap
//
//  Created by James Kim on 11/30/15.
//  Copyright © 2015 James Kim. All rights reserved.
//

import Foundation
import UIKit
import Contacts


class ContactPanelViewController: UIViewController
{

    var contactDetail:[String : String]?

    @IBOutlet weak var contactInfo: UILabel!
    @IBAction func returnButton(sender: UIButton) {
        
        
    }

    
    
    @IBAction func addContactButton(sender: UIButton) {
        AppDelegate.getAppDelegate().requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                self.createContact()
                
            }
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.contactInfo.text = contactDetail!["fname"]! + " " + contactDetail!["lname"]!
        

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createContact() {
        let newContact = CNMutableContact()
        newContact.givenName = contactDetail!["fname"]!
        newContact.familyName = contactDetail!["lname"]!
        
        newContact.phoneNumbers = [CNLabeledValue(label:CNLabelPhoneNumberMobile, value: CNPhoneNumber(stringValue: contactDetail!["phone"]!))]
        
        let homeEmail = CNLabeledValue(label: CNLabelHome, value: contactDetail!["email"]!)
        newContact.emailAddresses = [homeEmail]
        
        AppDelegate.getAppDelegate().showMessage("Create new CNMutableContact Succeeded")
        
        do {
            let saveRequest = CNSaveRequest()
            saveRequest.addContact(newContact, toContainerWithIdentifier: nil)
            try AppDelegate.getAppDelegate().contactStore.executeSaveRequest(saveRequest)
            
            navigationController?.popViewControllerAnimated(true)
        }
        catch {
            AppDelegate.getAppDelegate().showMessage("Unable to save the new contact.")
        }
        
    }
    
    
    
        
    
}

