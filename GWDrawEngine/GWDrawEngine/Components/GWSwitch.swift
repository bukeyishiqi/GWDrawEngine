//
//  Switch.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/25.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

class GWSwitch: UISwitch {

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
       
    }

    func setSwitchProperty(node: SwitchNode) {
        self.isOn = (node.value == "1")
    }
}
