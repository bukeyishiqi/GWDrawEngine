//
//  DrawPropertyUtils.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/23.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

class DrawPropertyUtils: NSObject {

    // MARK: 获取布局方式 水平 垂直
    static func getAxis(_ axis: String) -> NSLayoutConstraint.Axis {
        if axis == "horizontal" {
            return .horizontal
        } else if axis == "vertical" {
            return .vertical
        }
        return .vertical
    }
    
    
    // MARK: 获取分布方式
    static func getDistribution(_ distribution: String) -> UIStackView.Distribution {
        if distribution == "fill" {
            return .fill
        } else if distribution == "fillEqually" {
            return .fillEqually
        } else if distribution == "fillProportionally" {
            return .fillProportionally
        } else if distribution == "equalSpacing" {
            return .equalSpacing
        } else if distribution == "equalCentering" {
            return .equalCentering
        }
        return .fill
    }
    
    // MARK: 获取UIStackView布局Alignment
    static func getAlignment(_ alignment: String) -> UIStackView.Alignment {
        if alignment == "center" {
            return .center
        } else if alignment == "fill" {
            return .fill
        } else if alignment == "leading" {
            return .leading
        } else if alignment == "trailing" {
            return .trailing
        }
        return .center
    }
    
    // MARK: 获取Label排列方式
    static func getLabelAlignment(_ alignment: String) -> NSTextAlignment {
        if alignment == "left" {
            return .left
        } else if alignment == "center" {
            return .center
        } else if alignment == "right" {
            return .right
        }
        return .left
    }
    
    
    /// 获取布局方式
     /// - Parameter value: 布局描述字符串
     /// - Returns: 布局类型
    static func getLayoutType(type: String) -> LayoutType {
         if type == "Linear" {
             return .linear
         } else if type == "absolute" {
             return .absolute
         }
         return .linear
     }
}



 // MARK: TableView
extension DrawPropertyUtils {
    static func getTableViewStyle(desc: String) -> UITableView.Style {
        if desc == "group" {
            return .grouped
        }
        
        return .plain
    }
    
    static func getTableViewSeparatorStyle(desc: String) -> UITableViewCell.SeparatorStyle {
        if desc == "singleLine" {
            return .singleLine
        } else if desc == "none" {
            return .none
        }
        return .none
    }
}

 // MARK: CollectionView
extension DrawPropertyUtils {
    static func getCollectionViewScrollDirection(desc: String) -> UICollectionView.ScrollDirection {
        if desc == "horizontal" {
            return .horizontal
        } else if desc == "vertical" {
            return .vertical
        }
        return .vertical
    }
}
