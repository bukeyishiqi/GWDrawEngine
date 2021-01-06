//
//  ViewController+Refresh.swift
//  iboss
//
//  Created by 陈琪 on 2018/7/24.
//  Copyright © 2018年 Carisok. All rights reserved.
//

import UIKit

// MARK: 添加菊花
//extension UIViewController {
//
//    func startHudAnimating(_ message: String? = nil) {
//        self.hud = OYUtils.showHUD(view: self.view, msg: message)
//    }
//
//    func stopHudAnimating() {
//        self.hud?.hide(animated: true)
//    }
//
//    private struct hud_associatedKeys {
//        // 菊花
//        static let mbprogressHUD  = UnsafeRawPointer.init(bitPattern: "cs_mbprogressHUD".hashValue)
//    }
//
//
//    // MARK: 刷新属性
//    var hud: MBProgressHUD? {
//        set {
//            objc_setAssociatedObject(self, hud_associatedKeys.mbprogressHUD!, newValue as AnyObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//        get {
//            if let hud = objc_getAssociatedObject(self, hud_associatedKeys.mbprogressHUD!) as? MBProgressHUD {
//                return hud
//            }
//            return nil
//        }
//    }
//}


extension UIViewController {
    /** 页面返回时需要执行闭包*/
    typealias BackHandleBlock = ((_ args: Any?) -> Void)?

    private struct cs_associatedKeys {
        static let backHandleBlock  = UnsafeRawPointer.init(bitPattern: "cs_backHandleBlock".hashValue)
    }
    
    var backHandleBlock: BackHandleBlock {
        set {
            objc_setAssociatedObject(self, cs_associatedKeys.backHandleBlock!, newValue as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let complete = objc_getAssociatedObject(self, cs_associatedKeys.backHandleBlock!) as? BackHandleBlock {
                return complete
            }
            return nil
        }
    }
}


extension UIView {


    
    private struct cs_associatedKeys {
        // 唯一id
        static let only_id  = UnsafeRawPointer.init(bitPattern: "view_only_id".hashValue)
        
        // 被添加时的Margin
        static let margin = UnsafeRawPointer.init(bitPattern: "view_margin".hashValue)
        // 被添加时的宽度约束
        static let constraint_width = UnsafeRawPointer.init(bitPattern: "view_constraint_width".hashValue)

        // View关联ActionEntry
        static let actionEntry =  UnsafeRawPointer.init(bitPattern: "view_actionEntry".hashValue)
        
        // View关联的节点信息
        static let node = UnsafeRawPointer.init(bitPattern: "view_node".hashValue)
        
        // View点击手势
        static let tapGesture = UnsafeRawPointer.init(bitPattern: "view_tapGesture".hashValue)
    }
    
    // MARK: 刷新属性
    var only_id: String? {
        set {
            objc_setAssociatedObject(self, cs_associatedKeys.only_id!, newValue as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let only_id = objc_getAssociatedObject(self, cs_associatedKeys.only_id!) as? String {
                return only_id
            }
            return nil
        }
    }
    
    /// 边距
    var margin: [Int]? {
        set {
            objc_setAssociatedObject(self, cs_associatedKeys.margin!, newValue as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let margin = objc_getAssociatedObject(self, cs_associatedKeys.margin!) as? [Int] {
                return margin
            }
            return nil
        }
    }
    
    // 宽度约束
    var constraint_width: Constraint? {
        set {
            objc_setAssociatedObject(self, cs_associatedKeys.constraint_width!, newValue as AnyObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let constraint_width = objc_getAssociatedObject(self, cs_associatedKeys.constraint_width!) as? Constraint {
                return constraint_width
            }
            return nil
        }
    }
    
    var actionEntry: ActionEntry? {
        set {
            objc_setAssociatedObject(self, cs_associatedKeys.actionEntry!, newValue as AnyObject, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        get {
            if let actionEntry = objc_getAssociatedObject(self, cs_associatedKeys.actionEntry!) as? ActionEntry {
                return actionEntry
            }
            return nil
        }
    }
    
    var node: BaseLayoutElement? {
        set {
            objc_setAssociatedObject(self, cs_associatedKeys.node!, newValue as AnyObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let node = objc_getAssociatedObject(self, cs_associatedKeys.node!) as? BaseLayoutElement {
                return node
            }
            return nil
        }
    }
    
    var tapGesture: UITapGestureRecognizer? {
        set {
            objc_setAssociatedObject(self, cs_associatedKeys.tapGesture!, newValue as AnyObject, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            if let tap = objc_getAssociatedObject(self, cs_associatedKeys.tapGesture!) as? UITapGestureRecognizer {
                return tap
            }
            return nil
        }
    }
}
