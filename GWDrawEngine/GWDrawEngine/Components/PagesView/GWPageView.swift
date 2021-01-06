//
//  GWPageView.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/28.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit



protocol GWPageViewDelegate: NSObjectProtocol {
    // ContainerView事件回调
    func gwPageContainerViewTextFieldEndEdit(textfield: GWTextField)
    // 备注：模板点击，调用当前父类的代理传递到控制器统一管理
    func gwPageContainerViewClickedByAction(view: UIView, action: ActionEntry)
    
    // 滑动选择了莫个Item
    func gwContainerViewWillEndDragging(targetIndex: Int)
    
}



class GWPageView: FSPagerView {

    weak var gwDelegate: GWPageViewDelegate?
    
    lazy var pageDataSource: [[String: Any]] = [[String: Any]]()

    /** 当前节点View关联的数据*/
    var viewData: [[String: Any]]?

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    /***********************/
    
    func makeUI() {
        backgroundColor = UIColor.clear
        self.delegate = self
        self.dataSource = self
        self.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "FSPagerViewCell")
    }
    
    func setPageViewProperty(node: PagesNode) {
        self.interitemSpacing = CGFloat(node.interitemSpacing)  // 页面间距
        self.leadingSpacing = CGFloat(node.leadingSpacing)
        
        self.isInfinite = node.isInfinite // 设置可以无限翻页
        if let interval = node.automaticSlidingInterval {
            self.automaticSlidingInterval =  CGFloat(interval) //自动翻页间隔时间
        }
        // 设置页面类型、效果
        self.transformer = FSPagerViewTransformer(type: FSPagerViewTransformerType.init(rawValue: node.transformer) ?? .linear)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //设置缩放比例
        if let node = self.node as? PagesNode {
            
            let offsetY = 54
            let sacle = (self.bounds.height - CGFloat(offsetY)) / self.bounds.height
            self.transformer?.minimumScale = sacle

            let transform = CGAffineTransform(scaleX: CGFloat(node.scaleX), y: CGFloat(node.scaleY))
            self.itemSize = self.frame.size.applying(transform)
        }

        self.decelerationDistance = FSPagerView.automaticDistance

    }
}


 // MARK: 数据源构建
extension GWPageView {
    
    /// 构建TableView动态数据源
    /// - Parameters:
    ///   - tableView: 关联TableView
    ///   - orginData: 后台下发源数据
    func updateDynamicPageViewDataSource(orginData: Data?) {

        if let dynamicSections = (self.node as? PagesNode)?.dynamicSections  {
            for index in 0..<dynamicSections.count {
                // 取动态section
                let dsection = dynamicSections[index]
                
                let dListInfo = dsection.list
                                
                // 判断value是否为表达式
                if let valueString =  dListInfo?["rowItems"] as? String {
                    // 验证是否为表达式
                    if valueString.hasPrefix("${") && valueString.hasSuffix("}") {
                        let path = (valueString as NSString).substring(with: NSRange.init(location: 2, length: valueString.count - 3))
                        
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
                                        if indetiferString.hasPrefix("${") && valueString.hasSuffix("}") {
                                            let path = (indetiferString as NSString).substring(with: NSRange.init(location: 2, length: indetiferString.count - 3))

                                            // 获取identity关联值
                                            if let rowData = item.toData(), let value =  (OYUtils.getValueFromJsonData(data: rowData, path: path) as? JSON)?.object as? String {
                                                indetiferValue = value
                                            }
                                            
                                        } else { // 非表达式统一设置
                                            indetiferValue = indetiferString
                                        }
                                    }
                                    new["identifier"] = indetiferMap[indetiferValue]
      
                                    return new
                                }
                            
                                self.pageDataSource += newRowList
                                
                            } else if var signRowList = newValue as? [String: Any] {
                                signRowList["identifier"] = dListInfo?["identifier"] as! String
                                self.pageDataSource += [signRowList]
                            }
                        }
                        
                    }
                }
                
            }
            self.reloadData()
        }
    }
}



extension GWPageView: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.pageDataSource.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "FSPagerViewCell", at: index)

        let rowObjInfo = pageDataSource[index]
        
        // 获取对于模板 reflectDataInfo为模板映射关系
        if let templateIdentifier = rowObjInfo["identifier"] as? String, let reflectDataInfo = (self.node as? PagesNode)?.templatesReflect?[templateIdentifier] as? [String: Any] {

            // 转换源数据为模板格式数据
            let templateData = OYUtils.replaceExpressionValue(originMap: reflectDataInfo, sourceData: rowObjInfo.toData()!).toData()
            
            if let exsitContainerView = cell.viewWithTag(100) as? ContainerView {
                
                exsitContainerView.update(data: templateData)
                cell.layoutIfNeeded()
            } else {

                if let view = ContainerView.viewContainer(templateType: templateIdentifier, nodeIdentify: "\(index)") {
                    view.tag = 100
                    view.delegate = self
                    
                    view.update(data: templateData)
                    cell.addchildView(view)
                    cell.layoutIfNeeded()
                }
            }
            
        }
        return cell
    }
    
    // 滑动选择了莫个Item
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
        
        if var scrollAction = (self.node as? PagesNode)?.didScrollAction {
            // 替换param下的value
            scrollAction.params?["value"] = (targetIndex + 1)
            
            self.gwDelegate?.gwPageContainerViewClickedByAction(view: self, action: scrollAction)
        }
    }
}


// MARK: ContainerViewDelegate
extension GWPageView: ContainerViewDelegate {
    func containerViewHeaderRefreshAction(view: UIView) {
        
    }
    
    func containerViewFooterRefreshAction(view: UIView) {
        
    }
    
    func containerViewTextFieldEndEdit(textfield: GWTextField) {
        self.gwDelegate?.gwPageContainerViewTextFieldEndEdit(textfield: textfield)
    }
    
    // 备注：模板点击，调用当前父类的代理传递到控制器统一管理
    func containerViewClickedByAction(view: UIView, action: ActionEntry) {
        self.gwDelegate?.gwPageContainerViewClickedByAction(view: view, action: action)
    }
}
