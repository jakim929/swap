//
//  FirstViewController.swift
//  Swap
//
//  Created by James Kim on 11/23/15.
//  Copyright © 2015 James Kim. All rights reserved.
//

import UIKit
import AVFoundation

class FirstViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var qrCodeResult: UILabel!
    @IBOutlet weak var scanOutput: UILabel!
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    
    var jsonValue:String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.configureVideoCapture()
        self.addVideoPreviewLayer()
        self.initializeQRView()
        
        // Bring labels to front above the video layer
        self.view.bringSubviewToFront(qrCodeResult)
        self.view.bringSubviewToFront(scanOutput)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureVideoCapture() {
        
        let objCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var error:NSError?
        let objCaptureDeviceInput: AnyObject!
        do {
            objCaptureDeviceInput = try AVCaptureDeviceInput(device: objCaptureDevice) as AVCaptureDeviceInput
            
        } catch let error1 as NSError {
            error = error1
            objCaptureDeviceInput = nil
        }
        if (error != nil) {
            
            let alertController : UIAlertController = UIAlertController(title: "Device Error", message: "Capturing device not supported :P", preferredStyle: UIAlertControllerStyle.Alert)
            
            presentViewController(alertController, animated: true, completion: nil)
            return
        }
        captureSession = AVCaptureSession()
        captureSession?.addInput(objCaptureDeviceInput as! AVCaptureInput)
        let objCaptureMetadataOutput = AVCaptureMetadataOutput()
        
        captureSession?.addOutput(objCaptureMetadataOutput)
        objCaptureMetadataOutput.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        objCaptureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
    }
    
    func addVideoPreviewLayer()
    {
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        videoPreviewLayer?.frame = view.layer.bounds
        self.view.layer.addSublayer(videoPreviewLayer!)
        captureSession?.startRunning()
        

    }
    
    func initializeQRView()
    {
        qrCodeFrameView = UIView()
        qrCodeFrameView?.layer.borderColor = UIColor.redColor().CGColor
        qrCodeFrameView?.layer.borderWidth = 5
        self.view.addSubview(qrCodeFrameView!)
        self.view.bringSubviewToFront(qrCodeFrameView!)
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRectZero
            qrCodeResult.text = "Please Point the Camera at a Card"
            return
        }
        let objMetadataMachineReadableCodeObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if objMetadataMachineReadableCodeObject.type == AVMetadataObjectTypeQRCode {
            let objBarCode = videoPreviewLayer?.transformedMetadataObjectForMetadataObject(objMetadataMachineReadableCodeObject as AVMetadataMachineReadableCodeObject) as! AVMetadataMachineReadableCodeObject
            qrCodeFrameView?.frame = objBarCode.bounds;
            if objMetadataMachineReadableCodeObject.stringValue != nil {
                jsonValue = objMetadataMachineReadableCodeObject.stringValue
                qrCodeResult.text = jsonValue
            }

            
            if let dataFromString = jsonValue!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
                let json = JSON(data: dataFromString)
                
                if let fbName = json["phone"].string{
                    scanOutput.text = fbName;
                }
            }

        }
    }
}

