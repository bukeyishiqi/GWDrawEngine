//
//  OYUtils+Regular.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/4.
//  Copyright © 2020 Gworld. All rights reserved.
//

import Foundation



extension OYUtils {
    
    static func isValidURL(urlString: String) -> Bool {
        let urlRegEx  = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"

        let urlTest = NSPredicate.init(format: "SELF MATCHES %@", urlRegEx)
        return urlTest.evaluate(with: urlString)
    }
}
