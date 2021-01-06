//
//  BaseLayoutElement.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/24.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

enum LayoutType: Int {
    case linear = 1
    case absolute = 2
}


struct LayoutElementState {
    /** 当前需要显示的状态*/
    var currentState: String?
    /** 关联的容器全局状态确切值，或者是关联的数据值表达式*/
    var connectState: String?
    /** 状态列表 通过currentState 属性值获取*/
    var stateList: [String: BaseLayoutElement]?
    
    
    init(info: [String:Any]?) {
        self.currentState = info?["currentState"] as? String
        self.connectState = info?["connectState"] as? String
        
        if let list = info?["stateList"] as? [String: Any], list.count > 0 {
            self.stateList = [String: BaseLayoutElement]()
            for (key, value) in list {
                if let nodeInfo = value as? [String: Any] {
                    self.stateList?[key] = NodeCreater.createLayoutNode(nodeInfo: nodeInfo)
                }
            }
        }
       
    }
}



/// TableView分区Section
struct TableSection {
    var header: String?
    var list: [[String: Any]]?
    
    init(sectionInfo: [String: Any]?) {
        self.header = sectionInfo?["header"] as? String
        if let list = sectionInfo?["list"] as? [[String: Any]] {
            self.list = list
        }
    }
}

struct TableDynamicSection {
    var header: String?
    var list: [String: Any]?
    var staticList: [[String: Any]]? // 动态分区中包含的静态行列表
    
    init(sectionInfo: [String: Any]?) {
        self.header = sectionInfo?["header"] as? String
        if let list = sectionInfo?["list"] as? [String: Any] {
            self.list = list
        } else if let sList = sectionInfo?["list"] as? [[String: Any]] {
            self.staticList = sList
        }
    }
}


struct RefreshControl {
    var needRefresh: Bool = false
    var style: String
}

class BaseLayoutElement {
    
    /** 容器全局状态*/
    var state: [String: Any]?
    /** 容器是否需要处理回调数据*/
    var needCallBack: Bool = false
    /** View类型*/
    var viewType: String?
    /****************************************************/
    
    /********* node tree & native view*/
    private(set) var superNode: BaseLayoutElement?
    private(set) lazy var subViews = [BaseLayoutElement]()
    lazy var expressionSetters: [String: String] = [String: String]() // 属性关联变量 key 对应属性名， value需要更改的属性
    /*********************************/

    
    /** 动态关联属性值*/
    var dynamicProperty: LayoutElementState?
    
    /** 容器关联的请求列表*/
    var requestMap: [String: Any]?
    
    // 标识属性
    var id: String?
    
    /********************* 布局属性***************************/
    // 布局方式 默认线性布局 绝对布局
    var layoutType: String?

    // 布局通用属性
    var width: Int?
    var height: Int?
    var margin: [Int]?
    var ratioW: Double? // width与屏幕比率
    var ratio: Double? // 宽高比值

    var marginLeft: Int?
    var marginRight: Int?
    var marginTop: Int?
    var marginBottom: Int?
    
    // 相对布局属性
    var centerX: Int? // 相对父视图X坐标居中偏移量
    var centerY: Int? // 相对父视图Y坐标居中偏移量
    var centerParent: Int? // 相对父视图中心点对齐
    /************************************************/

    
    /********************* 通用属性***************************/
    var alpha: Float? // 透明度
    var cornerRadius: Int?
    var radiusLoction:[Int]? // 圆角设置方位 上下左右
    var backgroudColor: String?
    var backgroudGradientColors: [String]? // 渐变颜色
    var gradientType: Int? // 背景颜色渐变方式
    var isSelected: Int?
    var isScrollEnabled: Int?
    /************************************************/
    
    /********************* 弹框属性***************************/
    var popupCustomAlignment: Int?
    var popupAnimationType: Int?
    var edgeInsets: [Int]?
    var maskViewColor: String?
    /************************************************/


    /********************* 关联属性***************************/
    var action: ActionEntry? // 事件
    /************************************************/
        
    
    init(nodeInfo: [String: Any]?) {
        // 获取View类型
        self.viewType = nodeInfo?["viewType"] as? String
        
        self.state = nodeInfo?["state"] as? [String: Any]
        self.needCallBack = ((nodeInfo?["needCallBack"] as? Int) == 1)
        
        // 获取属性
        self.buildProperty(propertyInfo: nodeInfo?["property"] as? [String: Any])
//        self.property = Property.init(propertyInfo: nodeInfo?["property"] as? [String: Any])
        
        // 动态关联属性
        if let dynamicP = nodeInfo?["dynamicProperty"] as? [String: Any] {
            self.dynamicProperty = LayoutElementState.init(info: dynamicP)
        }
        
        // 子节点
        if let suNodeInfoList = nodeInfo?["subViews"] as? [[String: Any]] {
            for subNodeInfo in suNodeInfoList {
                if let subNode = NodeCreater.createLayoutNode(nodeInfo: subNodeInfo) {
                    self.addSubNode(node: subNode)
                }
            }
        }
        
        /*********** 设置请求列表*************/
        if let requests = nodeInfo?["requests"] as? [String: Any] {
            self.requestMap = requests
        }
    }

    /// 给当前节点添加子节点
    /// - Parameter node: 被添加的子节点
    func addSubNode(node: BaseLayoutElement) {
        subViews.append(node)
        node.superNode = self
    }
    
    /// 验证属性是否为表达式
    /// - Parameters:
    ///   - key: 属性key
    ///   - value: 属性关联值
    func verifyExpressionSetters(key:String, value: Any?) -> Any? {
        // 验证是否为字符串类型
        if let valueString = value as? String {
            // 验证是否为表达式
            if valueString.hasPrefix("${") && valueString.hasSuffix("}") {
                let path = (valueString as NSString).substring(with: NSRange.init(location: 2, length: valueString.count - 3))
                self.expressionSetters[key] = path // 获取变量
                
                return nil
            }
        }
        return value
    }
    
    // 初始通用属性
    func buildProperty(propertyInfo: [String: Any]?) {
        // 标识属性
        self.id =  OYUtils.getUUIDIdentify()

            // 布局方式 默认线性布局 绝对布局
        self.layoutType = propertyInfo?["layoutType"] as? String

        
        // 布局通用属性
        self.width = propertyInfo?["width"] as? Int
        self.height = propertyInfo?["height"] as? Int
        self.margin = propertyInfo?["margin"] as? [Int]
        
        self.marginLeft = propertyInfo?["marginLeft"] as? Int
        self.marginRight = propertyInfo?["marginRight"] as? Int
        self.marginTop = propertyInfo?["marginTop"] as? Int
        self.marginBottom = propertyInfo?["marginBottom"] as? Int
        
        
        // 相对布局属性
        self.centerX = propertyInfo?["centerX"] as? Int // 相对父视图X坐标居中偏移量
        self.centerY = propertyInfo?["centerY"] as? Int // 相对父视图Y坐标居中偏移量
        self.centerParent = propertyInfo?["centerParent"] as? Int // 相对父视图中心点对齐
        
        
        self.ratioW = propertyInfo?["ratioW"] as? Double // width与屏幕比率
        self.ratio = propertyInfo?["ratio"] as? Double // 宽高比值
        
        // 样式通用属性

        self.backgroudColor = propertyInfo?["backgroudColor"] as? String
        self.backgroudGradientColors = propertyInfo?["gradientColors"] as? [String]
        self.gradientType = propertyInfo?["gradientType"] as? Int
        self.cornerRadius = propertyInfo?["cornerRadius"] as? Int
        self.radiusLoction = propertyInfo?["radiusLoction"] as? [Int] // 圆角设置方位 上下左右
        self.alpha = propertyInfo?["alpha"] as? Float // 透明度
        
        /****** 弹框属性******/
        self.popupCustomAlignment = propertyInfo?["popupCustomAlignment"] as? Int
        self.popupAnimationType = propertyInfo?["popupAnimationType"] as? Int
        self.edgeInsets = propertyInfo?["edgeInsets"] as? [Int]
        self.maskViewColor = propertyInfo?["maskViewColor"] as? String
        /*******************/
        
        /** 事件*/
        if let actionInfo = propertyInfo?["action"] as? [String: Any] {
            self.action = ActionEntry.init(actionInfo: actionInfo)
        }
        
        self.isSelected = propertyInfo?["isSelected"] as? Int
        self.isScrollEnabled = propertyInfo?["isScrollEnabled"] as? Int
    }

    /// 修改属性值
    /// - Parameters:
    ///   - propertyName: 需要更改的属性
    ///   - value: 需要更改的值
    func updateNodePropertyValue(propertyName: String, value: Any) {
        
        if propertyName == "height", let height = (value as? JSON)?.int {
            self.height = height
        }
        
        if propertyName == "width", let width = (value as? JSON)?.int {
            self.width = width
        }
        
        if propertyName == "action", let params = ((value as? JSON)?.dictionaryObject as? [String: String]) {
            
            self.action?.params = params
        }
        
        if propertyName == "radiusLoction", let radiusLoction = (value as? JSON)?.arrayObject as? [Int] {
            self.radiusLoction = radiusLoction
        }
        
        if propertyName == "centerX", let centerX = (value as? JSON)?.int {
            self.centerX = centerX
        }
        
        if propertyName == "centerY", let centerY = (value as? JSON)?.int {
            self.centerY = centerY
        }
        
        if propertyName == "centerParent", let centerParent = (value as? JSON)?.int {
            self.centerParent = centerParent
        }
    }
    
    
    /// 更新动态节点关联的属性
    /// - Parameter value: 替换值
    func updateDynamicNodeConnectStateValue(value: Any) {
        if let state = (value as? JSON)?.stringValue {
            self.dynamicProperty?.connectState = state
        }
    }
}


 // MARK:获取节点及下子节点变量表达式
extension BaseLayoutElement {
    func getVariableNodes() -> [BaseLayoutElement] {
        var result = [BaseLayoutElement]()
        getVariableNodes(node: self, reuslt: &result)
        
        return result
        
    }
    
    private func getVariableNodes(node: BaseLayoutElement, reuslt: inout [BaseLayoutElement]) {
        let newNode = node
        
        if newNode.expressionSetters.count > 0 {
            reuslt.append(node)
        }
        
        for suNode in node.subViews {
            getVariableNodes(node: suNode, reuslt: &reuslt)
        }
    }
    
    
    
     // MARK:查找动态节点的变量
    func getDynamicVariableNodes() -> [BaseLayoutElement] {
        var dycResult = [BaseLayoutElement]()
        getDynamicVariableNodes(node: self, result: &dycResult)
        
        return dycResult
    }
    
    private func getDynamicVariableNodes(node: BaseLayoutElement, result: inout [BaseLayoutElement]) {
        let newNode = node
        
        if let _ = newNode.dynamicProperty {
            result.append(node)
        }
        
        for suNode in node.subViews {
            getDynamicVariableNodes(node: suNode, result: &result)
        }
    }
}
