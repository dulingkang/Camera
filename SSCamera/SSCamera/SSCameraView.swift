//
//  SSCameraView.swift
//  SSCamera
//
//  Created by ShawnDu on 15/12/11.
//  Copyright © 2015年 Shawn. All rights reserved.
//

import UIKit

protocol SSCameraViewDelegate {
    func backButtonPressed()
    func switchButtonPressed()
    func captureButtonPressed()
}

class SSCameraView: UIView {
    
    var delegate: SSCameraViewDelegate?
    var preview: UIView!
    var bottomHeight = kCameraBottomHeight
    
    //MARK: - life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initViews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)!
    }
    
    //MARK: - delegate
    func backButtonPressed() {
        self.delegate?.backButtonPressed()
    }
    
    func switchButtonPressed() {
        self.delegate?.switchButtonPressed()
    }
    
    func captureButtonPressed() {
        self.delegate?.captureButtonPressed()
    }
    
    //MARK: - private method
    private func initViews() {
        if kScreenHeight == kIPhone4sHeight {
            bottomHeight = kCameraBottom4SHeight
        }
        self.addPreView()
        self.addTopView()
        self.addBottomView()
    }
    
    private func addTopView() {
        let topView = UIView.init(frame: CGRectMake(0, 0, kScreenWidth, kNavigationHeight))
        topView.backgroundColor = UIColor.blackColor()
        
        let switchButton = UIButton.init(frame: CGRectMake(kScreenWidth - kButtonClickWidth, 0, kButtonClickWidth, kButtonClickWidth))
        switchButton.setImage(UIImage(named: "SwitchNormal"), forState: UIControlState.Normal)
        switchButton.setImage(UIImage(named: "SwitchPress"), forState: UIControlState.Highlighted)
        switchButton.addTarget(self, action: "switchButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        topView.addSubview(switchButton)
        
        self.addSubview(topView)
    }
    
    private func addPreView() {
        preview = UIView.init(frame: CGRectMake(0, kNavigationHeight, self.width, self.height - kNavigationHeight - bottomHeight))
        self.addSubview(preview)
    }
    
    private func addBottomView() {
        let bottomView = UIView.init(frame: CGRectMake(0, self.height - kCameraBottomHeight, kScreenWidth, bottomHeight))
        bottomView.backgroundColor = UIColor(red: 0.04, green: 0.78, blue: 0.9, alpha: 1.0)
        self.addSubview(bottomView)
        
        let captureImage = UIImage(named: "CaptureNormal")
        let captureButton = UIButton.init(frame: CGRectMake((self.width - (captureImage?.width)!)/2, (bottomView.height - (captureImage?.height)!)/2, (captureImage?.width)!, (captureImage?.height)!))
        captureButton.setImage(captureImage, forState: UIControlState.Normal)
        captureButton.setImage(UIImage(named: "CapturePress"), forState: UIControlState.Highlighted)
        captureButton.addTarget(self, action: "captureButtonPressed", forControlEvents: UIControlEvents.TouchUpInside)
        bottomView.addSubview(captureButton)
    }
    
}
