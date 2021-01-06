//
//  StackView.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 6/26/18.
//  Copyright © 2018 Khoren Markosyan. All rights reserved.
//

import UIKit

class GWStackView: UIStackView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    /***********************/
    
    func makeUI() {
        spacing = 10
        axis = .vertical

        updateUI()
    }

    func updateUI() {
        setNeedsDisplay()
    }
    
    func setStackViewProperty(node: StackViewNode) {
        if let axis = node.axis {
            self.axis = DrawPropertyUtils.getAxis(axis)
        }
        
        if let distribution = node.distribution {
            self.distribution = DrawPropertyUtils.getDistribution(distribution)
        }
        if let alignment = node.alignment {
            self.alignment = DrawPropertyUtils.getAlignment(alignment)
        }
        self.spacing = CGFloat((node.space) ?? 0)
    }
}
