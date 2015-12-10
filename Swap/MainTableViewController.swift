//
//  MainTableViewController.swift
//  edit data demo
//
//  Created by Apoorv Mote on 04/10/15.
//  Copyright © 2015 Apoorv Mote. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var synqrCode : SynqrCode?
    
    var models = ["First Name", "Last Name", "Phone", "Email", "Facebook", "Snapchat", "Instagram"]
    
    @IBAction func saveToMainViewController (segue:UIStoryboardSegue) {
        
        /*
        let detailViewController = segue.sourceViewController as! DetailTableViewController
        
        let index = detailViewController.index
        
        let modelString = detailViewController.textField.text
        
        models[index!] = modelString!
        */
        tableView.reloadData()

        
    }
    
    
    // Code to be run when the segue is unwinded
    @IBAction func unwindToMainTableVC(segue: UIStoryboardSegue){
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let loadCode = loadSynqrCode() {
            synqrCode = loadCode
        }
        else
        {
            synqrCode = SynqrCode()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewDidAppear(animated: Bool) {
        tableView.reloadData()
        saveSynqrCode()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return models.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tableCell", forIndexPath: indexPath) as! ContactTableViewCell
        
        // Configure the cell...
        
        cell.categoryLabel.text = models[indexPath.row]
        
        if let value = synqrCode?.returnValue(indexPath.row){
            cell.contentLabel.text = value
            if (indexPath.row == 4){
                cell.contentLabel.text = "Logged In"
            }
        }else{
            cell.contentLabel.text = ""

        }
        if (indexPath.row == 3){
            let mailIcon = "Mail Logo"
            cell.iconImage.image = UIImage(named: mailIcon)
        }
        
        if (indexPath.row == 4){
        
            let facebookIcon = "Facebook_logo_(square).png"
            cell.iconImage.image = UIImage(named: facebookIcon)
        }
        
    
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 4 {
            self.performSegueWithIdentifier("fbLogin", sender: self)
        }
        else
        {
            self.performSegueWithIdentifier("edit", sender: self)
        }
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    if editingStyle == .Delete {
    // Delete the row from the data source
    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
    } else if editingStyle == .Insert {
    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    }
    */
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
    // Return false if you do not want the item to be re-orderable.
    return true
    }
    */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "edit" {
            
            let path = tableView.indexPathForSelectedRow
            
            let detailViewController = segue.destinationViewController as! DetailTableViewController
            
            detailViewController.index = path?.row
            detailViewController.currentSynqrCode = synqrCode
            
        }
        else if segue.identifier == "fbLogin"
        {
            let fbLoginViewController = segue.destinationViewController as! FBLoginViewController
            
            fbLoginViewController.currentSynqrCode = synqrCode
        }
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
    // Saves the code details to the phone
    func saveSynqrCode(){
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(synqrCode!, toFile: SynqrCode.ArchiveURL.path!)
        
        if !isSuccessfulSave {
            print("Failed to save")
        }
    }
    
    func loadSynqrCode() -> SynqrCode? {
        return NSKeyedUnarchiver.unarchiveObjectWithFile(SynqrCode.ArchiveURL.path!) as? SynqrCode
    }
    
}
