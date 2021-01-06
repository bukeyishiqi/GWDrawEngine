//
//  ContainerErrorReducer.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/19.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


func errorMessageReducer(_ state: String?, action: Action) -> String {
    var state = state ?? ""

    switch action {
    case let action as SaveErrorMessage:
        state = action.errorMessage
    case _ as CleanErrorMessage:
        state = ""
    default:
        break
    }

    return state
}
