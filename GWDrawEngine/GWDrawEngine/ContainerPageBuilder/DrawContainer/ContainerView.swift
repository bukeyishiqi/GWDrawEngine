//
//  ContainerView.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/26.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit


/** 添加事件通知*/
let GlobalAddEventNotifyKey = "GlobalAddEventNotifyKey"
/** 添加代理通知*/
let GlobalAddDelegateNotifyKey = "GlobalAddDelegateNotifyKey"
/** 添加圆角通知*/
let GlobalAddRadiusLoctionNotifyKey = "GlobalAddRadiusLoctionNotifyKey"
/** 渐变背景通知*/
let GloablGradientcolorsNotifyKey = "GloablGradientcolorsNotifyKey"


protocol ContainerViewDelegate: NSObjectProtocol {
    func containerViewClickedByAction(view: UIView, action: ActionEntry)
    // Textfield结束编辑
    func containerViewTextFieldEndEdit(textfield: GWTextField)
    
    /** 刷新*/
    func containerViewHeaderRefreshAction(view: UIView)
    func containerViewFooterRefreshAction(view: UIView)
    /***********************/
}

class ContainerView: View {

    deinit {
//        print("******当前节点View被销毁：\(self)*****")
    }
    
    weak var delegate: ContainerViewDelegate?
    
    /****************** 包含代理的组件（tableView, collectionView, pickerView）********************/
    var tableView: GWTableView?
    var pickerView: GWPickerView?
    var collectionView: GWCollectionView?
    var pageView: GWPageView?
    
    /******************* Others*************************/
    // 保存需要添加圆角的View对象
    lazy var radiusLoctionViewList: [UIView] = [UIView]()
    // 渐变背景对象
    lazy var gradientcolorList: [UIView] = [UIView]()
    /********************************************/

    var rootNode: BaseLayoutElement
    
    var state: [String: Any]? // 当前节点状态
    
    /// 需要设置变量的节点
    var variableNodes: [BaseLayoutElement]?
    var dynamicVariableNodes: [BaseLayoutElement]?
    
    var lastData: Data?
    
    
    /******************* init *************************/

    // 通过模板初始化容器view, 可设置对应的节点ID
    class func viewContainer(templateType: String, nodeIdentify: String?) -> ContainerView? {
        // 获取模板节点
        guard let node = TemplateManager.shared.createTemplateNodeTreeForType(type: templateType) else {
            print("***创建模板类型：\(templateType) 节点为空！***")
            return nil
        }
        if let identify = nodeIdentify {
            node.id = identify
        }
        return ContainerView.init(rootNode: node)
    }
    
    
    init(rootNode: BaseLayoutElement) {
        self.rootNode = rootNode
        super.init(frame: CGRect())
        self.state = rootNode.state
        
        /**** 监听通知***/
        // 添加事件
        NotificationCenter.default.addObserver(self, selector: #selector(addEventNotify(notify:)), name: NSNotification.Name(rawValue: GlobalAddEventNotifyKey), object: nil)
        // 添加代理
        NotificationCenter.default.addObserver(self, selector: #selector(addDelegateNotify(notify:)), name: NSNotification.Name(rawValue: GlobalAddDelegateNotifyKey), object: nil)
        // 添加多方位圆角
        NotificationCenter.default.addObserver(self, selector: #selector(addRadiusLoctionNotify(notify:)), name: NSNotification.Name(rawValue: GlobalAddRadiusLoctionNotifyKey), object: nil)
        // 渐变
        NotificationCenter.default.addObserver(self, selector: #selector(addGradientcolorsNotify(notify:)), name: NSNotification.Name(rawValue: GloablGradientcolorsNotifyKey), object: nil)
        /**************/

        // 获取变量属性
        self.variableNodes = rootNode.getVariableNodes()
        self.dynamicVariableNodes = rootNode.getDynamicVariableNodes()
        
        // 绘制节点
        let _ = DrawEngineHelper.drawViewFromDataSource(rootNode, parent: self)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /********************************************/

    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
//        for view in radiusLoctionViewList {
//            DrawComponentsUtils.drawRadiusLoction(view: view)
//        }
//        radiusLoctionViewList.removeAll()
        
//        for view in gradientcolorList {
//            // 渐变背景
//            if let gradientcolors = view.node?.backgroudGradientColors {
//                if let type = view.node?.gradientType {
//                    view.setGradientColor(colors: gradientcolors, gradientType: type)
//                }
//            }
//        }
//        gradientcolorList.removeAll()
    }
    
    /// 更新数据及显示布局
    /// - Parameter data: 需要更新的参数
    func update(data: Data?) {
        
        updateData(data: data)
        
        // 更新TableView关联表达数据
        if self.tableView != nil {
            self.tableView?.updateTableViewDataSource(originData: data)
            self.tableView?.updateDynamicTableViewDataSource(orginData: data)
        }
        
        // 更新CollectionView关联变量数据
        if self.collectionView != nil {
            self.collectionView?.updateDynamicCollectionViewDataSource(orginData: data)
        }
        
        if self.pageView != nil {
            self.pageView?.updateDynamicPageViewDataSource(orginData: data)
        }
        
        // 更新布局
        updateLayOut()
    }
    
    
    /// 更新数据
    /// - Parameter data: 需要更新的参数
    func updateData(data: Data?) {
        if let data = data, self.lastData != data {
            self.lastData = data
            
            var newVariableNodes = [BaseLayoutElement]()
            for index in 0..<(variableNodes ?? []).count {
                if let node = variableNodes?[index] {
                    // 通过可设置变量节点，获取设置属性key 从Data取值刷新
                    for (property, path) in node.expressionSetters {
                        if let value = OYUtils.getValueFromJsonData(data: data, path: path) {
                            // 设置节点属性动态值
                            node.updateNodePropertyValue(propertyName: property, value: value)
                        }
                    }
                    newVariableNodes.append(node)
                }
            }
            self.variableNodes = newVariableNodes
            
            for index in 0..<(dynamicVariableNodes ?? []).count {
                
                if let node = dynamicVariableNodes?[index] {
                    if let viewState = (try? JSON.init(data: data))?.dictionaryObject {
                        // 更新动态节点
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: SignNodeStateChangeNotifyKey), object: (node,viewState))
                    }
                }
            }
        }
    }
    
    /// 更新布局
    func updateLayOut() {
        DrawDataEnginHelper.updateContainerView(rootView: self, variableNodes: self.variableNodes ?? [])
    }
}


extension ContainerView {
    @objc func actionHandler(_ tap: UITapGestureRecognizer) {
        if let reponseView = tap.view, let action = reponseView.actionEntry {
            
            print("***** \(reponseView.actionEntry?.actionType ?? "方法名不存在") params: \(String(describing: reponseView.actionEntry?.params))****")
            self.delegate?.containerViewClickedByAction(view: reponseView, action: action)
        }
    }
}


 // MARK: 添加响应事件
extension ContainerView {
    
    @objc func addEventNotify(notify: Notification) {
        if let view = notify.object as? UIView {
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(actionHandler(_:)))
            view.tapGesture = tap
            view.addGestureRecognizer(tap)
        }
    }
    
    @objc func addDelegateNotify(notify: Notification) {
        if let tableV = notify.object as? GWTableView {
            self.tableView = tableV
            self.tableView?.gwDelegate = self

        } else if let textF = notify.object as? GWTextField {
            textF.gwDelegate = self
            
        } else if let pickV = notify.object as? GWPickerView {
            self.pickerView = pickV
            
        } else if let collectionV = notify.object as? GWCollectionView {
            self.collectionView = collectionV
            self.collectionView?.gwDelegate = self

        } else if let pageV = notify.object as? GWPageView {
            self.pageView = pageV
            pageV.gwDelegate = self
        }
    }
    
    // 圆角
    @objc func addRadiusLoctionNotify(notify: Notification) {
        if let view = notify.object as? UIView {
            // 添加到需要绘制圆角的数组， 在界面渲染时候调用绘制圆角
            radiusLoctionViewList.append(view)
        }
    }
    
    // 渐变背景
    @objc func addGradientcolorsNotify(notify: Notification) {
        if let view = notify.object as? UIView {
            // 添加到需要绘制圆角的数组， 在界面渲染时候调用绘制圆角
            gradientcolorList.append(view)
        }
    }
}
