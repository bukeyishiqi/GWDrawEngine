//
//  Routes+GenerateURL.swift
//  icar
//
//  Created by 陈琪 on 2019/12/4.
//  Copyright © 2019 Carisok. All rights reserved.
//

import Foundation


// MARK: URL生成器

extension FCNavigator {
    class func fcRouter(schema: String, path: String) -> String {
        return "\(schema)://\(path)"
    }
    
    class func generateURL(_ className: String, _ extraParameters: [String: Any]? = nil) -> URL? {
        let queryString = fc_mapDictionaryToURLQueryString(map: extraParameters)
        
        let url = URL.init(string: fcRouter(schema: FCDefaultRouteSchema, path: "/com_carisok/\(className)?" + queryString))

        return url
    }
    
    
    /**
     避免 URL 散落各处， 集中生成URL
     
     @param pattern 匹配模式
     @param parameters 附带参数
     @return URL字符串
     */
    class func fc_generateURL(pattern: String, parameters:[String]) -> String {
        return ""
    }
    
    
    /**
     避免 URL 散落各处， 集中生成URL
     额外参数将被 ?key=value&key2=value2 样式给出
     
     @param pattern 匹配模式
     @param parameters 附加参数
     @param extraParameters 额外参数
     @return URL字符串
     */
    class func fc_generateURL(pattern: String, parameters:[String], extraParameters:[String: Any]) -> String {
        return ""
    }
    
    /**
    解析NSURL对象中的请求参数
    http://madao?param1=value1&param2=value2 解析成 @{param1:value1, param2:value2}
    @param URL NSURL对象
    @return URL字符串
    */
    class func fc_parseParam(URL: URL) -> [String: Any] {
        let parameterString = URL.query
        var parameterDic = [String: Any]()
        
        if let paramString = parameterString, paramString.count > 0 {
            let kvPart = paramString.components(separatedBy: "&")
            for kv in kvPart {
                let kvArr = kv.components(separatedBy: "=")
                if kvArr.count == 2 {
                    parameterDic[kvArr.last!] = kvArr.first
                }
            }
        }
        return parameterDic
    }
    
    
    /**
     将参数对象进行url编码
     将@{param1:value1, param2:value2} 转换成 ?param1=value1&param2=value2
     @param dic 参数对象
     @return URL字符串
     */
     class func fc_mapDictionaryToURLQueryString(map: [String: Any]?) -> String {
        
        guard let dic = map, dic.count > 0 else {
            return ""
        }
        
        
        let components = NSURLComponents()
        
        var queryItems = [URLQueryItem]()
        
        for item in dic {
            let queryKey = "\(item.key)"
            let queryValue = "\(item.value)"
            let queryItem = URLQueryItem.init(name: queryKey, value: queryValue)
            queryItems.append(queryItem)
        }
       
        components.queryItems = queryItems as [URLQueryItem]
        
        return components.url!.absoluteString
    }
}
