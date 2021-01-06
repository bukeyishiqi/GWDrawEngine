//
//  ContainerReducer.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/5.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation

// 状态改变标识
let StateChangeIdentify = "StateChangeIdentify"


func containerReducer(action: Action, state: ContainerState?) -> ContainerState {
   
    return ContainerState(isLoading:  loadingReducer(state?.isLoading, action: action),
                          hasNextPage: refreshReducer(state?.hasNextPage, action: action),
                          errorMessage: errorMessageReducer(state?.errorMessage, action: action), updateNode: updateNodeReducer(state?.updateNode, action: action),
                          propertys: propertyReducer(state?.propertys, action: action))
}



func propertyReducer(_ state: PropertyState?, action: Action) -> PropertyState {
    var newState = state ?? PropertyState()

    switch action {
        
    case let action as LoadPageAction:
        // 注册初始页面状态到全局状态容器
        if var initS = action.pageSate {
            initS[StateChangeIdentify] = OYUtils.getOnlyIdentify()

            newState[action.pageId] = handleStateConnectOperator(currentPageState: initS)
           }
        return newState
    
    case let action as UpdateConnectStateAction:
        if var pageState = newState[action.pageId] {
            pageState[action.connectStateKey] = action.value
            pageState[StateChangeIdentify] = OYUtils.getOnlyIdentify()
            newState[action.pageId] = handleStateConnectOperator(currentPageState: pageState)

        }
        
        return newState
        
    case let action as UpdateMutilConnectStateAction:
        
        if var pageState = newState[action.pageId] {
            for (key, value) in action.mutilState {
                pageState[key] = value
            }
            pageState[StateChangeIdentify] = OYUtils.getOnlyIdentify()
            newState[action.pageId] = pageState
        }
        
        return newState
        
    case let action as HeaderReloadAction:
        if var pageState = newState[action.pageId] {
            pageState["loadPage"] = 1

            // 拼接数组
            if let appendList = action.serviceData?["memberList"]  as? [[String: Any]] {
                pageState["list"] = appendList
            }
             
            pageState[StateChangeIdentify] = OYUtils.getOnlyIdentify()
            newState[action.pageId] = pageState
        }
        return newState
        
    case let action as FooterReloadAction:
        if var pageState = newState[action.pageId] {
            pageState["loadPage"] = action.loadPage

            // 拼接数组
            if var list = pageState["list"] as? [[String: Any]] { // 已经存在的数据
                if let appendList = action.serviceData?["memberList"]  as? [[String: Any]] {
                    list += appendList
                    pageState["list"] = list
                }
            }
             
            pageState[StateChangeIdentify] = OYUtils.getOnlyIdentify()
            newState[action.pageId] = pageState
        }
        return newState
        
     // 处理业务逻辑
    case let action as ActionEntry:
        
        var currentPageState = newState[action.pageIdentify ?? ""]
        let currentView = action.connectView

        switch action.getType() {
            
        case .showPage:
            // 获取页面id
            if let pageId = action.params?["pageId"] as? String {
                if let vc = DisplayHelper.displayPage(pageId: pageId, params: action.params) {
                    Application.shared.navigator.show(target: vc)
                }
            }
            break
        case .showToast:
            let message = action.params?["message"] as? String
            let toastTemplate = action.params?["template"] as? String
            
            if let msg = message, let t = toastTemplate {
                ToastComponentHelper.showToast(template: t, message: msg)
            }
            
            break
        case .pop: // pop中param对应返回层级

            if var actionParams = action.params {
                if let origData = currentPageState?.toData() {
                   actionParams = OYUtils.replaceExpressionValue(originMap: actionParams, sourceData: origData)
                }
                if let popToVc = actionParams["popToVc"] as? String {
                   let _ = Application.shared.navigator.pop(pageId: popToVc, callback: actionParams, animated: true)
                }
            } else {
                let _ = Application.shared.navigator.pop()
            }
             
            break
        case .endViewEdit:
            currentView?.endEditing(true)
            break
        case .clear:
            //["actionType": "clear", "params": ["connectState": ["selectedlList"]]]
            // 获取关联的状态值
            if let connectStates = action.params?["connectState"] as? [String] {
                for clearState in connectStates {
                    if let _ = currentPageState?[clearState] as? [Any] { // 数组类型
                        currentPageState?[clearState] = []
                    } else if let _ = currentPageState?[clearState] as? String { // 字符串类型
                        currentPageState?[clearState] = ""
                    }
                }
                currentPageState?[StateChangeIdentify] = OYUtils.getOnlyIdentify()

                newState[action.pageIdentify ?? ""] = handleStateConnectOperator(currentPageState: currentPageState)
            }
            
            break
        case .arrayRemove:
            //["actionType": "arrayRemove", "params": ["connectState": ["list","selectedlList"], "filterKey":"memberName"]]
            // 获取关联的状态值
            if let connectStates = action.params?["connectState"] as? [String] {
                // 获取第一个值
                let list = currentPageState?[connectStates.first ?? ""] as? [Any]
                // 获取第二个值
                let removeList = currentPageState?[connectStates.last ?? ""] as? [Any]
                
                // 赋值
                currentPageState?[connectStates.first ?? ""] = arrayRemove(orgA: list, rmvA: removeList, key: action.params?["filterKey"] as? String ?? "")
                
                currentPageState?[StateChangeIdentify] = OYUtils.getOnlyIdentify()

                newState[action.pageIdentify ?? ""] = handleStateConnectOperator(currentPageState: currentPageState)
            }
            
            break
        case .objRemove:
            //["actionType": "objRemove", "params": ["connectState": ["list"], "rmvObj":"memberName","filterKey":"memberName"]]
            if let connectStates = action.params?["connectState"] as? [String] {
                // 获取第一个值
                let list = currentPageState?[connectStates.first ?? ""] as? [Any]
                
                let rmvObj = action.params?["rmvObj"] as Any
                let filter = action.params?["filterKey"] as! String
                // 赋值
                currentPageState?[connectStates.first ?? ""] = objRemove(orgA: list, rmvObj: rmvObj, key: filter)
                
                currentPageState?[StateChangeIdentify] = OYUtils.getOnlyIdentify()

                newState[action.pageIdentify ?? ""] = handleStateConnectOperator(currentPageState: currentPageState)
            }

            
            break
        case .selected:
            
            if let connectStates = action.params?["connectState"] as? [String] {
                
                let orginDataSourceKey = connectStates.first ?? "" // 数据源key
                
                let addSelectStateKey = connectStates.last ?? "" // 被添加元素的状态数组key

                // 获取数据源List下的index索引
//                let sectionIndex = (currentView?.node?.property?.id?.components(separatedBy: "+").first as NSString?)?.integerValue ?? 0
                let rowIndex = (currentView?.node?.id?.components(separatedBy: "+").last as NSString?)?.integerValue ?? 0
                
                var list = (currentPageState?[orginDataSourceKey] as? [[String: Any]])
                var rowObjInfo = list?[rowIndex]
                
                
                var addSelectList = currentPageState?[addSelectStateKey] as? [Any]
                let element = action.params?["selectedElement"]
                
                if var intAddSelectList = addSelectList as? [Int], let intElement = element as? Int {
                    // 验证数组是否已经存在当前元素
                      if intAddSelectList.contains(intElement) { // 已经包含则移除
                          intAddSelectList.removeAll {
                              $0 == intElement
                          }
                          rowObjInfo?["isSelected"] = 0

                      } else {
                          intAddSelectList.append(intElement)
                          rowObjInfo?["isSelected"] = 1
                      }
                    addSelectList = intAddSelectList
                }
                
                if var stringAddSelectList = addSelectList as? [String], let stringElement = element as? String {
                    // 验证数组是否已经存在当前元素
                      if stringAddSelectList.contains(stringElement) { // 已经包含则移除
                          stringAddSelectList.removeAll {
                              $0 == stringElement
                          }
                          rowObjInfo?["isSelected"] = 0

                      } else {
                          stringAddSelectList.append(stringElement)
                          rowObjInfo?["isSelected"] = 1
                      }
                    addSelectList = stringAddSelectList
                }
                
                
                if let rowInfo = rowObjInfo {
                    list?[rowIndex] = rowInfo
                }
                currentPageState?[orginDataSourceKey] = list
                currentPageState?[addSelectStateKey] = addSelectList
                currentPageState?[StateChangeIdentify] = OYUtils.getOnlyIdentify()
                
                newState[action.pageIdentify ?? ""] =  handleStateConnectOperator(currentPageState: currentPageState)
            }
            
            break
            
        case .signSelected:
            //  "actionType": "signSelected","actionParam": ["selectedElement": "${invitationType}", "connectState": ["section0_list", "invitationType"]]
//            if let connectStates = action.params?["connectState"] as? [String] {
//
//                let orginDataSourceKey = connectStates.first ?? "" // 数据源key
//
//                let stateKey = connectStates.last ?? "" // 被添加元素的状态key
//
//                // 获取数据源List下的index索引
////                let sectionIndex = (currentView?.node?.property?.id?.components(separatedBy: "+").first as NSString?)?.integerValue ?? 0
//                let rowIndex = (currentView?.node?.id?.components(separatedBy: "+").last as NSString?)?.integerValue ?? 0
//
//                var list = (currentPageState?[orginDataSourceKey] as? [[String: Any]])
//                var rowObjInfo = list?[rowIndex]
//
//
//                var stateVlaue = currentPageState?[stateKey] as? [Any]
//                let element = action.params?["selectedElement"]
//
//
//
//
//                if let rowInfo = rowObjInfo {
//                    list?[rowIndex] = rowInfo
//                }
//                currentPageState?[orginDataSourceKey] = list
//                currentPageState?[addSelectStateKey] = addSelectList
//                currentPageState?[StateChangeIdentify] = OYUtils.getOnlyIdentify()
//
//                newState[action.pageIdentify ?? ""] =  handleStateConnectOperator(currentPageState: currentPageState)
//            }
            
            break
        case .commit:
//            ["actionType": "commit", "params": ["method": "POST", "service": "", "url": "", "param": ["updataType": 1, "nickname": "${editName}"]]]
            if let actionParams = action.params {
                
                var param = actionParams["param"] as? [String: Any]
                if param != nil, let origData = currentPageState?.toData() {
                    param = OYUtils.replaceExpressionValue(originMap: param!, sourceData: origData)
                }
                
                
                if let method = actionParams["method"] as? String,
                   let service = actionParams["service"] as? String,
                   let url = actionParams["url"] as? String {
                    
                    let actionCreater = ContainerActionCreater()
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 100)) {
                        containerStore.dispatch(actionCreater.commit(method: method, service: service, url: url, param: param, action: action))
                    }
                }
            }
            break
            
          // MARK: 弹窗处理
        case .showPopView:
            // 获取弹框类型
            if let popType = action.params?["popType"] as? String {
                switch DisplayPopType.init(rawValue: popType) {
                case .pickerSelect:
                    let title = action.params?["title"] as? String ?? "提示"
                    
                    let height = action.params?["height"] as? Int ?? 200
                    if let source = action.params?["dataSource"] {
                        
                        DisplayHelper.showPickerViewComponent(title: title, height: height, dataSource: source) { (value) in
                            // connectState为关联刷新的状态值
                            if let connectState = action.params?["connectState"] as? String, var stateValue = currentPageState?[connectState] as? [String: Any] {
                                
                                // 从replaceDataSource获取状态值替换stateValue
                                if let replaceSource = stateValue["replaceSource"] as? [String: Any], let key = value as? String {
                                    stateValue["stateKey"] = key
                                    stateValue["stateValue"] = replaceSource[key]
                                } else {
                                    stateValue["stateValue"] = value
                                }
                                
                                containerStore.dispatch(UpdateConnectStateAction(pageId: action.pageIdentify ?? "", connectStateKey: connectState, value: stateValue))

                            }
                        }
                    }
                    break
                case .alter:
                    let title = action.params?["title"] as? String ?? "提示"
                    let description =  action.params?["description"] as? String ?? ""
                    let cancelTitle = action.params?["cancelTitle"] as? String ?? "取消"
                    let confirmTitle = action.params?["confirmTitle"] as? String ?? "确定"

                    var confrimAction: ActionEntry? // 对应的确认事件
                    if let confirmActionInfo = action.params?["confirmAction"] as? [String: Any] {
                        confrimAction = ActionEntry.init(actionInfo: confirmActionInfo)
                        confrimAction?.pageIdentify = action.pageIdentify
                    }
                    DisplayHelper.showSystemAlterComponent(title: title, description: description, cancelTitle: cancelTitle, confirmTitle: confirmTitle, cancel: nil) {
                        if let a = confrimAction {
                            containerStore.dispatch(a)
                        }
                    }
                    
                    break
                
                case .popTemplate:
                    // 获取模板类型
                    if let t = action.params?["template"] as? String {
                        // 获取模板需要数据
                        DisplayHelper.showTemplateView(tempalteType: t, updateData: nil)
                    }
                    
                    break
                default:
                    break
                }
            }
            
            break
            
        case .updateState:
            // ["actionType": "updateState", "params": ["connectState": "receiveType", "value": "2"]]
            // 获取关联的状态值
            if let connectStates = action.params?["connectState"] as? String, let newStateValue = action.params?["value"] {
                
                // 替换新值
                currentPageState?[connectStates] = newStateValue
                
                currentPageState?[StateChangeIdentify] = OYUtils.getOnlyIdentify()

                newState[action.pageIdentify ?? ""] = handleStateConnectOperator(currentPageState: currentPageState)
                
                // 测试
                if let subActions = action.subActions, subActions.count > 0 {

                    for var subAction in subActions {
                        subAction.pageIdentify = action.pageIdentify
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 100)) {
                           containerStore.dispatch(subAction)
                       }
                    }
                }
                /************/
            }
            
            break
        default:
            break
        }
        
        
        
        return newState
        
    default:
        break
    }

    return newState
}
