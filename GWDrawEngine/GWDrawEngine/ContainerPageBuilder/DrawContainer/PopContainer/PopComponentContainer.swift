//
//  PopComponentContainer.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/6/30.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit

class PopComponentContainer: FWPopupView {

    var containerView: ContainerView?

    /*********系统弹框事件回调闭包*********/
    var cancelAction: (()->Void)?
    var confirmAction: (()->Void)?
    /**********************************/
    
    /*********PickerView确定选择弹框*******/
    var pickerFinishComplete: ((_ selectedValue: Any) -> Void)?
    /***********************************/
    
    init(layoutElement: BaseLayoutElement, updateData: Data?, updateHeight: Int? = nil) {
        let width = ceilf(Float(UIScreen.main.bounds.size.width * CGFloat(layoutElement.ratioW ?? 1)))
        var height = ceilf(width / Float((layoutElement.ratio ?? 0)))
        if height == 0 {
            height = Float(layoutElement.height ?? 0)
        }
        if let h = updateHeight {
            height = Float(h)
        }
        
        super.init(frame: CGRect.init(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))

        self.containerView = ContainerView.init(rootNode: layoutElement)
        self.containerView?.delegate = self
        self.addSubview(self.containerView!)
        self.backgroundColor = UIColor.clear
        if let marign = self.containerView!.margin {
            self.containerView!.snp.makeConstraints { (make) in
                make.top.equalTo(marign[0])
                make.bottom.equalTo(-marign[1])
                make.left.equalTo(marign[2])
                make.right.equalTo(-marign[3])
            }
        } else {
            self.containerView!.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        self.attachedView = Application.shared.navigator.root?.topViewController?.view
        
        // 通过布局元素设置c容器属性
        let vProperty = FWPopupViewProperty()
        vProperty.popupCustomAlignment = FWPopupCustomAlignment(rawValue: layoutElement.popupCustomAlignment ?? 0) ?? .center
        vProperty.popupAnimationType =  FWPopupAnimationType(rawValue: layoutElement.popupAnimationType ?? 0) ?? .scale3D
        if let maskViewColor = layoutElement.maskViewColor {
             vProperty.maskViewColor =  UIColor.colorFromHexString(hex: maskViewColor)
        } else {
            vProperty.maskViewColor =  UIColor(white: 0, alpha: 0.5)
        }
        vProperty.touchWildToHide = "1"
        if let edgeInsets = layoutElement.edgeInsets {
            vProperty.popupViewEdgeInsets = UIEdgeInsets(top: CGFloat(edgeInsets[0]), left: CGFloat(edgeInsets[1]), bottom: CGFloat(edgeInsets[2]), right: CGFloat(edgeInsets[3]))
        }

        vProperty.animationDuration = 0.2
        
        self.vProperty = vProperty
        
        if let d = updateData {
            self.containerView?.update(data: d)
        }
    }

    // 系统弹框
    convenience init(layoutElement: BaseLayoutElement, updateData: Data?, cancelAction:(()->Void)?, confirmAction: (()->Void)?) {
        self.init(layoutElement: layoutElement, updateData: updateData, updateHeight: nil)
        self.cancelAction = cancelAction
        self.confirmAction = confirmAction
    }
    
    // 验证码弹框
    convenience init(layoutElement: BaseLayoutElement, updateData: Data?, inputVerifyFinishAction: VerfiyInputFinishAction?) {
        self.init(layoutElement: layoutElement, updateData: updateData, updateHeight: nil)
    }

    // picker选择器
    convenience init(layoutElement: BaseLayoutElement, dataSource: Any, updateData: Data?, updateHeight: Int?, finishComplete:((_ selectedValue: Any) -> Void)?) {
        self.init(layoutElement: layoutElement, updateData: updateData, updateHeight: updateHeight)
        self.pickerFinishComplete = finishComplete
        self.containerView?.pickerView?.buildPickerViewData(data: dataSource)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /***********************/
}

 // MARK: ContainerViewDelegate
extension PopComponentContainer: ContainerViewDelegate {
    func containerViewHeaderRefreshAction(view: UIView) {
        
    }
    
    func containerViewFooterRefreshAction(view: UIView) {
        
    }
    
 
    
    func containerViewTextFieldEndEdit(textfield: GWTextField) {
        
    }
    
    func containerViewClickedByAction(view: UIView, action: ActionEntry) {
        if let a = action.actionType, a == "cancel" { // 隐藏
            self.hide()
            if let cancel = self.cancelAction {
                cancel()
            }
        } else if let a = action.actionType, a == "confirm" {
         // 确定点击，回调传参
            self.hide()
        
            if let c = self.confirmAction {
                c()
            }
        } else if let a = action.actionType, a == "pickerSelected" {
            self.hide()
            if let c = self.pickerFinishComplete {
                // 获取picker值
                if let selectN = self.containerView?.pickerView?.selectedRow(inComponent: 0) {
                    if let value = self.containerView?.pickerView?.pickerViewDataSource[selectN] {
                        if let v = value as? String {
                            c(v)
                        } else if let v = value as? [String: Any] {
                            c(v.keys.first ?? "")
                        }
                    }
                }
                
            }
        }
        
    }
    
    
}
