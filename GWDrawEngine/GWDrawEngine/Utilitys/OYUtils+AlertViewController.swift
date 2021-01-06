//
//  OYUtils+AlertViewController.swift
//  iboss
//
//  Created by 陈琪 on 2018/6/27.
//  Copyright © 2018年 Carisok. All rights reserved.
//

import UIKit


extension OYUtils {
    
    typealias alterAction = ((_ actionIndex: Int) ->Void)?
    
    /** 创建AlertViewController index: 1为取消按钮 2为其他按钮*/
    static func createAlertViewController(title: String? = nil,
                                          message: String,
                                          cancelButtonTitle: String? = nil,
                                          otherButtonTitles: String? = nil,
                                          action: alterAction) -> UIAlertController {
        return createAlertViewController(title: title, message: message, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: (otherButtonTitles != nil) ? [otherButtonTitles!] : nil, action: action, preferredStyle: .alert)
    }
    
    
    static func showAlter(message: String, in controller: UIViewController, action: alterAction) {
        
        let alter = createAlertViewController(title: nil, message: message, cancelButtonTitle: "确定", otherButtonTitles: nil, action: action)
        controller.present(alter, animated: true, completion: nil)
    }
    
    static func showAlter(message: String, cancelString: String, in controller: UIViewController, action: alterAction) {
        
        let alter = createAlertViewController(title: nil, message: message, cancelButtonTitle: cancelString, otherButtonTitles: nil, action: action)
        controller.present(alter, animated: true, completion: nil)
    }
    
    // MARK: 创建ActionSheet
    static func createActionSheetViewController(title: String? = nil,
                                                message: String? = nil,
                                                cancelButtonTitle: String? = nil,
                                                otherButtonTitles: [String],
                                                action: alterAction) -> UIAlertController {
        return createAlertViewController(title: title, message: message, cancelButtonTitle: cancelButtonTitle, otherButtonTitles: otherButtonTitles, action: action, preferredStyle: .actionSheet)
    }
    
    
    
    /*******private********/
    private static func createAlertViewController(title: String? = nil,
                                                  message: String? = nil,
                                                  cancelButtonTitle: String? = nil,
                                                  otherButtonTitles: [String]? = nil,
                                                  action: alterAction, preferredStyle: UIAlertController.Style) -> UIAlertController {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: preferredStyle)
        
        if cancelButtonTitle != nil {
            let cancelAction = UIAlertAction.init(title: cancelButtonTitle, style: .cancel) { (_) in
                if action != nil {
                    action!(1)
                }
            }
            cancelAction.setValue(UIColor.gray, forKey: "titleTextColor")
            alert.addAction(cancelAction)
        }
        
        if otherButtonTitles != nil {
            
            for index in 0..<otherButtonTitles!.count {
                let otherAction = UIAlertAction.init(title: otherButtonTitles?[index], style: .default) { (_) in
                    if action != nil {
                        action!(index+2)
                    }
                }
                otherAction.setValue(UIColor.colorFromHexString(hex: "#0f87ea"), forKey: "titleTextColor")
                alert.addAction(otherAction)
            }
        }
        
        return alert
    }
}

// 用于UIAlertController的文字偏移
var subviews : [UIView]?
extension UIAlertController {
    var TJL_titleLabel : UILabel? {
        set {
        }
        get {
            if TJL_viewArray(root: self.view) != nil {
                return TJL_viewArray(root: self.view)![1] as? UILabel
            }
            return nil
        }
    }
    var TJL_messageLabel : UILabel? {
        set {
        }
        get {
            if TJL_viewArray(root: self.view) != nil {
                return TJL_viewArray(root: self.view)![2] as? UILabel
            }
            return nil
        }
    }
    
    func TJL_viewArray(root:UIView) -> [UIView]? {
        
        subviews = nil
        for item in root.subviews{
            
            if subviews != nil {
                break
            }
            
            if item is UILabel{
                subviews = root.subviews
                return subviews!
            }
            TJL_viewArray(root: item)
        }
        return subviews
    }
}





