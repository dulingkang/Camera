//
//  SSImageHelper.swift
//  SSCamera
//
//  Created by ShawnDu on 15/12/15.
//  Copyright © 2015年 Shawn. All rights reserved.
//

import UIKit

let kLimitSize: CGFloat = 1280

struct SSImageHelper {
    
    static func scaleImage(inputImage: UIImage, isFrontCamera: Bool) -> UIImage {
        var width = inputImage.width
        var height = inputImage.height
        var outputImage = inputImage
        let maxValue = max(width, height)
        if isFrontCamera {
            outputImage = UIImage(CGImage: inputImage.CGImage!, scale: inputImage.scale, orientation: UIImageOrientation.LeftMirrored)
        }
        if maxValue > kLimitSize {
            if  height >= width {
                height = kLimitSize
                width = inputImage.width / inputImage.height * kLimitSize
            } else {
                width = kLimitSize
                height = inputImage.height / inputImage.width * kLimitSize
            }
        }
        outputImage = SSImageHelper.scaleToSize(outputImage, size: CGSizeMake(width, height))
        
        return outputImage
    }
    
    static func scaleToSize(inputImage: UIImage, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        inputImage.drawInRect(CGRectMake(0,0, size.width, size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage
    }
    
    static func clipImage(inputImage: UIImage, toRect: CGRect) -> UIImage {
        let cgImageRef = inputImage.CGImage
        let subImageRef = CGImageCreateWithImageInRect(cgImageRef, toRect)
        let smallBounds = CGRectMake(0, 0, CGFloat(CGImageGetWidth(subImageRef)), CGFloat(CGImageGetHeight(subImageRef)))
        UIGraphicsBeginImageContext(smallBounds.size)
        let context = UIGraphicsGetCurrentContext()
        CGContextDrawImage(context, smallBounds, subImageRef)
        let smallImage = UIImage(CGImage: subImageRef!)
        UIGraphicsEndImageContext()
        return smallImage
    }
}
