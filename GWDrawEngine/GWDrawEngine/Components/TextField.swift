//
//  TextField.swift
//  GWDrawEngine
//
//  Created by 陈琪 on 2020/6/25.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit


protocol GWTextFieldDelegate: NSObjectProtocol {
    // ContainerView事件回调
    func gwTextFieldEndEdit(textfield: GWTextField)
}

class GWTextField: UITextField {

    weak var gwDelegate: GWTextFieldDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }
    
    /***********************/
    
    override var placeholder: String? {
        didSet {
            
        }
    }

    func makeUI() {
        self.delegate = self
    }

    func setTextfieldProperty(node: TextFieldNode) {
       if let content = node.content {
           self.text = content
       }
       
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
       
       self.textColor = UIColor.colorFromHexString(hex: node.color ?? "#ffffff")
       
       if let pholder = node.placeholder {
            self.placeholder = pholder
           let pAttr = NSAttributedString.init(string: pholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor.colorFromHexString(hex: node.placeholderColor ?? "#ffffff"), NSAttributedString.Key.font: UIFont.systemFont(ofSize: CGFloat(size))])
           self.attributedPlaceholder = pAttr
       }
   }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        self.setDelayProperty()
    }
}


extension GWTextField: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.gwDelegate?.gwTextFieldEndEdit(textfield: textField as! GWTextField)
    }
    
}
