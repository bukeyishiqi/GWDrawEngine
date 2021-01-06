//
//  GWCollectionView.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/11.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit



protocol GWCollectionViewDelegate: NSObjectProtocol {
    // ContainerView事件回调
    func gwCollectionContainerViewTextFieldEndEdit(textfield: GWTextField)

    // 备注：模板点击，调用当前父类的代理传递到控制器统一管理
    func gwCollectionContainerViewClickedByAction(view: UIView, action: ActionEntry)
}


class GWCollectionView: UICollectionView {

    weak var gwDelegate: GWCollectionViewDelegate?

    /** 当前节点View关联的数据*/
    var viewData: [[String: Any]]?

    lazy var collectionDataSource: [CollectionViewSection] = [CollectionViewSection]()

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
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
        self.register(CollectionItemCell.self, forCellWithReuseIdentifier: "CollectionItemCell")
    }

    
    /// 更新数据及布局位置
    func reloadDataAndFrame(dataSource: [CollectionViewSection]) {
        if dataSource.count > 0 {
            if let layout = self.collectionViewLayout as? UICollectionViewFlowLayout {
                let itemSize = layout.itemSize
                let sectionInset = layout.sectionInset
                
                let items = dataSource[0].items.count
                let column = (self.node as? CollectionViewNode)?.column ?? 1
                
                // 行数
                let rows = items / column + (items%column > 0 ? 1 : 0)
                
                // 间距
                // 间距
                var lineSpace: CGFloat = 0
                if rows > 0 {
                    if layout.scrollDirection == .vertical {
                        lineSpace = CGFloat(layout.minimumInteritemSpacing ) * CGFloat(rows - 1)
                    } else {
                        lineSpace = CGFloat(layout.minimumLineSpacing ) * CGFloat(rows - 1)
                    }
                }
                
                let contentHeight = lineSpace + (sectionInset.top + sectionInset.bottom) + CGFloat(rows) * itemSize.height
                
                var frame = self.frame
                frame.size.height = contentHeight
                self.frame = frame
            }
        }
        self.reloadData()
    }
    
    func setCollectionViewProperty(node: CollectionViewNode) {
        // 替换collectionVLayout
        var itemSize: CGSize
        // 判断是否有设置Item大小，没有则自适应
        if let width = node.itemWidth, let height = node.itemHeight {
            itemSize = CGSize.init(width: width, height: height)
        } else {
            
            var offset = 0
            if let sectionInset = node.sectionInset {
                offset += (sectionInset[1] + sectionInset[3])
            }
            // 获取内容总宽度
            var maxWidth: CGFloat = (self.bounds.width > 0 ? self.bounds.width : kScreenW)
            if let ratio = node.ratio, ratio > 0 {
                maxWidth = kScreenW * CGFloat(ratio)
            }
            
            // 间距
            var lineSpace: CGFloat
            if DrawPropertyUtils.getCollectionViewScrollDirection(desc: node.scrollDirection ?? "") == .vertical {
                lineSpace = CGFloat(node.minimumInteritemSpacing ?? 0)
            } else {
               lineSpace = CGFloat(node.minimumLineSpacing ?? 0)
            }
            
            let column = CGFloat(node.column ?? 1)
            let contentWidth = maxWidth - CGFloat(offset) - lineSpace * (column - 1)
            // 计算Item大小 和 collectionView高度
            let itemW = contentWidth / column
            
            let itemH = itemW * CGFloat(node.itemRatio ?? 1)
            
            itemSize = CGSize.init(width: itemW, height: itemH)
        }
        
        let customLayout =  UICollectionViewFlowLayout().then {
            $0.scrollDirection = DrawPropertyUtils.getCollectionViewScrollDirection(desc: node.scrollDirection ?? "")
            $0.minimumLineSpacing = CGFloat(node.minimumLineSpacing ?? 0)
            $0.minimumInteritemSpacing =  CGFloat(node.minimumInteritemSpacing ?? 0)
            $0.itemSize = itemSize //CGSize.init(width: 77, height: 96)
            if let inset = node.sectionInset {
                $0.sectionInset = UIEdgeInsets.init(top: CGFloat(inset[0]), left: CGFloat(inset[1]), bottom: CGFloat(inset[2]), right: CGFloat(inset[3]))
            }
       }
        self.collectionViewLayout = customLayout
        
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.isScrollEnabled = ((node.isScrollEnabled ?? 0) == 1)
     }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setDelayProperty()
    }
}



 // MARK: 设置数据源
extension GWCollectionView {
    /// 构建CollectionView动态数据源
    /// - Parameters:
    ///   - tableView: 关联CollectionView
    ///   - orginData: 后台下发源数据
    func updateDynamicCollectionViewDataSource(orginData: Data?) {
//                                    "dynamicSections": [
        //
        //                                ["header": "", "list": ["rowItems": "${supergroupService.list}", "rowIdentifier": "${item.type}", "identifierMap": ["${item.type}":"templates_1"]]]
        //                                // rowItems 为接口返回的行数，${item.type}为区别单行的标识，通过identifier中映射需要的模板类型
        //                            ],

    
        if let dynamicSections = (self.node as? CollectionViewNode)?.dynamicSections  {
            for index in 0..<dynamicSections.count {
                // 取动态section
                let dsection = dynamicSections[index]
                // 需要拼接在最后的本地数据
                let lastSectionSufix = (self.node as? CollectionViewNode)?.sectionsSuffix?["\(index)"]
                
                let sectionHeader = dsection.header
                let dListInfo = dsection.list
                                
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
                                
                                var newRowList = newRowList.map { (item) -> [String: Any] in
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
                                    return new
                                }
                                // 拼接本地尾数据
                                if let lastAppendData = lastSectionSufix as? [[String: Any]] {
                                    newRowList += lastAppendData.map({ (item) -> [String: Any] in
                                        return OYUtils.replaceExpressionValue(originMap: item, sourceData: orgD)
                                    })
                                }
                                
                                let section = CollectionViewSection(header: sectionHeader ?? "", items: newRowList)
                                self.collectionDataSource.append(section)
                                
                            } else if var signRowList = newValue as? [String: Any] {
                                signRowList["identifier"] = dListInfo?["identifier"] as! String

                                var rows = [signRowList]
                                // 拼接本地尾数据
                                if let lastAppendData = lastSectionSufix as? [[String: Any]] {
                                    rows += lastAppendData
                                }
                                let section = CollectionViewSection(header: sectionHeader ?? "", items: rows)
                                self.collectionDataSource.append(section)
                            }
                        }
                        
                    }
                }
                
            }
            if let layoutType = self.node?.layoutType, DrawPropertyUtils.getLayoutType(type: layoutType) == .absolute {
                self.reloadDataAndFrame(dataSource: self.collectionDataSource)
            } else {
                self.reloadData()
            }
        }
    }
}



extension GWCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section < collectionDataSource.count {
            let sections = collectionDataSource[section]
            return sections.items.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionItemCell", for: indexPath) as! CollectionItemCell
        let sections = collectionDataSource[indexPath.section]
        let rowObjInfo = sections.items[indexPath.row]

        
        // 获取对于模板 reflectDataInfo为模板映射关系
        if let templateIdentifier = rowObjInfo["identifier"] as? String, let reflectDataInfo = (self.node as? CollectionViewNode)?.templatesReflect?[templateIdentifier] as? [String: Any] {

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
            
        }
        return cell
    }
}


// MARK: ContainerViewDelegate
extension GWCollectionView: ContainerViewDelegate {
    func containerViewHeaderRefreshAction(view: UIView) {
        
    }
    
    func containerViewFooterRefreshAction(view: UIView) {
        
    }
    
    func containerViewTextFieldEndEdit(textfield: GWTextField) {
        self.gwDelegate?.gwCollectionContainerViewTextFieldEndEdit(textfield: textfield)
    }
    
    
    // 备注：模板点击，调用当前父类的代理传递到控制器统一管理
    func containerViewClickedByAction(view: UIView, action: ActionEntry) {
        self.gwDelegate?.gwCollectionContainerViewClickedByAction(view: view, action: action)
    }
    
}
