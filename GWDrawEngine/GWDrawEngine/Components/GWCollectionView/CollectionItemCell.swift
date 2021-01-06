//
//  CollectionItemCell.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/15.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit

class CollectionItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.backgroundColor = UIColor.clear
        self.backgroundColor = UIColor.clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /***********************/
    
    // 添加子view
    func addchildView(_ view: UIView)
    {
        self.contentView.addSubview(view)
        
        if let marign = view.margin {
            view.snp.makeConstraints { (make) in
                make.top.equalTo(marign[0])
                make.bottom.equalTo(-marign[1])
                make.left.equalTo(marign[2])
                make.right.equalTo(-marign[3])
            }
        } else {
            view.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // 备注：渲染问题，cell圆角需此处绘制
        if let view = self.contentView.viewWithTag(100)?.subviews.first {
            DrawComponentsUtils.drawRadiusLoction(view: view)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        // 备注：渲染问题，cell圆角需此处绘制
       if let view = self.contentView.viewWithTag(100)?.subviews.first {
        DrawComponentsUtils.drawRadiusLoction(view: view)
       }
    }
    
}
