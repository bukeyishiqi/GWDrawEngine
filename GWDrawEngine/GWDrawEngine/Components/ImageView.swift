//
//  ImageView.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/25.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

class GWImageView: UIImageView {
    
     override init(frame: CGRect) {
           super.init(frame: frame)
           makeUI()
       }

       override init(image: UIImage?) {
           super.init(image: image)
           makeUI()
       }

       override init(image: UIImage?, highlightedImage: UIImage?) {
           super.init(image: image, highlightedImage: highlightedImage)
           makeUI()
       }

       required public init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           makeUI()
       }

    /***********************/
    
       func makeUI() {

           layer.masksToBounds = true
           contentMode = .center
           updateUI()
       }

       func updateUI() {
           setNeedsDisplay()
       }
    
    func setImageViewProperty(node: ImageViewNode){
        self.contentMode = UIImageView.ContentMode.init(rawValue: node.contentMode ?? 0) ?? .scaleToFill
       if  node.isSelected == 1 {
           if let content = node.selectedContent {
               OYUtils.loadImageView(imageView: self, url: content)
           }
       } else {
           if let content = node.content {
               OYUtils.loadImageView(imageView: self, url: content)
           }
       }
   }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setDelayProperty()
    }
}
