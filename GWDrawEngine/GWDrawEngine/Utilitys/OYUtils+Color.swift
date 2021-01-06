//
//  OYUtils+Color.swift
//  BodyBuild
//
//  Created by 陈琪 on 2018/12/5.
//  Copyright © 2018年 Carisok. All rights reserved.
//

import UIKit


extension UIColor {
    
    static func RGBCOLOR(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor.init(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: 1)
    }
    
    static func RGBACOLOR(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor.init(red: (r)/255.0, green: (g)/255.0, blue: (b)/255.0, alpha: a)
    }
    
    // MARK: - 颜色转换 IOS中十六进制的颜色转换为UIColor
    static func colorFromHexString(hex: String) -> UIColor {
        
        var  Str  = (hex as NSString).trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hex.hasPrefix("#"){
            Str=(hex as NSString).substring(from: 1)
        }
        
        let redStr = (Str as NSString ).substring(to: 2)
        let greenStr = ((Str as NSString).substring(from: 2) as NSString).substring(to: 2)
        let blueStr = ((Str as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        
        Scanner(string:redStr).scanHexInt32(&r)
        Scanner(string: greenStr).scanHexInt32(&g)
        Scanner(string: blueStr).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
    }
    
}


 // MARK: 背景渐变颜色值
extension UIView {
    
    // MARK: 添加渐变色图层
    // 创建渐变背景颜色图片 gradientType : 1 左右， 2 上下 3 左上到右下 4 左下到右上
    func setGradientColor(colors: [Any], gradientType: Int) {
        let newColors = colors.map { (color) -> Any in
            if let colorString = color as? String {
                return UIColor.colorFromHexString(hex: colorString).cgColor
            } else {
                return (color as! UIColor).cgColor
            }
        }
        
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        
        // 第二个参数是起始位置，第三个参数是终止位置
        let startPoint: CGPoint
        let endPoint: CGPoint
        switch gradientType {
        case 1:
            startPoint = CGPoint.init(x: 0, y: 0.5)
            endPoint = CGPoint.init(x: 1, y: 0.5)
            break
        case 2:
            startPoint = CGPoint.init(x: 0.5, y: 1)
            endPoint = CGPoint.init(x: 0.5, y: 1)
            break
        case 3:
            startPoint = CGPoint.init(x: 0, y: 1)
            endPoint = CGPoint.init(x: 1, y: 0)
            break
        case 4:
            startPoint = CGPoint.init(x: 0, y: 0)
            endPoint = CGPoint.init(x: 1, y: 1)
            break
        default:
            startPoint = CGPoint.init(x: 0.0, y: 1)
            endPoint = CGPoint.init(x: 1, y: 0)
            break
        }
        
        var gradientLayer: CAGradientLayer!
        removeGradientLayer()

        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.layer.bounds
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.colors = newColors
        gradientLayer.cornerRadius = self.layer.cornerRadius
        gradientLayer.masksToBounds = true
        self.layer.insertSublayer(gradientLayer, at: 0)
        self.backgroundColor = UIColor.clear
    }
    
    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    func removeGradientLayer() {
        if let sl = self.layer.sublayers {
            for layer in sl {
                if layer.isKind(of: CAGradientLayer.self) {
                    layer.removeFromSuperlayer()
                }
            }
        }
    }
}
