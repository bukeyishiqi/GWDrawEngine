//
//  View.swift
//  icar
//
//  Created by 陈琪 on 2019/12/25.
//  Copyright © 2019 Carisok. All rights reserved.
//

import UIKit

public class GWView: UIView {

    convenience init(width: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: width, height: 0))
        snp.makeConstraints { (make) in
            make.width.equalTo(width)
        }
    }

    convenience init(height: CGFloat) {
        self.init(frame: CGRect(x: 0, y: 0, width: 0, height: height))
        snp.makeConstraints { (make) in
            make.height.equalTo(height)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
        
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    /***********************/
    
    func makeUI() {
        self.layer.masksToBounds = true
        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }

    func getCenter() -> CGPoint {
        return convert(center, from: superview)
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setDelayProperty()
    }
}


 // MARK: 处理需要延后执行的UI绘制问题
extension UIView {
    func setDelayProperty() {
        // 渐变背景
       if let gradientcolors = self.node?.backgroudGradientColors {
           if let type = self.node?.gradientType {
               self.setGradientColor(colors: gradientcolors, gradientType: type)
           }
       }
        
        // 差异圆角
        DrawComponentsUtils.drawRadiusLoction(view: self)
    }
}


 // MARK: 通用属性设置
extension UIView {
    /// 设置通用属性
    /// - Parameter property: 属性值
    func setNormalProperty(node: BaseLayoutElement) {
        if let color = node.backgroudColor {
            self.backgroundColor = UIColor.colorFromHexString(hex: color)
        } else {
            self.backgroundColor = UIColor.clear
        }
        
        // 渐变背景
        if node.backgroudGradientColors != nil {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GloablGradientcolorsNotifyKey), object: self)
        } else {
            self.removeGradientLayer()
        }
        
        if let c = node.cornerRadius, c > 0 {
            self.layer.cornerRadius = CGFloat(c)
             
        }
        
        if let radiusLoction = node.radiusLoction, radiusLoction.count > 0 { // 多方位圆角绘制
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalAddRadiusLoctionNotifyKey), object: self)
        }
        
        if let alpha = node.alpha {
            self.alpha = CGFloat(alpha)
        }
    }
}

 // MARK: 事件Action设置
extension UIView {
    func setViewAction(node: BaseLayoutElement) {

        // 添加事件处理
        if let action = node.action {
            if  self.tapGesture == nil {
                self.actionEntry = action
                self.isUserInteractionEnabled = true
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalAddEventNotifyKey), object: self)
            }
       } else {
           // 没有事件对象的移除响应手势
           if let g = self.gestureRecognizers {
               g.forEach { (gesture) in
                   if gesture.isKind(of: UITapGestureRecognizer.self) {
                       gesture.removeTarget(self, action: nil)
                   }
               }
                self.tapGesture = nil
               self.actionEntry = nil
           }
       }
    }
}


extension UIView {

    var inset: CGFloat {
        return 10
    }

    open func setPriority(_ priority: UILayoutPriority, for axis: NSLayoutConstraint.Axis) {
        self.setContentHuggingPriority(priority, for: axis)
        self.setContentCompressionResistancePriority(priority, for: axis)
    }
}


 // MARK: 状态切换通知添加
extension UIView {
    
    /// 添加View节点是否需要监听状态切换通知 备注：iOS9之后，即使开发者没有移除observer，Notification crash也不会再产生了。
    func addGlobalStateChangeNotify() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleStateChange(notify:)), name: NSNotification.Name(rawValue: GlobalStateChangeNotifyKey), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleSignNodeStateChange(notify:)), name: NSNotification.Name(rawValue: SignNodeStateChangeNotifyKey), object: nil)
    }
    
    
    /// 单节点状态变更通知
    @objc func handleSignNodeStateChange(notify: NSNotification) {
        if let elments = notify.object as? (BaseLayoutElement, [String: Any]) {
            // 如果当前节点的id与要更新的节点id相同
            if elments.0.id == self.node?.id {
                updateNode(state: elments.1)
            }
        }
    }
    
    /// 全局状态变更通知
    /// - Parameter notify: 通知
     @objc func handleStateChange(notify: NSNotification) {
        if let globalState = notify.object as? [String: Any] {
//            updateNode(state: globalState)
        }
    }
}

 // MARK:处理状态更新
extension UIView {
    
    private func updateNode(state: [String: Any]) {
        // 从全局状态值中获取需要的关联的状态值
        // 获取状态值名称
        if let stateName = self.node?.dynamicProperty?.connectState {

            // 从通知的状态对象获取状态名值
            if let stateValue = state[stateName] as? String {
                
                // 状态不相同，需要重新刷新
                // , stateValue != oldNode.dynamicProperty?.currentState
                if let oldNode = self.node {
                    oldNode.dynamicProperty?.currentState = stateValue

                    let updateNode = updateDynamicCurrentPropertyState(oldNode: oldNode, newState: state)
                    let _ = DrawEngineHelper.drawViewFromDataSource(updateNode, parent: self.superview)
                    self.removeFromSuperview()
                }
            }
        } else {
            // 判断当前节点是否有自己的处理逻辑
        }
    }
    
    
    /// 替换动态节点下各状态关联的变量值
    /// - Parameters:
    ///   - oldNode: 带有动态属性的节点
    ///   - newState: 变量替换数据源
    private func updateDynamicCurrentPropertyState(oldNode: BaseLayoutElement, newState: [String: Any]) -> BaseLayoutElement {
        let newNode = oldNode
        
        if var dynamicPropertys = oldNode.dynamicProperty, var stateList = dynamicPropertys.stateList,  let node =  stateList[dynamicPropertys.currentState ?? ""] {
            
            let validNodes = node.getVariableNodes()
            for node in validNodes {
                if node.expressionSetters.count > 0 {
                    // 通过可设置变量节点，获取设置属性key 从Data取值刷新
                    for (property, path) in node.expressionSetters {
                        if let value = OYUtils.getValueFromJsonData(data: newState.toData()!, path: path) {
                            // 设置节点属性动态值
                            node.updateNodePropertyValue(propertyName: property, value: value)
                        }
                    }
                }
            }
            stateList[dynamicPropertys.currentState ?? ""] = node
            dynamicPropertys.stateList = stateList
            newNode.dynamicProperty = dynamicPropertys
        }
        
        return newNode
    }
}
