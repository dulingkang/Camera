//
//  SSCameraViewController.swift
//  SSCamera
//
//  Created by ShawnDu on 15/12/11.
//  Copyright © 2015年 Shawn. All rights reserved.
//

import UIKit
import AVFoundation

class SSCameraViewController: UIViewController, SSCameraViewDelegate {

    var camera: SSCamera!
    var cameraView: SSCameraView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        self.view.backgroundColor = kBackgroundColor
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        cameraView = SSCameraView.init(frame: self.view.bounds)
        cameraView.delegate = self
        self.view.addSubview(cameraView)
        camera = SSCamera.init(sessionPreset: AVCaptureSessionPresetPhoto, position: .Front)
        cameraView.preview.layer.addSublayer(camera.previewLayer)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillAppear(animated: Bool) {
        camera.startCapture()
    }
    
    //MARK: - delegate
    func backButtonPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func switchButtonPressed() {
        camera.switchCamera()
    }
    
    func captureButtonPressed() {
        camera.takePhoto { (image) -> Void in
            print("captured photo size:", image?.size)
            self.camera.startCapture()
        }
    }

}
