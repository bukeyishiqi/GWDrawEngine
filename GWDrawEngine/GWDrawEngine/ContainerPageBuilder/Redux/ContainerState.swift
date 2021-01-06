//
//  ContainerState.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/5.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


// 单页面标识
typealias PageIdentifier = String

// 保存页面状态
typealias PropertyState = [PageIdentifier: [String: Any]]


struct ContainerState: StateType {
    
    var isLoading: Bool = false
    
    // 刷新状态下是否有下一页
    var hasNextPage: Bool = true
    
    var errorMessage:String?
    
    // 服务器返回新的布局节点更新
    var updateNode: BaseLayoutElement?
    
    var propertys: PropertyState?
}
