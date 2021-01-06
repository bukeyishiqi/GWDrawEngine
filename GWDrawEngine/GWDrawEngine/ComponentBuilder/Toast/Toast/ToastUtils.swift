//
//  ToastUtils.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/23.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit


class ToastUtils {
    
   /** 显示永久遮罩 Toast */
   static func showMaskToast(view: UIView, message : String) {
    
        let maskView = UIView().then {
            $0.backgroundColor = UIColor.init(white: 0.5, alpha: 0.7)
            $0.frame = view.bounds
        }
        view.addSubview(maskView)
        
        let titleLabel = UILabel().then {
            $0.textColor = UIColor.white
            $0.backgroundColor =  UIColor.colorFromHexString(hex: "#2DCA96")
            $0.textAlignment = .center
            $0.font = UIFont.systemFont(ofSize: 16)
            $0.text = message
            $0.layer.cornerRadius = 10
            $0.layer.masksToBounds = true
        }
        
        let size = titleLabel.sizeThatFits(CGSize.init(width: view.frame.width - 40, height: 50))
        titleLabel.frame = CGRect.init(x: 0, y: 0, width: size.width + 20, height: 50)
        titleLabel.center = CGPoint.init(x: maskView.frame.width/2, y: maskView.frame.height/2)
        
        maskView.addSubview(titleLabel)
        
    }

      /** 显示Toast */
    static func showToast(view : UIView?, message : String) {
      
            var toastStyle = ToastStyle()
            toastStyle.titleColor = UIColor.white
            toastStyle.backgroundColor = UIColor.colorFromHexString(hex: "666666")
            toastStyle.titleFont = UIFont.systemFont(ofSize: 12)
        
        view?.makeToast(message, duration: 2, position: .bottom, title: nil, image: nil, style: toastStyle, completion: nil)

    }

      /** 显示Toast */
      static func showToast(viewController : UIViewController?, message : String) {

        var toastStyle = ToastStyle()
        toastStyle.titleColor = UIColor.white
        toastStyle.backgroundColor = UIColor.colorFromHexString(hex: "666666")
        toastStyle.titleFont = UIFont.systemFont(ofSize: 12)
        
       viewController?.view.makeToast(message, duration: 2, position: .bottom, title: nil, image: nil, style: toastStyle, completion: nil)

    }

     /** 显示Toast */
    static func showWindowsToast(message : String) {
  
        var toastStyle = ToastStyle()
        toastStyle.titleColor = UIColor.white
        toastStyle.backgroundColor = UIColor.colorFromHexString(hex: "666666")
        toastStyle.titleFont = UIFont.systemFont(ofSize: 12)
                
        UIApplication.shared.keyWindow?.makeToast(message, duration: 10, position: .bottom, title: nil, image: nil, style: toastStyle, completion: nil)
    }

    
    /// 通过节点显示Toast
    /// - Parameter node: 渲染节点
    static func showToastByToastNode(node: ToastNode, message: String) {
        var toastStyle = ToastStyle()
        toastStyle.titleColor = UIColor.colorFromHexString(hex: node.titleColor ?? "#ffffff")
        toastStyle.backgroundColor = UIColor.colorFromHexString(hex: node.backgroudColor ?? "#666666")
        toastStyle.titleFont = UIFont.systemFont(ofSize: CGFloat(node.titleFont ?? 16))
                
        UIApplication.shared.keyWindow?.makeToast(message, duration: 2, position: node.getPosition(), title: nil, image: nil, style: toastStyle, completion: nil)
    }
}
