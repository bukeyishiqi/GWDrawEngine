//
//  ContainerAction.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/5.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation

 // MARK: Loading处理
struct StartLoading: Action {}
struct EndLoading: Action {}
/************************************/


 // MARK: 错误处理
struct SaveErrorMessage: Action {
    let errorMessage:String
}
struct CleanErrorMessage: Action {}
/************************************/


 // MARK: 上拉、下拉刷新
struct RefreshLoading: Action {
    var hasNextPage: Bool = true
}


/// 初始加载页面使用
struct LoadPageAction: Action {
    var pageId: PageIdentifier
    var pageSate: [String: Any]?
}

struct UpdatePageNode: Action {
    var newNode: BaseLayoutElement?
}

/// 更新状态容器关联值
struct UpdateConnectStateAction: Action {
    var pageId: PageIdentifier
    
    var connectStateKey: String
    var value: Any
}

/// 更新容器多个关联值
struct UpdateMutilConnectStateAction: Action {
    var pageId: PageIdentifier
    var mutilState: [String: Any]
}



/// 头部下拉刷新
struct HeaderReloadAction: Action {
    var pageId: PageIdentifier
    var serviceData: [String: Any]?
}

/// 底部上拉刷新
struct FooterReloadAction: Action {
    var pageId: PageIdentifier
    var loadPage:Int
    var serviceData: [String: Any]?
}
