//
//  ContainerRefreshReducer.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/20.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



func refreshReducer(_ state: Bool?, action: Action) -> Bool {
    var state = state ?? true

    switch action {
    case let refresh as RefreshLoading:
        state = refresh.hasNextPage
    default:
        break
    }

    return state
}
