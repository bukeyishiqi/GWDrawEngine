//
//  PageFileManager.swift
//  GWDrawEngine
//
//  Created by CQ on 2020/6/28.
//  Copyright © 2020 Chen. All rights reserved.
//

import UIKit

// 服务下发返回结果
typealias PageLoadResult = (_ newNode: BaseLayoutElement?, _ data: [String: Any]?) -> Void


/// 页面文件管理类
class PageFileManager: NSObject {

    /// 获取本地数据库页面布局文件节点对象
    /// - Parameter pageId: 页面ID
    /// - Returns: 页面根节点
    static func getPageFile(pageId: String) -> BaseLayoutElement? {
        
        // 通过页面Id 从本地数据库获取页面布局信息
        guard let pageInfo = DBHelperDAO.queryPageSource(withPageId: pageId) as? [String: Any] else {
            print("*** 查询的本地页面 \(pageId) 不存在 ****")
            
            /*******************************/
            // 测试数据库 插入页面
            insertPageInfo(pageId: pageId)
            if let info = DBHelperDAO.queryPageSource(withPageId: pageId) as? [String: Any] {
                if let element = (info[Page_layoutData] as? String)?.toDictionary() {
                    // 信息转换布局对象
                    return  NodeCreater.createLayoutNode(nodeInfo: element)
                }
            }
            /*******************************/
            return nil
        }
        
        if let element = (pageInfo[Page_layoutData] as? String)?.toDictionary() {
            // 信息转换布局对象
            return   NodeCreater.createLayoutNode(nodeInfo: element)
        }
        
        return nil
    }
}


 // MARK: Private Methods
extension PageFileManager {
    
    
    /// 测试 插入保存界面数据
    static func insertPageInfo(pageId: String) {
        var info: [String: Any] = [String: Any]()
        if pageId == "1" {
            
            info = RequestGroupMemberListPageJson
        } else if pageId == "myIndex" {
            
            info =  RequestMyPageJson
        } else if pageId == "setting" { // 设置
            
            info =  RequestSettingPageJson
        } else if pageId == "editText" { // 编辑姓名
            
            info = RequestEditTextPageJson
            
         } else if pageId == "about" { // 关于
            
            info =  AboutPageJson
        } else if pageId == "helper" { // 帮助
            
            info =  HelpPageJson
            
        } else if pageId == "version" { // 版本信息
            
        } else if pageId == "serviceAgreement" { // 服务协议
                   
        } else if pageId == "myBusiness" { // 我的企业
           
        } else if pageId == "businessInfo" { // 企业信息
           
        } else if pageId == "customerService" { // 人工客服
           
        }
        
        
        
        else if pageId == "groupMessage" { // 群聊资料（新）
            info = RequestGroupMessageJson
        } else if pageId == "groupMemberList" { // 群成员列表
            info = GroupMemberListJson
        } else if pageId == "groupManagerSetting" { // 群管理员设置
            info = RequestGroupManagerSettingJson
        } else if pageId == "Blacklist" { // 黑名单设置
            info = RequestBlacklistSettingsJson
        } else if pageId == "modifyGroupName" { // 修改群名称
            info = RequestModifyGroupNameJson
        }  else if pageId == "groupManagerAdd" { // 添加群管理员
           info = RequestGroupManagerAddJson
        }  else if pageId == "groupInvitationPermission" {
           info = GroupInvitationPermissionSettingJson
        }

        else if pageId == "MeetingPreview" {
            info = MeetingPreviewJson
        } else if pageId == "HasConfirmMember" {
            info = HasConfirmMemberJson
        }  else if pageId == "MeetingPreviewPage" {
           info = MeetingPreviewPageJson
        }
            
            
            
        else if pageId == "6" {
            
            info =  UserMessageJson
        } else if pageId == "Alter" {
            
            info =  PopComponentJson
        } else if pageId == "Verfiy" {
            
            info =  inputPopComponentJson
        } else if pageId == "PickerSelect" { // 选择内容弹框
            
            info = RequestPopPickerViewComponentJson
        }
        
        
        let version = info["version"] as? String ?? "1"
        let nodeData: String? = (info["template"] as? [String: Any])?.toJsonString()
        let updateD: String?  = (info["serviceData"] as? [String: Any])?.toJsonString()
        
        DBHelperDAO.insertPageSource(pageId, layoutData: nodeData, pageData: updateD, version: version)
    }
    
    
    /// 保存界面数据
    static func savePageInfo(pageId: String, info: [String: Any]) {
        
        let version = info["version"] as? String ?? "1"
        let nodeData: String? =  (info["template"] as? [String: Any])?.toJsonString()
        let updateD: String? =  (info["serviceData"] as? [String: Any])?.toJsonString()
        
        DBHelperDAO.updatePageSource(pageId, layoutData: nodeData, pageData: updateD, version: version)
    }
}
