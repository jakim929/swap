//
//  FBLoginViewController.swift
//  Swap
//
//  Created by Walker Jordan on 11/27/15.
//  Copyright © 2015 James Kim. All rights reserved.
//

import UIKit

class FBLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    var currentSynqrCode : SynqrCode?
    
    var infodict : NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loginView : FBSDKLoginButton = FBSDKLoginButton()
        self.view.addSubview(loginView)
        loginView.center = self.view.center
        loginView.readPermissions = ["public_profile", "email", "user_friends"]
        loginView.delegate = self
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Facebook Delegate Methods
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")

        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                let userEmail : NSString = result.valueForKey("email") as! NSString
                print("User Email is: \(userEmail)")
                
                // User is already logged in, do work such as go to next view controller.
                self.dismissViewControllerAnimated(false) { () -> Void in
                    //self.cardVC?.fbUserName = userEmail as String
                }
            }
        })
    }
    
    // http://ashishkakkad.com/2015/05/facebook-login-swift-language-ios-8/
    
    
    func getSaveFBUserID(){
        if((FBSDKAccessToken.currentAccessToken()) != nil){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).startWithCompletionHandler({ (connection, result, error) -> Void in
                if (error == nil){
                    
                    let fbid = result.valueForKey("id")
                    
                    self.infodict = result as! NSDictionary
                    print(result)
                    print(self.infodict)
                    NSLog(self.infodict.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as! String)
                }
            })
        }
    }
    

    
    /*
    func getFBID(){
        FBSession.openActiveSessionWithReadPermissions(["public_profile", "email", "user_friends"] , allowLoginUI: true, completionHandler: { (session:FBSession!, state:FBSessionState, error:NSError!) -> Void in
            if (error==nil)
            {
                FBRequest.requestForMe().startWithCompletionHandler({ (connection:FBRequestConnection!, result:AnyObject!, error:NSError!) -> Void in
                    
                    if (error==nil)
                    {
                        
                        var bUserFacebookDict = result as! NSDictionary
                        
                        let FB_USER_ID = bUserFacebookDict["id"]! as! String
                        
                        // now call FB graph API to to Get username of the user.
                        var graphProfileURL = NSURL(string: "https://graph.facebook.com/?id=\(FB_USER_ID)")
                        
                        
                        var request1: NSURLRequest = NSURLRequest(URL: graphProfileURL!)
                        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?
                        >=nil
                        var error: NSErrorPointer = nil
                        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request1, returningResponse: response, error:nil)!
                        var err: NSError
                        println(response)
                        var jsonResult: NSDictionary = NSJSONSerialization.JSONObjectWithData(dataVal, options: NSJSONReadingOptions.MutableContainers, error: nil) as! NSDictionary
                        println("Synchronous\(jsonResult)")
                        
                        
                        let FB_USER_NAME = jsonResult["username"]! as! String //finally you will get username
                        
                        
                    }
                    else
                    {
                        //Utility.showErrorAlert(error.description)
                    }
                })
            }
        })
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

