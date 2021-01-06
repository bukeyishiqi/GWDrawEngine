//
//  Store.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/5.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


/// 全局状态容器
let containerStore = Store<ContainerState>(
    reducer: containerReducer,
    state: ContainerState(propertys: nil)
)
