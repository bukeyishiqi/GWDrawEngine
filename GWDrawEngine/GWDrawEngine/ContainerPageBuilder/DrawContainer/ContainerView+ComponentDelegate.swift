//
//  ContainerView+ComponentDelegate.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/15.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation


 // MARK: GWTableViewDelegate
extension ContainerView: GWTableViewDelegate {
    func gwTableViewHeaderRefreshAction(view: UIView) {
        self.delegate?.containerViewHeaderRefreshAction(view: view)
    }
    
    func gwTableViewFooterRefreshAction(view: UIView) {
        self.delegate?.containerViewFooterRefreshAction(view: view)
    }

    func gwTableViewContainerViewTextFieldEndEdit(textfield: GWTextField) {
        self.delegate?.containerViewTextFieldEndEdit(textfield: textfield)
    }
    
    func gwTableViewContainerViewClickedByAction(view: UIView, action: ActionEntry) {
        self.delegate?.containerViewClickedByAction(view: view, action: action)
    }
}


 // MARK: GWCollectionViewDelegate
extension ContainerView: GWCollectionViewDelegate {
    func gwCollectionContainerViewTextFieldEndEdit(textfield: GWTextField) {
        self.delegate?.containerViewTextFieldEndEdit(textfield: textfield)
    }
    
    func gwCollectionContainerViewClickedByAction(view: UIView, action: ActionEntry) {
        self.delegate?.containerViewClickedByAction(view: view, action: action)
    }
}


 // MARK: GWTextFieldDelegate
extension ContainerView: GWTextFieldDelegate {
    func gwTextFieldEndEdit(textfield: GWTextField) {
        self.delegate?.containerViewTextFieldEndEdit(textfield: textfield)
    }
}


 // MARK: GWPageViewDelegate
extension ContainerView: GWPageViewDelegate {
    func gwPageContainerViewTextFieldEndEdit(textfield: GWTextField) {
        self.delegate?.containerViewTextFieldEndEdit(textfield: textfield)
    }
    
    func gwPageContainerViewClickedByAction(view: UIView, action: ActionEntry) {
        self.delegate?.containerViewClickedByAction(view: view, action: action)
    }
    
    func gwContainerViewWillEndDragging(targetIndex: Int) {
        
    }
    
    
}
