//
//  ScanQRViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/25/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import AVFoundation
class ScanQRViewController: UIViewController {
    //MARK: - UI element
    @IBOutlet weak var scanQRView: UIView!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.back)
        guard let captureDevice = deviceDiscoverySession.devices.first else {
            print("Failed to get the camera device")
            return
        }
        do{
            //Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            // Set the input device for captureSession
            captureSession.addInput(input)
        }catch{
            // If any error occur, print error and don't continous do any more
            print(error)
            return
        }
        // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
        let captureMetadataOutput = AVCaptureMetadataOutput()
        captureSession.addOutput(captureMetadataOutput)
        // Set delegate and use the default dispatch queue to execute the call back
        captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        // Initialize the video preview layer and add it as a sublayer to the viewPreview scanQRView layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        videoPreviewLayer?.frame = scanQRView.layer.bounds
        scanQRView.layer.addSublayer(videoPreviewLayer!)
        //Start video capture
        captureSession.startRunning()
    }
    
    //MARK: - UI Event
    @IBAction func closeButtomWasPressed(_ sender: Any) {
        //Dismiss ScanQRVC
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectButtonWasPressed(_ sender: Any) {
    }
    
}
//
extension ScanQRViewController: AVCaptureMetadataOutputObjectsDelegate{
    
}
