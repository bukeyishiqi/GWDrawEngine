//
//  DrawButton.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/25.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

class GWButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    /***********************/
    
    func makeUI() {
                
        layer.masksToBounds = true
        titleLabel?.lineBreakMode = .byWordWrapping

        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
    
    func setButtonProperty(node: ButtonNode) {
        if let content = node.content {
            self.isHidden = false
           if content.hasSuffix(".png") || content.hasSuffix(".jpg") {
               self.setImage(UIImage.init(named: content), for: .normal)
           } else {
               self.setTitle(content, for: .normal)
           }
        } else {
            self.isHidden = true
        }
        self.setTitleColor(UIColor.colorFromHexString(hex: node.color ?? "#ffffff"), for: .normal)
        self.titleLabel?.font = UIFont.systemFont(ofSize: CGFloat(node.size ?? 16))
        
        if let image = node.image, image.count > 0 {
            self.setImage(UIImage.init(named: image), for: .normal)
        }
        
        // FIXME: 宽度需要自适应
//        if self.constraint_width != nil {
//            if let selfSize = self.titleLabel?.sizeThatFits(CGSize.init(width: kScreenW, height: kScreenH)) {
//                self.constraint_width?.update(inset: selfSize.width)
//            }
//        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setDelayProperty()
    }
}
