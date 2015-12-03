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
    
    @IBAction func addToContact(sender: UIButton) {
        AppDelegate.getAppDelegate().requestForAccess { (accessGranted) -> Void in
            if accessGranted {
                self.createContact()
                
            }
        }
    }
    @IBAction func addSnapchat(sender: AnyObject) {
        addToSnapchat(contactDetail!["snapchat"]!)
    }
    
    @IBAction func addFacebook(sender: UIButton) {
        addFBFriend(contactDetail!["facebook"]!)
    }
    
    @IBAction func addInstagram(sender: UIButton) {
        addToInstagram(contactDetail!["instagram"]!)
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
    
    func addFBFriend(fbID : String){
        
        let fbAccess = "fb://profile/" + fbID
        
        if let fbURL = NSURL(string: fbAccess)
        {
            if UIApplication.sharedApplication().canOpenURL(fbURL)
            {
                UIApplication.sharedApplication().openURL(fbURL)
                
            } else {
                //redirect to safari because the user doesn't have Facebook
                UIApplication.sharedApplication().openURL(NSURL(string: "http://facebook.com/" + fbID)!)
            }
        }

    }
    
    func addToInstagram(instaID : String){
        
        let instaAccess = "instagram://user?username=" + instaID
        
        if let instaURL = NSURL(string: instaAccess)
        {
            if UIApplication.sharedApplication().canOpenURL(instaURL)
            {
                UIApplication.sharedApplication().openURL(instaURL)
                
            } else {
                //redirect to safari because the user doesn't have Instagram
                UIApplication.sharedApplication().openURL(NSURL(string: "http://instagram.com/user?username=" + instaID)!)
            }
        }
        
    }
    
    func addToSnapchat(snapchatID : String){
        
        let snapchatAccess = "ha://?u=" + snapchatID
        
        
        
        if let snapchatURL = NSURL(string: snapchatAccess)
        {
            if UIApplication.sharedApplication().canOpenURL(snapchatURL)
            {
                UIApplication.sharedApplication().openURL(snapchatURL)
                
            } else {
                //redirect to safari because the user doesn't have Snapchat
                UIApplication.sharedApplication().openURL(NSURL(string: "https://www.youtube.com/watch?v=dQw4w9WgXcQ")!)
            }
        }
        
    }
    
    
    
    
    
        
    
}

