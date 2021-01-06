//
//  DrawComponentsUtils.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/25.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

enum CommponentType: String {
    case view = "View"
    case stackView = "StackView"
    case text = "Text"
    case imageView = "ImageView"
    case button = "Button"
    case tableView = "TableView"
    case textField = "TextField"
    case pickerView = "PickerView"
    case gwSwitch = "Switch"
    case collectionView = "CollectionView"
    
    case toast = "Toast"
    
    /** 广告页，page循环*/
    case pageView = "PageView"
}



class DrawComponentsUtils: NSObject {

    
    /// 获取View类型
    /// - Parameter typeString: 视图类型描述字符串
    static func getComponentType(_ typeString: String?, element: BaseLayoutElement) -> UIView? {
        guard let typeS = typeString else {
            print("**** 组件类型不能为空！\n ***")
            return nil
        }
        switch CommponentType.init(rawValue: typeS) {
        case .view:
            let view = GWView()
            return view
        case .stackView:
            let view = GWStackView.init()
            return view
        case .text:
            let view = GWLabel()
            return view
        case .button:
            let button = GWButton()
            return button
        case .imageView:
            let imageView = GWImageView()
            return imageView
        case .tableView:
            let style = DrawPropertyUtils.getTableViewStyle(desc: (element as? TableViewNode)?.style ?? "")
            let tableView = GWTableView.init(frame: CGRect(), style: style)
            // 设置代理监听
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalAddDelegateNotifyKey), object: tableView)
            return tableView
        case .textField:
            let textField = GWTextField()
            
            // 设置代理监听
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalAddDelegateNotifyKey), object: textField)

            return textField
        case .pickerView:
            let pickerView = GWPickerView()
            
            // 设置代理监听
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalAddDelegateNotifyKey), object: pickerView)

            return pickerView
        case .gwSwitch:
            let gsSwitch = GWSwitch()
            return gsSwitch
        case .collectionView:
            let customLayout =  UICollectionViewFlowLayout()
            let collectionV = GWCollectionView.init(frame: CGRect(), collectionViewLayout: customLayout)
            // 设置代理监听
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalAddDelegateNotifyKey), object: collectionV)

            return collectionV
        case .pageView:
            let view = GWPageView(frame: CGRect())
            
            // 设置代理监听
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalAddDelegateNotifyKey), object: view)

            return view
        default:
            print("**** 不存在的未知类型 **** \n")
            let view = GWView()
            return view
        }
    }
    
    
    /// 设置组件属性
    /// - Parameters:
    ///   - view: 需要设置的View
    ///   - property: 设置的属性对象
    ///   - parent: 父视图
    static func setComponentPropertys(view: UIView, _ node: BaseLayoutElement, parent: UIView?) {
        
//        if let only_id = property.id {
//            view.only_id = only_id
//        }
        
        if DrawPropertyUtils.getLayoutType(type: node.layoutType ?? "") == .absolute {
            var frame = CGRect.init(x: 0, y: 0, width: 0, height: 0)
            if let width = node.width, width > 0 {
                frame.size.width = CGFloat(width)
            } else {
                frame.size.width = kScreenW
            }
            if let height = node.height, height > 0 {
                frame.size.height = CGFloat(height)
            } else {
                frame.size.height = kScreenH
            }
            view.frame = frame
        } else {
            
            // 判断宽高是否需要填充父视图
            if let width = node.width, width == -1 {
                if parent != nil {
                    view.snp.makeConstraints { (make) in
                       make.width.equalToSuperview().priorityHigh()
                   }
                }
            }
            
            if let height = node.height, height == -1 {
                if parent != nil {
                    view.snp.makeConstraints { (make) in
                        make.height.equalToSuperview().priorityHigh()
                    }
                }
            }
            
            if let width = node.width, width > 0 {
               view.snp.makeConstraints { (make) in
                view.constraint_width = make.width.equalTo(width).priorityRequired().constraint
               }
            }
            
             if let ratioW = node.ratioW ,  let ratio = node.ratio{
                 let width = UIScreen.main.bounds.width * CGFloat(ratioW)
                let height = width / CGFloat(ratio)
                 view.snp.makeConstraints { (make) in
                     make.width.equalTo(width).priorityRequired()
                    make.height.equalTo(height)
                 }
             }
 
            
           if let height = node.height, height > 0 {
               view.snp.makeConstraints { (make) in
                   make.height.equalTo(height).priorityRequired()
               }
           }

            
           if let marign = node.margin, marign.count > 0 {
               view.margin = marign
               if parent != nil {
                view.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().inset(marign[0]).priorityHigh()
                }
                
                if marign.count > 1 {
                     view.snp.makeConstraints { (make) in
                       make.bottom.equalToSuperview().inset(marign[1]).priorityHigh()
                   }
                }
                
                if marign.count > 2 {
                     view.snp.makeConstraints { (make) in
                       make.leading.equalToSuperview().inset(marign[2]).priorityHigh()
                   }
                }
                
                if marign.count > 3 {
                     view.snp.makeConstraints { (make) in
                      make.trailing.equalToSuperview().inset(marign[3]).priorityHigh()
                     }
                }
               }
           }
            
            if let marginL = node.marginLeft {
                if parent != nil {
                    view.snp.makeConstraints { (make) in
                        make.leading.equalToSuperview().inset(marginL)
                    }
                }
            }
            
            
            if let marginR = node.marginRight {
                if parent != nil {
                    view.snp.makeConstraints { (make) in
                        make.trailing.equalToSuperview().inset(marginR)
                    }
                }
            }
            
            if let marginT = node.marginTop {
                if parent != nil {
                    view.snp.makeConstraints { (make) in
                        make.top.equalToSuperview().inset(marginT)
                    }
                }
            }
            
            if let marginB = node.marginBottom {
                if parent != nil {
                    view.snp.makeConstraints { (make) in
                        make.bottom.equalToSuperview().inset(marginB)
                    }
                }
            }
            
            if let centerX = node.centerX {
                if parent != nil {
                    view.snp.makeConstraints { (make) in
                        make.centerX.equalToSuperview().inset(centerX)
                    }
                }
            }
            
            if let centerY = node.centerY {
                if parent != nil {
                    view.snp.makeConstraints { (make) in
                        make.centerY.equalToSuperview().inset(centerY)
                    }
                }
            }

            if let centerParent = node.centerParent, centerParent == 1 {
                if parent != nil {
                   view.snp.makeConstraints { (make) in
                       make.center.equalToSuperview()
                   }
               }
            }
        }
        
        // 事件设置
        view.setViewAction(node: node)
        view.setNormalProperty(node: node)
        setComponentDiffPropertys(view: view, node, parent: parent)
    }
    
    
    
    /// 设置组件差异属性
    /// - Parameters:
    ///   - view: 需要设置的View
    ///   - property: 设置的属性对象
    ///   - parent: 父视图
    static private func setComponentDiffPropertys(view: UIView, _ node: BaseLayoutElement, parent: UIView?) {
            
        switch view {
        case let view as GWStackView:
            view.setStackViewProperty(node: node as! StackViewNode)
            break
        case let tableView as GWTableView:
            tableView.setTableViewProperty(node: node as! TableViewNode)
            break
        case let label as GWLabel:
            label.setLabelProperty(node: node as! TextNode)
            break
        case let textfield as GWTextField:
            textfield.setTextfieldProperty(node: node as! TextFieldNode)
            break
        case let imageView as GWImageView:
            imageView.setImageViewProperty(node: node as! ImageViewNode)
            break
        case let button as GWButton:
            button.setButtonProperty(node: node as! ButtonNode)
            break
        case let gwSwitch as GWSwitch:
            gwSwitch.setSwitchProperty(node: node as! SwitchNode)
            break
        case let collectionView as GWCollectionView:
            collectionView.setCollectionViewProperty(node: node as! CollectionViewNode)
            break
        case let pageView as GWPageView:
            pageView.setPageViewProperty(node: node as! PagesNode)
            break
        default:
            break
        }
    }
}


 // MARK: 事件Action设置


 // MARK: 组件属性设置
extension DrawComponentsUtils {
    // 设置圆角
    class func drawRadiusLoction(view: UIView) {
        if let radiusLoction = view.node?.radiusLoction {
            var list: UIRectCorner = UIRectCorner()
            if radiusLoction.count > 0, radiusLoction[0] > 0 {
                list.insert(.topLeft)
            }
            if radiusLoction.count > 1, radiusLoction[1] > 0 {
                list.insert(.topRight)
            }
            if radiusLoction.count > 2, radiusLoction[2] > 0 {
                list.insert(.bottomLeft)

            }
            if radiusLoction.count > 3, radiusLoction[3] > 0 {
                list.insert(.bottomRight)
            }

            view.roundCorners(list, radius: CGFloat(radiusLoction[0]))
        }
    }
}
