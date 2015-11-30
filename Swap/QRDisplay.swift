//
//  QRDisplay.swift
//  Swap
//
//  Created by Walker Jordan on 11/27/15.
//  Copyright © 2015 James Kim. All rights reserved.
//

import UIKit

class QRDisplay: UIViewController {

    @IBOutlet weak var qrCode: UIImageView!
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        qrCode.image = image
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
