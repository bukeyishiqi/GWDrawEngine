//
//  TableView+Refresh.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/18.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


extension GWTableView: RefreshPresentable {
  
    func loadAction() { // 尾部
        self.gwDelegate?.gwTableViewFooterRefreshAction(view: self)
    }
    
    func reloadAction() { // 头部
        self.gwDelegate?.gwTableViewHeaderRefreshAction(view: self)
    }
}
