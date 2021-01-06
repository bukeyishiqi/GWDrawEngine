//
//  ContainerUpdateNodeReducer.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/20.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


func updateNodeReducer(_ state: BaseLayoutElement?, action: Action) -> BaseLayoutElement? {
   var state = state 

    switch action {
    case let update as UpdatePageNode:
        state = update.newNode
    default:
        break
    }

    return state
}
