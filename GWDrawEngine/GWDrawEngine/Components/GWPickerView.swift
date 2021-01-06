//
//  GWPickerView.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/8.
//  Copyright © 2020 Gworld. All rights reserved.
//

import UIKit

class GWPickerView: UIPickerView {

    lazy var pickerViewDataSource: [Any] = [Any]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        makeUI()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        makeUI()
    }

    /***********************/
    
    func makeUI() {
        backgroundColor = UIColor.clear
        self.delegate = self
    }
}


extension GWPickerView {
    /// 设置模板数据源
     /// - Parameter data: 源数据
     func buildPickerViewData(data: Any) {
         if let stringArr = data as? [String] {
             self.pickerViewDataSource = stringArr
         } else if let mapArr = data as? [[String: Any]] {
             self.pickerViewDataSource = mapArr
         }
         self.reloadAllComponents()
     }
}

extension GWPickerView: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return self.pickerViewDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat((pickerView.node as? PickerViewNode)?.rowHeight ?? 50)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let rowInfo = self.pickerViewDataSource[row]
        
        if let title = rowInfo as? String {
            return title
        } else if let mapTitle = rowInfo as? [String: Any] {
            return mapTitle.values.first as? String ?? ""
        }
        return ""
    }
    
    
}
