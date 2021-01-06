//
//  RefreshPresentable.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/18.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


protocol RefreshPresentable: class {
    
    func loadAction()
    func reloadAction()
    
    func setupRefresh(refreshStyle: String, on scrollView: UIScrollView)
}

// MARK: - PullToRefresh

extension RefreshPresentable {
    
    func setupRefresh(refreshStyle: String, on scrollView: UIScrollView) {
        scrollView.mj_header = MJRefreshNormalHeader.init(refreshingBlock: {[weak self] in
            self?.reloadAction()
        })
        
        scrollView.mj_footer = MJRefreshAutoNormalFooter.init(refreshingBlock: { [weak self] in
            self?.loadAction()
        })
    }
//    func setupRefresh(refreshStyle: String, on scrollView: UIScrollView) {
//
//        // 通过style获取node
//        let node = BaseLayoutElement(nodeInfo: nil)
//        let headerRefresh = Re1freshComponentHelper.buildDefaultRefreshStyleComponent(layoutElement: node, position: .top)
//
//        scrollView.addPullToRefresh(headerRefresh) { [weak self] in
//            self?.reloadAction()
//        }
//
//        // 通过style获取node
//        let footerNode = BaseLayoutElement(nodeInfo: nil)
//        let footerRefresh = RefreshComponentHelper.buildDefaultRefreshStyleComponent(layoutElement: footerNode, position: .bottom)
//
//        scrollView.addPullToRefresh(footerRefresh) { [weak self] in
//            self?.loadAction()
//        }
//    }
    
    func loadAction() {}
    func reloadAction() {}
}
