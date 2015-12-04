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
    
    var category: [String]?
    var content: [String]?


    var qrcodeImage: CIImage!
    
    @IBOutlet weak var imgQRCode: UIImageView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func unwindToQRCodeVC(segue: UIStoryboardSegue) {
        let sourceVC = segue.sourceViewController as! MainTableViewController
        
        category = sourceVC.models
        content = sourceVC.content
    
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }
    
    override func viewDidAppear(animated: Bool) {
        if (category == nil) || (content == nil)
        {
            statusLabel.text = "Please enter your personal data"
        }
        else
        {
            
            statusLabel.text = "Your Synqr Code"
            createQRCode()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func createQRCode(){
        if qrcodeImage == nil {
            
            var jsonString : String = "{"
            
            jsonString += "\"check\":\"Synqr\","
            
            for (var i = 0; i < content!.count; i++)
            {
                jsonString += "\""
                jsonString += category![i]
                jsonString += "\""
                jsonString += ":"
                jsonString += "\""
                jsonString += content![i]
                jsonString += "\""
                if (i < content!.count - 1){
                    jsonString += ","
                }
            }
            jsonString += "}"
            print(jsonString)
            
            let data = jsonString.dataUsingEncoding(NSISOLatin1StringEncoding, allowLossyConversion: false)
            
            let filter = CIFilter(name: "CIQRCodeGenerator")
            
            filter!.setValue(data, forKey: "inputMessage")
            filter!.setValue("Q", forKey: "inputCorrectionLevel")
            qrcodeImage = filter!.outputImage
            
            displayQRCodeImage()
        }
        else {
            imgQRCode.image = nil
            qrcodeImage = nil
            
        }

    }
    
    
    func displayQRCodeImage() {
        let scaleX = imgQRCode.frame.size.width / qrcodeImage.extent.size.width
        let scaleY = imgQRCode.frame.size.height / qrcodeImage.extent.size.height
        
        let transformedImage = qrcodeImage.imageByApplyingTransform(CGAffineTransformMakeScale(scaleX, scaleY))
        
        imgQRCode.image = UIImage(CIImage: transformedImage)
    }
    
    
    
}


