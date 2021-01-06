//
//  Application.swift
//  icar
//
//  Created by 陈琪 on 2019/12/9.
//  Copyright © 2019 Carisok. All rights reserved.
//

import UIKit

open class Application: NSObject {
    
    static let shared = Application()

    @objc public static func sharedInstance() -> Application {
        return Application.shared
    }
    
    let navigator: FCNavigator
    
    private override init() {
        navigator = FCNavigator.default
        
        super.init()
        updateProvider()
    }
    
    
    
    private func updateProvider() {
    }
    
    @objc func initialScreen(pageId: String, rootNav: UINavigationController?, params: [String: Any]?) {
        updateProvider()
        guard let root = rootNav else { return }
        navigator.setRoot(root: root)
        
        if let vc = DisplayHelper.displayPage(pageId: pageId, params: params) {
            navigator.show(target: vc)
        }
    }
    
    func startService() {
        DBHelperDAO.connect {
            UpdateApp.update()
        }
    }
}

