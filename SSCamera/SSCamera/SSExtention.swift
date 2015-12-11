//
//  SSExtention.swift
//  SSCamera
//
//  Created by ShawnDu on 15/12/11.
//  Copyright © 2015年 Shawn. All rights reserved.
//

import UIKit

extension UIView {
    var width : CGFloat{
        return self.frame.size.width
    }
    var height : CGFloat{
        return self.frame.size.height
    }
    var top : CGFloat{
        return self.frame.origin.y
    }
    var right : CGFloat{
        return self.frame.origin.x + self.frame.size.width
    }
    var bottom : CGFloat{
        return self.frame.origin.y + self.frame.size.height
    }
    var left : CGFloat{
        return self.frame.origin.x
    }
}

extension UIImage {
    var width : CGFloat{
        return self.size.width
    }
    var height : CGFloat{
        return self.size.height
    }
}
