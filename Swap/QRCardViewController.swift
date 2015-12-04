//
//  QRCardViewController.swift
//  Swap
//
//  Created by James Kim on 12/4/15.
//  Copyright © 2015 James Kim. All rights reserved.
//

import Foundation

class QRCardViewController : UIViewController
{
    
    
    @IBOutlet weak var imgQRCode: UIImageView!
    
    @IBAction func unwindToQRCodeVC(segue: UIStoryboardSegue) {
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}


