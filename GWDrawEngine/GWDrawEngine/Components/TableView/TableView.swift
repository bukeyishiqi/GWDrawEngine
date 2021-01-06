//
//  TableView.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 1/4/17.
//  Copyright © 2017 Khoren Markosyan. All rights reserved.
//

import UIKit

protocol GWTableViewDelegate: NSObjectProtocol {
    // ContainerView事件回调
    func gwTableViewContainerViewTextFieldEndEdit(textfield: GWTextField)
    // 备注：模板点击，调用当前父类的代理传递到控制器统一管理
    func gwTableViewContainerViewClickedByAction(view: UIView, action: ActionEntry)
    
    // tableView头部刷新代理
    func gwTableViewHeaderRefreshAction(view: UIView)
    // tableView尾部刷新代理
    func gwTableViewFooterRefreshAction(view: UIView)
}


class GWTableView: UITableView {

    weak var gwDelegate: GWTableViewDelegate?
    
    /** 当前节点View关联的数据*/
    var viewData: [[String: Any]]?

    // 模板对应数据源
    lazy var templatesDataSource: [TableViewSection] = [TableViewSection]()
    
    init () {
        super.init(frame: CGRect(), style: .grouped)
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    /***********************/
    
    func makeUI() {
        rowHeight = UITableView.automaticDimension
        estimatedRowHeight = 50
        sectionHeaderHeight = 40
        backgroundColor = UIColor.clear
        cellLayoutMarginsFollowReadableWidth = false
        keyboardDismissMode = .onDrag
        separatorColor = UIColor.clear
        separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
//        tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 1))
//        tableFooterView = UIView()
        self.delegate = self
        self.dataSource = self
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
        self.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")

    }
    
    func setTableViewProperty(node: TableViewNode) {
       if let separatorStyle = node.separatorStyle {
            self.separatorStyle = DrawPropertyUtils.getTableViewSeparatorStyle(desc: separatorStyle)
        }
        if let separatorColor = node.separatorColor {
            self.separatorColor = UIColor.colorFromHexString(hex: separatorColor)
        }
        
        // 设置刷新样式
        if let refreshC = (self.node as? TableViewNode)?.refreshControl, refreshC.needRefresh == true {
            setupRefresh(refreshStyle: refreshC.style, on: self)
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setDelayProperty()
    }
}


 // MARK: 数据源构建
extension GWTableView {

    /// 构建TableView数据源
    /// - Parameters:
    ///   - originData: 接口下发的界面对应的源数据
    func updateTableViewDataSource(originData: Data?) {
        if let staticSections = (self.node as? TableViewNode)?.staticSections {
            self.templatesDataSource.removeAll()
            for tSection in staticSections {
                var list = tSection.list ?? []
                let section = TableViewSection(header: tSection.header ?? "", items: replaceExpressionValue(list: &list, orginData: originData) )
                
                self.templatesDataSource.append(section)
            }
            self.reloadData()
        }
    }

    
    /// 构建TableView动态数据源
    /// - Parameters:
    ///   - tableView: 关联TableView
    ///   - orginData: 后台下发源数据
    func updateDynamicTableViewDataSource(orginData: Data?) {
//                                    "dynamicSections": [
        //
        //                                ["header": "", "list": ["rowItems": "${supergroupService.list}", "rowIdentifier": "${item.type}", "identifierMap": ["${item.type}":"templates_1"]]]
        //                                // rowItems 为接口返回的行数，${item.type}为区别单行的标识，通过identifier中映射需要的模板类型
        //                            ],

    
        if let dynamicSections = (self.node as? TableViewNode)?.dynamicSections  {
            for index in 0..<dynamicSections.count {
                // 取动态section
                let dsection = dynamicSections[index]
                
                let sectionHeader = dsection.header
                let dListInfo = dsection.list
                
                let staticList = dsection.staticList
                
                // 判断是否为静态数组
                if let staticRows = staticList, staticRows.count > 0 {
                    
                    var list = staticRows
                    let section = TableViewSection(header: sectionHeader ?? "", items: replaceExpressionValue(list: &list, orginData: orginData) )
                    
                    self.templatesDataSource.append(section)
                    
                } else {
                    
                    // 判断value是否为表达式
                    if let valueString =  dListInfo?["rowItems"] as? String {
                        // 验证是否为表达式
                        if let path = OYUtils.verifyExpressionSetters(expression: valueString) {
                           
                            // 通过path查找对应的值
                            if let orgD = orginData {
                                
                                let newValueJson = OYUtils.getValueFromJsonData(data: orgD, path: path) as? JSON
                                let newValue = newValueJson?.object
                                let dataValue = newValue as? [[String: Any]]
                                
                                // 判断当前值是否与前值是否相等，相等则不需要加载
                                if let originViewData = self.viewData, let newViewData = dataValue {
                                    if OYUtils.verifyDicEqual(orignDic: originViewData, otherDic: newViewData) {
                                        return
                                    }
                                }
                                self.viewData = dataValue // 保存前值
                                
                                // 替换当前值
                                if let newRowList = newValue as? [[String: Any]],  let indetiferMap = dListInfo?["identifierMap"] as? [String: String]  {
                                    
                                    let newRowList = newRowList.map { (item) -> [String: Any] in
                                        var new = item
                                        
                                        // 给每一行添加关联模板
                                        // 验证identifier类型，如果是字符串，则每一行都统一，h否则根据关联类型获取
                                        var indetiferValue: String = ""

                                        if let indetiferString =  dListInfo?["rowIdentifier"] as? String {
                                            
                                            // 判断是否为表达式
                                            if let path = OYUtils.verifyExpressionSetters(expression: indetiferString) {

                                                // 获取identity关联值
                                                if let rowData = item.toData(), let value =  (OYUtils.getValueFromJsonData(data: rowData, path: path) as? JSON)?.object as? String {
                                                    indetiferValue = value
                                                }
                                                
                                            } else { // 非表达式统一设置
                                                indetiferValue = indetiferString
                                            }
                                        }
                                        new["identifier"] = indetiferMap[indetiferValue]
                                        
    //                                    // 给每一行添加额外属性 "extraArgs":["isSelected": 0]
    //                                    if let extraArgs = dListInfo?["extraArgs"] as? [String: Any] {
    //                                        new = OYUtils.insertMapToMap(insertMap: extraArgs, map: new) ?? new
    //                                    }
                                        
                                        
                                        return new
                                    }
                                    
                                    // 当前分区是否已经存在，存在则把数据拼接在最后
                                    if self.templatesDataSource.count > index {
                                        var oldSection = self.templatesDataSource[index]
                                        oldSection.items = newRowList //oldSection.items + newRowList
                                        self.templatesDataSource[index] = oldSection
                                    } else {
                                        let section = TableViewSection(header: sectionHeader ?? "", items: newRowList)
                                        self.templatesDataSource.append(section)
                                    }
                                    
                                } else if var signRowList = newValue as? [String: Any] {
                                    signRowList["identifier"] = dListInfo?["identifier"] as! String

                                    let section = TableViewSection(header: sectionHeader ?? "", items: [signRowList])
                                    self.templatesDataSource.append(section)

                                }
                            }
                            
                        }
                    }
                    
                }
                

                
            }
            self.reloadData()
        }
    }
}


 // MARK: UITableViewDelegate
extension GWTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0.01
        }
        return CGFloat((self.node as? TableViewNode)?.headerHeight ?? 10)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return  nil
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
}

extension GWTableView: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.templatesDataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sections = templatesDataSource[section]
        return sections.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.delegate = self
        
        let sections = templatesDataSource[indexPath.section]
        let rowObjInfo = sections.items[indexPath.row]

        // 获取对于模板 reflectDataInfo为模板映射关系
        if let templateIdentifier = rowObjInfo["identifier"] as? String, let reflectDataInfo = (self.node as? TableViewNode)?.templatesReflect?[templateIdentifier] as? [String: Any] {

            // 转换源数据为模板格式数据
            let templateData = OYUtils.replaceExpressionValue(originMap: reflectDataInfo, sourceData: rowObjInfo.toData()!).toData()
            
            if let exsitContainerView = cell.viewWithTag(100) as? ContainerView {
                exsitContainerView.update(data: templateData)
                cell.layoutIfNeeded()
            } else {

                if let view = ContainerView.viewContainer(templateType: templateIdentifier, nodeIdentify: "\(indexPath.section)+\(indexPath.row)") {
                    view.tag = 100
                    view.delegate = self
                    
                    view.update(data: templateData)
                    cell.addchildView(view)
                    cell.layoutIfNeeded()
                }
            }
            
            
            // 处理选择状态、或者默认选择
            if let exsitContainerView = cell.viewWithTag(100) as? ContainerView {
                if let seleted = rowObjInfo["isSelected"] as? Int { // 存在选择状态才调用
                    DrawDataEnginHelper.updateSingleNodeState(view: exsitContainerView, isSelected: seleted == 1)
                } else {
                    DrawDataEnginHelper.updateSingleNodeState(view: exsitContainerView, isSelected: false)
                }
            }
            
        }
        
        return cell
    }
}


extension GWTableView {
    
    // "state": ["isSelected":0, "selectedElement": "${memberName}", "connectGlobalSate": "selectedList", "reducer":[
        // contain返回的是bool值，直接替换isSelected关联值
//    ["connectStateKey": "isSelected", "condition": ["operator": "contain", "param": ["selectedlList"]], "returnValue": 1]
//    ]]
    
    /// 更新当前节点的状态数据
    /// - Parameter data: 源数据
    func updateStateData(celldata: Data?, cellState: [String: Any]?) -> [String: Any]? {
        
        if var currentState = cellState, let orgData = celldata {
            currentState = OYUtils.replaceExpressionValue(originMap: currentState, sourceData: orgData)
            
            // 执行节点状态下的reduer
            currentState = handleStateConnectOperator(currentPageState: currentState) ?? [:]
            
            return currentState
        }
        
        return cellState
    }
}


// MARK: ContainerViewDelegate 备注：cell中的子View如果包含对应功能需实现代理
extension GWTableView: ContainerViewDelegate {
    func containerViewHeaderRefreshAction(view: UIView) {
        
    }
    
    func containerViewFooterRefreshAction(view: UIView) {
        
    }
    

    func containerViewTextFieldEndEdit(textfield: GWTextField) {
        self.gwDelegate?.gwTableViewContainerViewTextFieldEndEdit(textfield: textfield)
    }
    
    
    // 备注：模板点击，调用当前父类的代理传递到控制器统一管理
    func containerViewClickedByAction(view: UIView, action: ActionEntry) {
        self.gwDelegate?.gwTableViewContainerViewClickedByAction(view: view, action: action)
    }
    
}


extension GWTableView {
    
    func replaceExpressionValue(list:inout [[String: Any]], orginData: Data?) -> [[String: Any]] {
        guard let orgData = orginData else {
            return list
        }
        for index in 0..<list.count {
            var newRow = list[index]
            newRow = OYUtils.replaceExpressionValue(originMap: newRow, sourceData: orgData)
            list[index] = newRow
        }
        return list
    }
}
