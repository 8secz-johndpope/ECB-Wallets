//
//  ScanQRViewController.swift
//  ECB-Wallet
//
//  Created by NGUYENLONGTIEN on 8/25/20.
//  Copyright © 2020 NGUYENLONGTIEN. All rights reserved.
//

import UIKit
import AVFoundation
protocol scanQRDelegate:class {
    func getInfoQRCode(_ infoQR:String)
}
class ScanQRViewController: UIViewController {
    //MARK: - UI element
    @IBOutlet weak var scanQRView: UIView!
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView: UIView?
    
    var infoQRCode:String?
    
    weak var delegate:scanQRDelegate?
    //MARK: - UI ViewController
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //Check internet are available
               if CheckInternet.Connection(){
                   print("Internet is available")
               }else{
                   //Show dialogVC
                   let diglogVC = DialogViewController()
                   diglogVC.modalPresentationStyle = .custom
                   present(diglogVC, animated: true, completion: nil)
               }
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
    override func viewWillDisappear(_ animated: Bool) {
        // Stop Scan QR code when this will dismiss
        self.stopScanQRCode()
    }
    
    //MARK: - UI Event
    @IBAction func closeButtomWasPressed(_ sender: Any) {
        //Dismiss ScanQRVC
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectButtonWasPressed(_ sender: Any) {
        var pickerImage = UIImagePickerController()
        pickerImage.sourceType = .photoLibrary
        pickerImage.allowsEditing = true
        pickerImage.delegate = self
        self.present(pickerImage, animated: true, completion: nil)
    }
    //MARK: - Helper Method
    func stopScanQRCode(){
        if captureSession.isRunning == true {
            captureSession.stopRunning()
        }
    }
    func startScanQRCode(){
        if captureSession.isRunning == false {
            captureSession.startRunning()
        }
    }
    
}
//MARK: AVCaptureMetadataOutputObjectsDelegate
extension ScanQRViewController: AVCaptureMetadataOutputObjectsDelegate{
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        //When get output we will stop scan QR code
        self.stopScanQRCode()
        //Get result and convert to stringValue and pass into getInfoQRCode function
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else {return}
            guard let stringValue = readableObject.stringValue else {return}
            infoQRCode = stringValue
            self.delegate?.getInfoQRCode(infoQRCode!)
            self.dismiss(animated: true, completion: nil)
        }
    }
}
//MARK: UIImagePickerControllerDelegate
extension ScanQRViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let qrCodeImage = info[.editedImage] as? UIImage else {
            print("No image found")
            return
        }
        let detector:CIDetector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy:CIDetectorAccuracyHigh])!
        let ciImg:CIImage = CIImage(image: qrCodeImage)!
        let features = detector.features(in: ciImg)
        for feature in features as! [CIQRCodeFeature] {
            guard let stringValue = feature.messageString else {return}
            infoQRCode = stringValue
            self.delegate?.getInfoQRCode(infoQRCode!)
            print(infoQRCode)
        }
        self.dismiss(animated: true, completion: nil)
        let delayInSecond = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + delayInSecond) {
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
