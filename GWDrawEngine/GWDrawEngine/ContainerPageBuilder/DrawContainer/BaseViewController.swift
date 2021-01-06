//
//  BaseViewController.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/25.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

/** 关联的全局状态切换通知*/
let GlobalStateChangeNotifyKey = "GlobalStateChangeNotifyKey"
/** 单节点状态变更通知*/
let SignNodeStateChangeNotifyKey = "SignNodeStateChangeNotifyKey"


class BaseViewController: UIViewController, StoreSubscriber {
    typealias StoreSubscriberStateType = ContainerState

    deinit {
       print("**当前控制器：\(self) 已销毁**")
    }
    
    init(withPageId pageId: String) {
           super.init(nibName: nil, bundle: nil)
           self.pageId = pageId
       }
      
    required init?(coder aDecoder: NSCoder) {
       fatalError("init(coder:) has not been implemented")
   }
    
    /***********************/
    
    lazy var contentView: GWView = {
        let view = GWView()
        self.view.addSubview(view)
        view.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.edges.equalTo(self.view.safeAreaLayoutGuide)
            } else {
                make.leading.trailing.equalToSuperview()
                make.top.equalToSuperview() //.inset(OYUtils.NaviBarAndStatusBarHeight())
                make.bottom.equalToSuperview().inset(OYUtils.HomeIndicatorHeitht())
            }
        }
        return view
    }()
    
    // 当前显示的界面ID
    var pageId: String!
    var rootNode: BaseLayoutElement?
    var containerView: ContainerView?
    
    // 当前页面状态存储
    var currentPageState: [String: Any]?
    
    /************ Action Handler ***********/
    /** 外界传参*/
    var params: [String: Any]?
    /***************************************/
    
    
    /************ Request Params ***********/
    /** 是否第一次加载接口 0 1 */
    var inFirstPage: Int = 1
    
    /***************************************/
    
    let activityInd =  UIActivityIndicatorView(style:.white)

    
    /// 配置列表显示的页面
    /// - Parameters:
    ///   - pageId: 页面id
    ///   - param: 页面加载相关参数
    func setRootNode(rootNode: BaseLayoutElement, param: [String: Any]?) {
        self.rootNode = rootNode
        self.currentPageState = rootNode.state
        self.params = param
        
        // 把界面传参的params放入状态容器供当前界面关联数据
        if let p = self.params {
            self.currentPageState = OYUtils.insertMapToMap(insertMap: p, map: self.currentPageState)
        }
        
        if rootNode.needCallBack {
            handleCallBack()
        }
    }

    
     // 加载绘制的View
    func loadDrawView(element: BaseLayoutElement) {
        if self.containerView != nil {
            self.containerView?.removeFromSuperview()
            self.containerView = nil
        }
        
        // 背景颜色替换
        self.view.backgroundColor = UIColor.colorFromHexString(hex: element.backgroudColor ?? "#ffffff")

        self.containerView = ContainerView.init(rootNode: element)
        self.containerView?.delegate = self
        self.contentView.addSubview(self.containerView!)

        if let marign = self.containerView!.margin {
            self.containerView!.snp.makeConstraints { (make) in
                make.top.equalTo(marign[0])
                make.bottom.equalTo(-marign[1])
                make.left.equalTo(marign[2])
                make.right.equalTo(-marign[3])
            }
        } else {
            self.containerView!.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
        
        // 显示静态模板
//        self.containerView?.update(data: nil)
    }
    
//    func loadData(params: [String: Any]?) {
//        PageFileManager.requestPageData(pageId: self.pageId, inFirstPage: self.inFirstPage, params: params) {[weak self] (newNode, updateData) in
//
//            guard let self = self else { return }
//            self.inFirstPage = 0
//
//            // 如果新布局文件存在则移除当前页面
//            if let node = newNode {
//                self.loadDrawView(element: node)
//            }
//
//            if let data = updateData {
//                // 更新初始状态
//                self.udpateCurrentSate(serviceData: data.toData()!)
//                if let s = self.currentPageState {
//                    containerStore.dispatch(LoadPageAction(pageId: self.pageId, pageSate: s))
//                } else {
//                    // 更新数据
//                    self.containerView?.update(data: data.toData()!)
//                }
//
//            } else {
//
//                if let s = self.currentPageState {
//                    containerStore.dispatch(LoadPageAction(pageId: self.pageId, pageSate: s))
//                } else {
//                    self.containerView?.update(data: nil)
//                }
//            }
//
//        }
//    }
    
    // action创建
    let containerActionCreater = ContainerActionCreater()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityInd.frame = CGRect(x:0.0, y:0.0, width:40.0, height:40.0);
        self.activityInd.hidesWhenStopped = true
        self.activityInd.center = self.view.center
        
        if let node = self.rootNode {
            self.loadDrawView(element: node)
            
            containerStore.dispatch(containerActionCreater.initLoad(pageId: self.pageId, initState: self.currentPageState, params: getRequestParam(methodKey: "initLoad")))
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        containerStore.subscribe(self) { state in state }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        containerStore.unsubscribe(self)
    }
    
     // MARK: 回调处理
    func handleCallBack() {
        // 处理界面返回传参
        self.backHandleBlock = {[weak self] args in
            print("****界面回调传参： \(args)***\n")
            guard let self = self else {
                return
            }
            if let argsMap = args as? [String: Any] {
                
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 100)) {
                    containerStore.dispatch(UpdateMutilConnectStateAction(pageId: self.pageId, mutilState: argsMap))
                }
                
            }
        }
    }
    
    //MARK: update state
    func newState(state: ContainerState) {
        
        changeLoading(loading: state.isLoading)
        changeRefreshState(hasNextPage: state.hasNextPage)

        // 如果新布局文件存在则移除当前页面
        if let node = state.updateNode {
            self.loadDrawView(element: node)
        }
        
        // 获取当前页面状态
        if let currentPageState = state.propertys?[self.pageId] {
            
            // 验证状态是否改变
            let oldStateKey = self.currentPageState?[StateChangeIdentify] as? String
            let newStateKey = currentPageState[StateChangeIdentify] as? String
            if oldStateKey != newStateKey {
                self.currentPageState = currentPageState
                // 更新动态节点
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: GlobalStateChangeNotifyKey), object: currentPageState)
                // 更新状态数据
                self.containerView?.update(data: currentPageState.toData()!)
            }
        }
    }
}

 // MARK: 更新参数
extension BaseViewController {
    // 获取初始化请求方法参数 // 从状态数据中替换参数
    func getRequestParam(methodKey: String) -> [String: Any]? {
        var params: [String: Any]?
        if let initLoadParam = self.rootNode?.requestMap?[methodKey] as? [String: Any], let data = self.currentPageState?.toData() {
            params = OYUtils.replaceExpressionValue(originMap: initLoadParam, sourceData: data)
        }
        return params
    }
}

 // MARK: 更新状态容器关联值
extension BaseViewController {
    func udpateCurrentSate(serviceData: Data) {
        if var newSateInfo = self.currentPageState {
            newSateInfo = OYUtils.replaceExpressionValue(originMap: newSateInfo, sourceData: serviceData)
            newSateInfo = OYUtils.relaceStateExpressionValue(originMap: newSateInfo, sourceData: serviceData)
            self.currentPageState = newSateInfo
        }
    }
}

 // MARK: 状态变更刷新全局状态
extension BaseViewController {
    
    
    /// 结束loading提示
    func changeLoading(loading: Bool) {
        if loading {
            self.view.addSubview(self.activityInd)
            self.activityInd.startAnimating()
        } else {
            self.activityInd.stopAnimating()
        }
    }
    
    /// 结束上下拉刷新
    func changeRefreshState(hasNextPage: Bool) {
        self.containerView?.tableView?.mj_header?.endRefreshing()
        if hasNextPage {
            /** 重置没有更多的数据（消除没有更多数据的状态） */
            self.containerView?.tableView?.mj_footer?.resetNoMoreData()
        }else {
            self.containerView?.tableView?.mj_footer?.endRefreshingWithNoMoreData()
        }
    }
}

 // MARK: ContainerViewDelegate
extension BaseViewController: ContainerViewDelegate {
    // 头部刷新
    func containerViewHeaderRefreshAction(view: UIView) {
        let params = getRequestParam(methodKey: "headerLoad")
        containerStore.dispatch(containerActionCreater.headerLoad(pageId: self.pageId, params: params))
    }
    
    // 底部刷新
    func containerViewFooterRefreshAction(view: UIView) {
        
        var params = getRequestParam(methodKey: "footerLoad")
        if let page = params?["page"] as? Int {
            params?["page"] = (page + 1)
        }
        containerStore.dispatch(containerActionCreater.footerLoad(pageId: self.pageId, params: params))
    }

    
    func containerViewTextFieldEndEdit(textfield: GWTextField) {
        // 把Textfield的值设置到关联状态值
        let text = textfield.text
        
        // 获取当前节点关联的状态key
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.init(uptimeNanoseconds: 100)) {
            if let stateKey = textfield.node?.state?["connectState"] as? String {
                containerStore.dispatch(UpdateConnectStateAction(pageId: self.pageId, connectStateKey: stateKey, value: text as Any))
            }
        }
    }
    
    func getSuperContainerView(view: UIView?) -> ContainerView? {
        
        if let v = view?.superview as? ContainerView {
            return v
        } else {
           return getSuperContainerView(view: view?.superview)
        }
    }
    
    func containerViewClickedByAction(view: UIView, action: ActionEntry) {
        
        // 替换Action关联参数
        var updateAction = action
        
        if let conainerView = getSuperContainerView(view: view)  {
            if let lastData = conainerView.lastData {
                // 替换方法名
                updateAction.actionType = OYUtils.replaceSignExpressionValue(expresion: action.actionType as Any, sourceData: lastData) as? String
                // 替换参数表达式对应的值
                if let ePrama = action.expressionParams {
                    updateAction.params = OYUtils.replaceSignExpressionValue(expresion: ePrama, sourceData: lastData) as? [String : Any]
                }
            }
            
            if var params = updateAction.params, let lastData = conainerView.lastData {
                // 替换方法参数
                params = OYUtils.replaceExpressionValue(originMap: params, sourceData: lastData)
                updateAction.params = params
            }
        }
        
        updateAction.connectView = view

        updateAction.pageIdentify = self.pageId
        containerStore.dispatch(updateAction)
    }
    
}



