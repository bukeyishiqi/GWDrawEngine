//
//  TableView+Swipe.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/24.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


 // MARK: 构造侧滑Action列表
extension GWTableView {
    func buildSwipeActionList(rowObjInfo: [String: Any]?) -> [SwipeAction]? {
        if let swipeList = (self.node as? TableViewNode)?.swipeActions {
            var actions = [SwipeAction]()
            for swipeItem in swipeList {
                let action = SwipeAction(style: .default, title: swipeItem.title) {[weak self] action, indexPath in
                    guard let self = self else { return }
                    if var a = swipeItem.actionEntry {
                        // 替换方法参数
                        if let param = a.params, let orgData = rowObjInfo?.toData() {
                            a.params = OYUtils.replaceExpressionValue(originMap: param, sourceData: orgData)
                        }
                        self.gwDelegate?.gwTableViewContainerViewClickedByAction(view: self, action: a)
                    }
                }
                action.backgroundColor = swipeItem.backgroudColor
                action.image = UIImage.init(named: swipeItem.image ?? "")
                actions.append(action)
            }
            
            return actions
        }
        return nil
    }
}


extension GWTableView: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
 
        let sections = templatesDataSource[indexPath.section]
        let rowObjInfo = sections.items[indexPath.row]

        return buildSwipeActionList(rowObjInfo: rowObjInfo)
    }
    
    
    func tableView(_ tableView: UITableView, editActionsOptionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
           
           var options = SwipeOptions()
           options.expansionStyle = .none
           options.transitionStyle = .border
           return options
       }
       
       func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) {

       }
       
       func tableView(_ tableView: UITableView, didEndEditingRowAt indexPath: IndexPath?, for orientation: SwipeActionsOrientation) {
           
       }

    
}
