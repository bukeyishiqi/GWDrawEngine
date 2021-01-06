//
//  ViewController.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/23.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
//        let obj = TemplateConvertHelper.convertTemplateToObj(template: module1)

        // 添加点击按钮
       let moreButton = UIButton.init(type: .custom).then {

            $0.setTitle("查看", for: .normal)
            $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            $0.backgroundColor = UIColor.white
            $0.setTitleColor(UIColor.colorFromHexString(hex: "333333"), for: .normal)
            $0.layer.cornerRadius = 8
            $0.frame = CGRect.init(x: 10, y: 0, width: 50, height: 43)
           
            $0.addTarget(self, action: #selector(showMoreStoreAction), for: .touchUpInside)
        }
        self.view .addSubview(moreButton)
        moreButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }


    @objc func showMoreStoreAction() {
        
        Application.shared.initialScreen(pageId: "groupMessage", rootNav: self.navigationController, params: nil)
    }
    
    
}

