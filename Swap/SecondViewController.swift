//
//  SecondViewController.swift
//  Swap
//
//  Created by James Kim on 11/23/15.
//  Copyright © 2015 James Kim. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var qrCode: UIImageView!
    var qrcodeImage: CIImage!

    var fbUserName: String = "";
    
    
    var items:[String] = ["Name", "Facebook", "Snapchat", "Email", "Phone Number"];

    override func viewDidLoad() {
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            let fbViewController = self.storyboard?.instantiateViewControllerWithIdentifier("FBlogin") as! FBLoginViewController
            fbViewController.cardVC = self;
            presentViewController(fbViewController, animated: true, completion: nil)
            
            // User is already logged in, do work such as go to next view controller.
            //self.dismissViewControllerAnimated(false, completion: { () -> Void in
                
        }
    
        super.viewDidLoad()
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        // Do any additional setup after loading the view, typically from a nib.
        //self.tableView.registerClass(UITableViewCell.self, forHeaderFooterViewReuseIdentifier: "cell")
    }
    
    // generates QR code when "Generate" button is pressed
    @IBAction func generatePress(sender: AnyObject) {
        // http://www.appcoda.com/qr-code-generator-tutorial/
        if qrcodeImage == nil {
        
            let data = "foobar".dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
        
            let filter = CIFilter(name: "CIQRCodeGenerator")
        
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            
            qrcodeImage = filter!.outputImage
            let qrViewController = self.storyboard?.instantiateViewControllerWithIdentifier("qr") as! QRDisplay
            qrViewController.image = UIImage.init(CIImage: qrcodeImage)
            presentViewController(qrViewController, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row] + " " + self.fbUserName
        
        //cell.textLabel?.text = self.items[indexPath.row]
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell  #\(indexPath.row)")
    }
    

    
    
}

