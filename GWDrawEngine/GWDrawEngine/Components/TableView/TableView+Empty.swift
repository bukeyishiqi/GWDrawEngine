//
//  TableView+Empty.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/25.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



extension GWTableView: DZNEmptyDataSetSource {

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        if let node = self.node as? TableViewNode, let config = node.emptyConfiguration {
            return NSAttributedString.init(string: config.title ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(config.titleFontSize)), NSAttributedString.Key.foregroundColor: config.titleColor])

        }
        
        return NSAttributedString(string: "")
    }

    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        
        if let node = self.node as? TableViewNode, let config = node.emptyConfiguration {
            return NSAttributedString.init(string: config.description ?? "", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(config.descriptionFontSize)), NSAttributedString.Key.foregroundColor: config.descriptionColor])
        }
        
        return NSAttributedString(string: "")
    }

    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        if let node = self.node as? TableViewNode, let imageName = node.emptyConfiguration?.emptyImage {
            return UIImage.init(named: imageName)

        }
        
        return UIImage()
    }

    func imageTintColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return nil
    }

    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return .clear
    }

    func verticalOffset(forEmptyDataSet scrollView: UIScrollView!) -> CGFloat {
        if let node = self.node as? TableViewNode, let offset = node.emptyConfiguration?.emptyOffset {
            return CGFloat(offset)
        }
        return 0
    }
}

extension GWTableView: DZNEmptyDataSetDelegate {

//    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
//        return !isLoading.value
//    }

    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }

    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {

    }
}
