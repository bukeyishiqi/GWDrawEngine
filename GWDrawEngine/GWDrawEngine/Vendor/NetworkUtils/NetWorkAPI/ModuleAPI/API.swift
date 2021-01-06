//
//  BaseModuleApi.swift
//  icar
//
//  Created by 陈琪 on 2019/12/20.
//  Copyright © 2019 Carisok. All rights reserved.
//

import Foundation

private let assetDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

// MARK: 获取本地target测试数据
public func getSampleData(_ fileName: String) -> Data {
    
    if let url =  Bundle.main.url(forResource: fileName, withExtension: "json"), let data = try? Data(contentsOf: url) {
        return data
    }
    return Data()
}


public enum API {
    
    // 获取页面配置模板、数据
    case getPageData(inFirstPage: Int,  page: String, version: Int, param: [String: Any]?)
    // 业务转发
    case commitBusiness(method: String, service: String, url: String, param: String?)
}


extension API: TargetType {
    
    public var path: String {
        switch self {
        case .getPageData:
            return "dynamicview/page/details"
        case .commitBusiness:
            return "dynamicview/forward"
        }
    }
    
//    public var method: FCRequestMethod {
//        switch self {
//        default:
//            return .POST
//        }
//    }
    
    public var parameters: Parameters? {
        switch self {
        case .getPageData(inFirstPage: let first,  page: let page, version: let v, param: let param):
            var params: [String : Any] = ["inFirstPage": first, "page": page, "version": v]
            if let p = param {
                params["param"] = p
            }
            return params
        case .commitBusiness(method: let method, service: let service, url: let url, param: let param):
            var params: [String : Any] = ["method": method, "service": service, "url": url]
            if let p = param {
                params["param"] = p
            }
            return params
        }
    }
    
    var localLocation: URL {
        
        return assetDir
    }
    
    public var sampleData: Data? {
        switch self {
        case .getPageData(inFirstPage: _, page: let page, version: _, param: _):
            return getLocationPageLayData(pageId: page)
        case .commitBusiness:
            return Data()
        }
    }

}


 // MARK: 获取页面测试本地数据
extension API {
    
    func getLocationPageLayData(pageId: String) -> Data? {
        if pageId == "1" {
            
            return RequestGroupMemberListPageJson.toData()
        } else if pageId == "myIndex" {
            
            return RequestMyPageJson.toData()
        } else if pageId == "setting" { // 设置
            
            return RequestSettingPageJson.toData()
            
        } else if pageId == "about" { // 关于
            
            return AboutPageJson.toData()
        } else if pageId == "helper" { // 帮助
            
            return HelpPageJson.toData()
            
        } else if pageId == "version" { // 版本信息
            
        } else if pageId == "serviceAgreement" { // 服务协议
                   
        } else if pageId == "myBusiness" { // 我的企业
           
        } else if pageId == "businessInfo" { // 企业信息
           
        } else if pageId == "customerService" { // 人工客服
           
        }
        
        
        
        
        else if pageId == "groupMessage" { // 群资料
            
            return RequestGroupMessageJson.toData()
            
        } else if pageId == "groupMemberList" { // 群成员
            return GroupMemberListJson.toData()
            
        } else if pageId == "groupManagerSetting" { // 群管理员设置
            
            return RequestGroupManagerSettingJson.toData()
        } else if pageId == "Blacklist" { // 黑名单设置
            return RequestBlacklistSettingsJson.toData()
        } else if pageId == "modifyGroupName" { // 修改群名称
            return RequestModifyGroupNameJson.toData()
            
        } else if pageId == "groupManagerAdd" { // 添加群管理员
            return RequestGroupManagerAddJson.toData()
        } else if pageId == "groupInvitationPermission" {
            return GroupInvitationPermissionSettingJson.toData()
        }
        
        else if pageId == "MeetingPreview" {
            return MeetingPreviewJson.toData()
        } else if pageId == "HasConfirmMember" {
            return HasConfirmMemberJson.toData()
        } else if pageId == "MeetingPreviewPage" {
            return MeetingPreviewPageJson.toData()
        }
        
        
        
        else if pageId == "6" {
            
            return UserMessageJson.toData()
        } else if pageId == "Alter" {
            
            return PopComponentJson.toData()
        } else if pageId == "Verfiy" {
            
            return inputPopComponentJson.toData()
        }
        return nil
    }
    
}
