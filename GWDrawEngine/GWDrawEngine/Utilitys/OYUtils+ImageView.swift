//
//  OYUtils+ImageView.swift
//  iboss
//
//  Created by 陈琪 on 2018/6/25.
//  Copyright © 2018年 Carisok. All rights reserved.
//

import Foundation
//import Kingfisher

extension OYUtils {
    static func loadImageView(imageView: UIImageView, url: String, placeholder: String? = nil) {
//        guard let url = URL.init(string: url) else {
//            return
//        }
        
        var resource: ImageResource?
        if OYUtils.isValidURL(urlString: url) {
            resource = ImageResource(downloadURL: URL.init(string: url)!)
            imageView.kf.setImage(with: resource, placeholder: UIImage.init(named: placeholder ?? "default_feche_placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        } else {
            imageView.image = UIImage.init(named: url)
        }

    }
    
    /** 图片通过约束添加标签遮罩层*/
    static func loadImageViewAndMaskImage(imageView: UIImageView, url: String, placeholder: String? = nil, tagUrl: String?) {
        loadImageView(imageView: imageView, url: url, placeholder: placeholder)
        
        guard let tagUrl = tagUrl, tagUrl.count > 0 else {
            imageView.subviews.forEach {
                $0.removeFromSuperview()
            }
            return
        }
        
        let maskView = UIImageView().then {
            $0.backgroundColor = UIColor.clear
            $0.contentMode = .scaleToFill
        }
        imageView.addSubview(maskView)
        imageView.bringSubviewToFront(maskView)
        maskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        loadImageView(imageView: maskView, url: tagUrl, placeholder: nil)
    }
    
    
    /** 图片通过Frame添加标签遮罩层*/
    static func loadImageViewAndMaskImage(imageView: UIImageView, url: String, placeholder: String? = nil, tagUrl: String?, frame: CGRect) {
        
        loadImageView(imageView: imageView, url: url, placeholder: placeholder)
        
        guard let tagUrl = tagUrl, tagUrl.count > 0 else {
            imageView.subviews.forEach {
                $0.removeFromSuperview()
            }
            return
        }
        
        let maskView = UIImageView().then {
            $0.backgroundColor = UIColor.clear
            $0.contentMode = .scaleToFill
            $0.frame = frame
        }
        imageView.addSubview(maskView)
        imageView.bringSubviewToFront(maskView)
        
        loadImageView(imageView: maskView, url: tagUrl, placeholder: nil)
    }
    
    
    // MARK: 图片添加遮罩提示文字
    static func loadImageViewAndMaskText(imageView: UIImageView, maskText: String?) {
        guard let text = maskText, text.count > 0 else {
            imageView.subviews.forEach { // 文字不存在则移除
                if $0.tag == 101 {
                    $0.removeFromSuperview()
                }
            }
            return
        }
        imageView.subviews.forEach {
            if $0.tag == 101 {
                $0.removeFromSuperview()
            }
        }
        
        let maskView = UIView().then {
            $0.backgroundColor = UIColor.black
            $0.contentMode = .scaleToFill
            $0.alpha = 0.5
            $0.tag = 101
        }
        
        // 创建遮罩Text视图
        let label = UILabel().then {
            $0.textColor = UIColor.white
            $0.text = maskText
            $0.font = UIFont.systemFont(ofSize: 15)
            $0.textAlignment = .center
        }
        maskView.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        imageView.addSubview(maskView)
        imageView.bringSubviewToFront(maskView)
        maskView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

