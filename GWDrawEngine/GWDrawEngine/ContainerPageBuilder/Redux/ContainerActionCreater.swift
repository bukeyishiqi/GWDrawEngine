//
//  ContainerActionCreater.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/20.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


struct ContainerActionCreater {
    typealias ActionCreator = (_ state: ContainerState, _ store: Store<ContainerState>) -> Action?
    typealias AsyncActionCreator = (_ state: ContainerState, _ store: Store<ContainerState>,  _ callback:  @escaping (_ actionCreator: ActionCreator) -> Void ) -> Void

    
    
    /// 获取当前页面布局信息及数据
    /// - Parameters:
    ///   - pageId: 页面id
    ///   - params: 请求参数
    /// - Returns: ActionCreator
    func initLoad(pageId: String, initState: [String: Any]?, params: [String: Any]?) -> ActionCreator {
        
        //1、通过当前页面ID获取当前页面版本信息
        var oldResponse: RequestResponse?
        if let pageInfo = DBHelperDAO.queryPageSource(withPageId: pageId) as? [String: Any] {
            oldResponse = RequestResponse.init(info: pageInfo)
        }
        
        // FIXME: 由于系统转换的Json字符串网络库不可以识别，需使用mjextension作中转
//        var paramsString: String? = nil
//        if let p = params {
//            let i = NSDictionary.init(dictionary: p)
//            paramsString = i.mj_JSONString()
//        }
        /********************/
        
        var p = params
        if let updateP = params {
            for (key, value) in updateP {
                if let dicValue = value as? [String: Any] {
                    let i = NSDictionary.init(dictionary: dicValue)
                    p?[key] = i.mj_JSONString()
                }
            }
        }
        
        
        return { state, store in
            
            FCNetWorkService.share.request(API.getPageData(inFirstPage: 0, page: pageId, version: oldResponse?.version ?? 0, param: p), { (response) in
                
                store.dispatch(EndLoading())

                if let responseInfo = response.responseDataObject as? [String: Any] {
                    // 生成接口返回对象
                    var reponse = RequestResponse.init(info: responseInfo)
                    print("*****resopnseJson:\(reponse.updateData?.toJsonString() ?? "")")
                    // 对比版本号
                    if let oldV = oldResponse?.version, oldV == reponse.version {
                        if reponse.layoutElement != nil { // 版本号相同不需要更新布局文件
                            reponse.layoutElement = nil
                        }
                    } else { // 版本不同更新布局文件
                        PageFileManager.savePageInfo(pageId: pageId, info: responseInfo)
                    }
                    
                    // 更新布局数据存在
                    store.dispatch(UpdatePageNode(newNode: reponse.layoutElement))
                    
                    // 分发新数据
                    store.dispatch(LoadPageAction(pageId: pageId, pageSate: self.udpateCurrentSate(currentPageState: initState, serviceData: reponse.updateData?.toData())))
                } else {
                    // 老数据分发
                    store.dispatch(LoadPageAction(pageId: pageId, pageSate:  self.udpateCurrentSate(currentPageState: initState, serviceData: oldResponse?.updateData?.toData())))
                }
                
                
            }) { (error) in
                store.dispatch(EndLoading())
                store.dispatch(SaveErrorMessage(errorMessage: ""))
                
                // 老数据分发
                store.dispatch(LoadPageAction(pageId: pageId, pageSate:  self.udpateCurrentSate(currentPageState: initState, serviceData: oldResponse?.updateData?.toData())))

            }
            
            return StartLoading()
        }
    }
    
    
    func headerLoad(pageId: String, params: [String: Any]?) -> ActionCreator {
        //1、通过当前页面ID获取当前页面版本信息
        var oldResponse: RequestResponse?
        if let pageInfo = DBHelperDAO.queryPageSource(withPageId: pageId) as? [String: Any] {
            oldResponse = RequestResponse.init(info: pageInfo)
        }
        
        return { state, store in
            
            FCNetWorkService.share.request(API.getPageData(inFirstPage: 0, page: pageId, version: oldResponse?.version ?? 0, param: params), { (response) in
                
                store.dispatch(EndLoading())

                if let responseInfo = response.responseDataObject as? [String: Any] {
                    
                    // 生成接口返回对象
                    let reponse = RequestResponse.init(info: responseInfo)
                    
                    // 结束底部刷新动画
                    store.dispatch(RefreshLoading(hasNextPage: true))
                    
                    // 分发新数据
                    store.dispatch(HeaderReloadAction(pageId: pageId, serviceData: reponse.updateData))
                }
                
            }) { (error) in
                store.dispatch(EndLoading())
                store.dispatch(SaveErrorMessage(errorMessage: ""))
            }
            
            return StartLoading()
        }
    }
    
    
    /// 底部上拉刷新
    /// - Parameters:
    ///   - pageId: 页面Id
    ///   - params: 请求参数
    /// - Returns: ActionCreator
    func footerLoad(pageId: String, params: [String: Any]?) -> ActionCreator {
        
        //1、通过当前页面ID获取当前页面版本信息
        var oldResponse: RequestResponse?
        if let pageInfo = DBHelperDAO.queryPageSource(withPageId: pageId) as? [String: Any] {
            oldResponse = RequestResponse.init(info: pageInfo)
        }
        
        return { state, store in
            
            FCNetWorkService.share.request(API.getPageData(inFirstPage: 0, page: pageId, version: oldResponse?.version ?? 0, param: params), { (response) in
                
                store.dispatch(EndLoading())

                if let responseInfo = response.responseDataObject as? [String: Any] {
                    
                    // 生成接口返回对象
                    let reponse = RequestResponse.init(info: responseInfo)
                    
                    // 结束底部刷新动画
                    store.dispatch(RefreshLoading(hasNextPage: true))
                    
                    // 分发新数据
                    store.dispatch(FooterReloadAction(pageId: pageId, loadPage: (params?["page"] as? Int ?? 1), serviceData: reponse.updateData))
                }
                
            }) { (error) in
                store.dispatch(EndLoading())
                store.dispatch(SaveErrorMessage(errorMessage: ""))
            }
            
            return StartLoading()
        }
    }
    
    
    /// 转发接口
    /// - Parameters:
    ///   - method: 请求方式
    ///   - service: 服务
    ///   - url: 请求url
    ///   - param: 请求参数
    ///   - action: 请求成功后执行的方法
    /// - Returns: ActionCreator
    func commit(method: String, service: String, url: String, param: [String: Any]?, action: ActionEntry) -> ActionCreator {
        
        // FIXME: 由于系统转换的Json字符串网络库不可以识别，需使用mjextension作中转
        var paramsString: String? = nil
        if let p = param {
            let i = NSDictionary.init(dictionary: p)
            paramsString = i.mj_JSONString()
        }
        /********************/
        
        return { state, store in

            FCNetWorkService.share.request(API.commitBusiness(method: method, service: service, url: url, param: paramsString), { (response) in
                store.dispatch(EndLoading())

                if response.success {
                    if let subActions = action.subActions, subActions.count > 0 {

                        for var subAction in subActions {
                            subAction.pageIdentify = action.pageIdentify
                            store.dispatch(subAction)
                        }
                    }
                } else {
                    store.dispatch(SaveErrorMessage(errorMessage: response.responseMessage))
               }
            }) { (error) in
                store.dispatch(EndLoading())
                store.dispatch(SaveErrorMessage(errorMessage: ""))

            }

            return StartLoading()
        }
    }
}


extension ContainerActionCreater {
    func udpateCurrentSate(currentPageState: [String: Any]?, serviceData: Data?) -> [String: Any]? {
        guard let serviceData = serviceData  else {
            return currentPageState
        }
        var newState = currentPageState
        if var newSateInfo = currentPageState {
            newSateInfo = OYUtils.replaceExpressionValue(originMap: newSateInfo, sourceData: serviceData)
            newSateInfo = OYUtils.relaceStateExpressionValue(originMap: newSateInfo, sourceData: serviceData)
            newState = newSateInfo
        }
        return newState
    }
}
