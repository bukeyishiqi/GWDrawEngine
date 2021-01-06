//
//  OYUtils+CGHelper.swift
//  RxChat
//
//  Created by 陈琪 on 2017/8/7.
//  Copyright © 2017年 Carisok. All rights reserved.
//

import Foundation
import UIKit


//! 当前设备frame
let CURRENT_APP_FRAME = UIScreen.main.bounds

let kScreenH = CURRENT_APP_FRAME.height
let kScreenW = CURRENT_APP_FRAME.width
// 宽度比
let kWidthRatio = kScreenW / 375.0
// 高度比
let kHeightRatio = kScreenH / 667.0




extension OYUtils {

    // 自适应
    class func Adapt(_ value : CGFloat) -> CGFloat {
        return AdaptW(value)
    }
    
    // 自适应宽度
    class func AdaptW(_ value : CGFloat) -> CGFloat {
        
        return ceil(value) * kWidthRatio
    }
    
    // 自适应高度
    class func AdaptH(_ value : CGFloat) -> CGFloat {
        
        return ceil(value) * kHeightRatio
    }
    
    class func screenScale() -> CGFloat {
        let _scale: CGFloat = {
            return UIScreen.main.scale
        }()
        
        return _scale
    }

    class func screenFrame() -> CGRect {
        return UIScreen.main.bounds
    }
    
    class func screenWidth() -> CGFloat {
        return UIScreen.main.bounds.width
    }

    class func screenHeigth() -> CGFloat {
        return UIScreen.main.bounds.height
    }
    
    class func viewBx(_ view : UIView) -> CGFloat{
        return (view.frame.origin.x + view.frame.size.width)
    }
    
    class func viewBy(_ view : UIView) -> CGFloat{
        return (view.frame.origin.y + view.frame.size.height)
    }
    
    class func viewH(_ view : UIView) -> CGFloat {
        return view.frame.size.height
    }
    
    /** 导航栏＋状态栏高度 20这个值不能使用AppStatusBarHeight替换因为热点和电话中 */
    class func NaviBarAndStatusBarHeight() -> CGFloat {
        return CGFloat((44 + (isIPhoneX() ? 44 : 20)))
    }
    
    /*TabBar高度*/

    class func TabBarHeight() -> CGFloat {
      return (isIPhoneX() ? (49.0 + 34.0) : (49.0))
    }
    
    class func HomeIndicatorHeitht() -> CGFloat {
      return (isIPhoneX() ? (34.0) : (0))
    }

    class func pixelAlignForFloat(_ position: CGFloat) -> CGFloat {
        let scale = OYUtils.screenScale()
        return round(position * scale) / scale
    }
    
    
    class func screenContentHeight() -> CGFloat {
        return screenHeigth() - HomeIndicatorHeitht() - NaviBarAndStatusBarHeight()
    }
    
}
