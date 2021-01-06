//
//  Label.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/25.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

class GWLabel: UILabel {
    
    lazy var gradientLabel: UILabel = {
       let view = GWLabel()
        return view
    }()
    
    var gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
        return gradientLayer
    }()
    
    
    var textInsets = UIEdgeInsets.zero {
        didSet { invalidateIntrinsicContentSize() }
    }

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
        numberOfLines = 1
        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }

    func setLabelProperty(node: TextNode) {
        let size = node.size ?? 16
        if let fontName = node.fontName {
            self.font = UIFont.init(name: fontName, size: CGFloat(size))
        } else {
            if node.isBold == 1 {
                self.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
            } else {
                self.font = UIFont.systemFont(ofSize: CGFloat(size))
            }
        }
        
        self.numberOfLines = node.numberOfLines ?? 1
        self.textAlignment = DrawPropertyUtils.getLabelAlignment(node.alignment ?? "")
        self.textColor = UIColor.colorFromHexString(hex: node.color ?? "#ffffff")
        self.text = node.content
        
        if let _ = node.textGradientColors {
            self.gradientLabel.text = self.text
            self.gradientLabel.font = self.font
            self.gradientLabel.textAlignment = self.textAlignment
        }
    }
    
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        // 渐变背景
        if let gradientcolors = (self.node as? TextNode)?.textGradientColors {
          self.gradientLabel.frame = self.bounds
            gradientLayer.frame = self.gradientLabel.frame

          let newColors = gradientcolors.map { (color) -> Any in
            return UIColor.colorFromHexString(hex: color).cgColor
          }
          
            self.gradientLayer.colors = newColors
            if self.gradientLayer.sublayers != nil {
                self.gradientLayer.removeFromSuperlayer()
            }
            self.layer.addSublayer(self.gradientLayer)
            self.gradientLayer.mask = self.gradientLabel.layer
        }
        
        self.setDelayProperty()
    }

}
