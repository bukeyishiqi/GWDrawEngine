//
//  ContainerLoadingReducer.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/19.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


func loadingReducer(_ state: Bool?, action: Action) -> Bool {
    var state = state ?? false

    switch action {
    case _ as StartLoading:
        state = true
    case _ as EndLoading:
        state = false
    default:
        break
    }

    return state
}
