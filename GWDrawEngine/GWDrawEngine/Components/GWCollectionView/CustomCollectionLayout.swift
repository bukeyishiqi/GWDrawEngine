//
//  CustomCollectionLayout.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/15.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit


class CustomCollectionLayout: UICollectionViewFlowLayout {
    
    var kCellNumberOfOneRow: Int = 5  // 默认显示5个
    var kCellRow: Int = 2 // 默认显示2行
    
    var collectionWidth: CGFloat = kScreenW // 宽度

    var itemWH: CGFloat = kScreenW / CGFloat(5)
    
    var topMargin: CGFloat = 0 // 距离顶部边距
    
    var contentInset: UIEdgeInsets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    
    fileprivate var maxContentWidth : CGFloat = 0

    // 保存所有item
    fileprivate var attributesArr: [UICollectionViewLayoutAttributes] = []
    
    // MARK:- 重新布局
    override func prepare() {
        super.prepare()
        
//        itemWH = collectionWidth / CGFloat(kCellNumberOfOneRow)
//        // 设置itemSize
//        itemSize = CGSize(width: itemWH, height: itemWH)
//        minimumLineSpacing = 0
//        minimumInteritemSpacing = 0
        scrollDirection = .horizontal
        
        // 设置collectionView属性
//        collectionView?.isPagingEnabled = false
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.showsVerticalScrollIndicator = false
//        let insertMargin = (collectionView!.bounds.height - 2 * itemWH) * 0.5
        collectionView?.contentInset = contentInset//UIEdgeInsets.init(top: topMargin, left: 0, bottom: kMargin, right: 0)
        
//        var page = 0
        let itemsCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        for itemIndex in 0..<itemsCount {
            let indexPath = IndexPath(item: itemIndex, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
//            page = itemIndex / (kCellNumberOfOneRow * kCellRow)
//            // 通过一系列计算, 得到x, y值
//            let x = itemSize.width * CGFloat(itemIndex % Int(kCellNumberOfOneRow)) + (CGFloat(page) * kScreenW)
//            let y = itemSize.height * CGFloat((itemIndex - page * kCellRow * kCellNumberOfOneRow) / kCellNumberOfOneRow)
//
//            attributes.frame = CGRect(x: x, y: y, width: itemSize.width, height: itemSize.height)
//
            
            
            // 第几页
            let curPage = itemIndex / (kCellNumberOfOneRow * kCellRow)
            // 当前cell所在当页的index
            let curIndex = itemIndex - curPage * (kCellNumberOfOneRow * kCellRow)
            // 当前cell所在当页的行
            let curColumn = curIndex % kCellNumberOfOneRow
            // 当前cell所在当页的列
            let curRow = curIndex / kCellNumberOfOneRow
            // 调整attributes（大小不变，位置改变）
            attributes.frame = CGRect.init(x: collectionView!.bounds.size.width * CGFloat(curPage) + CGFloat(curColumn) * itemSize.width + CGFloat(curColumn) * self.minimumLineSpacing, y: CGFloat(curRow) * itemSize.height + CGFloat(curRow) * self.minimumInteritemSpacing, width: itemSize.width, height: itemSize.height)
            
            // 把每一个新的属性保存起来
            attributesArr.append(attributes)
            
            if maxContentWidth < attributes.frame.maxX {
                maxContentWidth = attributes.frame.maxX
            }
        }
        
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var rectAttributes: [UICollectionViewLayoutAttributes] = []
        _ = attributesArr.map({
            if rect.contains($0.frame) {
                rectAttributes.append($0)
            }
        })
        return rectAttributes
    }
    
    /// 返回内容高度
    override var collectionViewContentSize: CGSize {
        get {
            return CGSize(width: maxContentWidth, height: 0+itemWH*CGFloat(kCellRow))
        }
        set {
            self.collectionViewContentSize = newValue
        }
    }
}
