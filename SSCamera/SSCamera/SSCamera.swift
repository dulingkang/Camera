//
//  SSCamera.swift
//  SSCamera
//
//  Created by ShawnDu on 15/12/11.
//  Copyright © 2015年 Shawn. All rights reserved.
//

import UIKit
import AVFoundation

class SSCamera: NSObject{
    
    var session: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    var captureDevice: AVCaptureDevice!
    var stillImageOutput: AVCaptureStillImageOutput!
    var input: AVCaptureDeviceInput!
    var isUsingFront = true
    var cameraPosition: AVCaptureDevicePosition {
        get {
            return input.device.position
        }
        set {
        }
    }
    
    init(sessionPreset: String, position: AVCaptureDevicePosition) {
        session = AVCaptureSession.init()
        session.sessionPreset = sessionPreset
        
        previewLayer = AVCaptureVideoPreviewLayer.init(session: session)
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        previewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kCameraBottomHeight - kNavigationHeight)
        if kScreenHeight == kIPhone4sHeight {
            previewLayer.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight - kCameraBottom4SHeight - kNavigationHeight)
        }
        
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        for device in devices {
            if device.position == position {
                captureDevice = device as! AVCaptureDevice
            }
        }
        
        do {
            input = try AVCaptureDeviceInput.init(device: captureDevice)
            if session.canAddInput(input) {
                session.addInput(input)
            }
        } catch {
            print("add video input error")
        }
        
        stillImageOutput = AVCaptureStillImageOutput.init()
        let outputSettings = NSDictionary.init(object: AVVideoCodecJPEG, forKey: AVVideoCodecKey)
        stillImageOutput.outputSettings = outputSettings as [NSObject : AnyObject]
        if session.canAddOutput(stillImageOutput) {
            session.addOutput(stillImageOutput)
        }
        session.startRunning()
    }
    
    //MARK: - public method
    func takePhoto(complete: ((UIImage?) -> Void)) {
        if let videoConnection = stillImageOutput.connectionWithMediaType(AVMediaTypeVideo) {
            stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (sampleBuffer, error) -> Void in
                self.session.stopRunning()
                if sampleBuffer != nil {
                    let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(sampleBuffer)
                    let image = UIImage.init(data: imageData)
                    complete(image)
                } else if error != nil {
                    print("Take photo error", error)
                }
            })
        }
    }
    
    func startCapture() {
        if !session.running {
            session.startRunning()
        }
    }
    
    func stopCapture() {
        if session.running {
            session.stopRunning()
        }
    }
    
    func switchCamera() {
        var currentCameraPosition = self.cameraPosition
        if currentCameraPosition == AVCaptureDevicePosition.Back {
            currentCameraPosition = AVCaptureDevicePosition.Front
            isUsingFront = true
        } else {
            currentCameraPosition = AVCaptureDevicePosition.Back
            isUsingFront = false
        }
        let devices = AVCaptureDevice.devicesWithMediaType(AVMediaTypeVideo)
        var afterSwitchCamera: AVCaptureDevice?
        var newInput: AVCaptureDeviceInput?
        for device in devices {
            if device.position == currentCameraPosition {
                afterSwitchCamera = device as? AVCaptureDevice
            }
        }
        do {
            newInput = try AVCaptureDeviceInput.init(device: afterSwitchCamera)
            session.beginConfiguration()
            session.removeInput(input)
            if session.canAddInput(newInput) {
                input = newInput
            }
            session.addInput(input)
            session.commitConfiguration()
            captureDevice = afterSwitchCamera
        } catch {
            print("add new input error when switch")
        }
    }
}
