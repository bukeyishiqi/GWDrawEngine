//
//  RouterConfig.swift
//  icar
//
//  Created by 陈琪 on 2019/12/4.
//  Copyright © 2019 Carisok. All rights reserved.
//

import Foundation


// MARK: 路由模式SChema
let FCDefaultRouteSchema = "icar"

// MARK: 路由匹配表
let FCNavRoute = "/com_carisok/<viewController>"
let FCHTTPRoute = "http://<path:_>"
let FCHTTPsRoute = "https://<path:_>"



// MARK: Key
fileprivate let StoryBoardNameKey = "kStryboardName"
/** 控制器是否需要被导航栏包含*/
fileprivate let NeedNavigatorVC = "kNeedNavigatorVC"


protocol Navigatable {
    var navigator: FCNavigator { get set }
}

class FCNavigator {
    
    static let `default` = FCNavigator()

    var root: UINavigationController?
    
    enum Scene {
        /** 控制器*/
        case vc(url: URL, context:Any?)
    }
    
    enum Transition {
        /** 根视图*/
        case root(in: UIWindow)
        /** push*/
        case navigation
        /** 包裹导航栏present*/
        case customModal
        /** present控制器*/
        case modal
        /** 自适应选择*/
        case detail
        /** 自定义*/
        case custom
    }
    
    
    init() {
        registerRouter()
    }
    
    func setRoot(root: UINavigationController?) {
        self.root = root
    }
    
    // MARK: 注册应用导航
    func registerRouter() {
    }
    
    
    private lazy var newNavgatorControllers: [String] = [String]()
    
    // MARK: 添加需要被导航栏包含的控制器名
    func addNeedNavgatorController(_ vcName: String) {
        newNavgatorControllers.append(vcName)
    }
}


// MARK: 界面跳转控制
extension FCNavigator {
    
    // MARK - pop
    func pop(pageId: String? = nil, callback args: Any? = nil, animated: Bool = true) -> BaseViewController? {

        /** 通过类名取到VC， 如果不存在直接返回上一层*/
        var vc: UIViewController?
        if let `class` = pageId {
            if let childerVCs = root?.viewControllers {
                
                for item in childerVCs {
                    if let childv = item as? BaseViewController, childv.pageId == `class` {
                        vc = item
                        break
                    }
                }
            }
            
            if pageId == "root" {
                root?.popToRootViewController(animated: animated)
                vc = root?.topViewController
            } else {
                if let popVC = vc {
                    let _ = root?.popToViewController(popVC, animated: animated)?.first
                } else {
                    vc = root?.popViewController(animated: animated)
                }
            }
        } else {
            vc = root?.popViewController(animated: animated)
        }
     
        if let callBack = vc?.backHandleBlock {
            callBack(args)
        }
        return vc as? BaseViewController
    }
    
}



extension FCNavigator {

    func show(target: UIViewController, transition: Transition = .navigation) {

       switch transition {
       case .navigation:
        if let nav = self.root {
               nav.pushViewController(target, animated: true)
           }
       case .customModal:
           DispatchQueue.main.async {
            let nav = self.setControllerProperty(UINavigationController(rootViewController: target))
               nav.present(nav, animated: true, completion: nil)
           }
       case .modal:
        if let nav = self.root {
            DispatchQueue.main.async {
                nav.present(target, animated: true, completion: nil)
            }
        }
           
       case .detail:
           DispatchQueue.main.async {
               let nav = self.setControllerProperty(UINavigationController(rootViewController: target))
               nav.showDetailViewController(nav, sender: nil)
           }
       default: break
       }
    }
    
}

extension FCNavigator {
    
    // MARK: 设置控制器属性
    private func setControllerProperty(_ vc: UIViewController) -> UIViewController {
        vc.hidesBottomBarWhenPushed = true
        vc.modalPresentationStyle = .fullScreen
        
        return vc
    }
}
