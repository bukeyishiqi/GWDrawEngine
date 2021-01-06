//
//  PureFunctions.swift
//  GworldSuperOffice
//
//  Created by 陈琪 on 2020/7/16.
//  Copyright © 2020 Gworld. All rights reserved.
//



import Foundation



 // MARK: 操作符定义
enum OperatorType: String {
    /** 大于0*/
    case moreThanZero = ">"
    /** 小于0*/
    case lessThanZero = "<"
    /** 小于等于0*/
    case lessThanZeroOrEequal = "<="
    /** 获取数量*/
    case getCount = "getCount"
    /** 获取值*/
    case getValue = "getValue"
    /** 自增*/
    case increase = "increase"
    /** 移除*/
    case arrayRemove = "arrayRemove"
    /** 拼接*/
    case append = "append"
}


func handleOperator(operatorDesc: String?, args: [Any]) -> Any? {
    guard let operatorString = operatorDesc else {
        return nil
    }
    
    switch OperatorType.init(rawValue: operatorString) {
    case .moreThanZero:
        // 取args的第一个参数
        if let arg = args.first as? [Any] {
            return moreThanZero(arg: arg.count)
        } else if let arg = args.first as? String {
            return moreThanZero(arg: arg.count)
        }
        break
    case .lessThanZero:
        // 取args的第一个参数
        if let arg = args.first as? [Any] {
            return lessThanZero(arg: arg.count)
        } else if let arg = args.first as? String {
            return lessThanZero(arg: arg.count)
        }
        break
    case .lessThanZeroOrEequal:
        // 取args的第一个参数
        if let arg = args.first as? [Any] {
            return lessThanZeroOrEequal(arg: arg.count)
        } else if let arg = args.first as? String {
            return lessThanZeroOrEequal(arg: arg.count)
        }
        break
    case .getCount:
        if let arg = args.first {
            return getCount(arg: arg)
        }
    case .increase:
        if let arg = args.first as? Int {
            return increase(arg: arg )
        }
    case .arrayRemove:
        if let fArgs = args.first as? [Any], let lArgs = args[1] as? [Any], let key = args.last as? String {
            return arrayRemove(orgA: fArgs, rmvA: lArgs, key: key)
        }
    case .append:
        if let fArg = args.first, let lArg = args.last {
            return append(org: fArg, other: lArg)
        }
    case .getValue:
        if let arg = args.first {
            return getValue(arg: arg)
        }
    default:
        break
    }
    
    
    return nil
}




 // MARK: *************数值判断操作
/*************************************************************/

/// 自增
/// - Parameter arg: 自增参数
func increase(arg: Int) -> Int {
    return arg + 1
}

/// 递减
/// - Parameter arg: 递减参数
func decrease(arg: Int) -> Int {
    return arg - 1
}

/// 数值大于0
/// - Parameter arg: 参数
func moreThanZero(arg: Int) -> Bool {
    return arg > 0
}

/// 数值等于0
/// - Parameter arg: 参数
func equalZero(arg: Int) -> Bool {
    return arg == 0
}

/// 数值小于0
/// - Parameter arg: 参数
func lessThanZero(arg: Int) -> Bool {
    return arg < 0
}

/// 数值大于等于0
/// - Parameter arg: 参数
func moreThanZeroOrEqual(arg: Int) -> Bool {
    return arg >= 0
}

/// 数值小于等于0
/// - Parameter arg: 参数
func lessThanZeroOrEequal(arg: Int) -> Bool {
    return arg <= 0
}
/*************************************************************/


 // MARK: ***********字符串操作
/*************************************************************/


/// 拼接字符串
/// - Parameters:
///   - org: 源字符串
///   - appendS: 要拼接的字符串
func appendString(org: String, appendS: String) -> String {
    return org + appendS
}

func append(org: Any, other: Any) -> String? {
    var orgString: String? = nil
    if let s = org as? String {
        orgString = s
    } else if let s = org as? Int {
        orgString = "\(s)"
    }
    
    var otherString: String? = nil
    if let s = other as? String {
        otherString = s
    } else if let s = other as? Int {
        otherString = "\(s)"
    }
    
    if orgString != nil && otherString != nil {
        return orgString! + otherString!
    } else {
        print("*****: 拼接字符串错误的传参格式 *****")
    }
    
    return nil
}

/*************************************************************/

func getCount(arg: Any) -> Int? {
    if let stringValue = arg as? String {
        return stringValue.count
    } else if let arrayValue = arg as? [Any] {
        return arrayValue.count
    } else if let dicValue = arg as? [[String: Any]] {
        return dicValue.count
    }
    return nil
}

func getValue(arg: Any) -> Any {
    return arg
}
/*************************************************************/


 // MARK: 数组操作


/// 对象移除
func objRemove(orgA: [Any]?, rmvObj: Any, key: String) -> [Any]? {
    if let a = orgA as? [String], let keyS = rmvObj as? String { // 都是字符串类型
        return a.filter { (element) -> Bool in
            return !(element == keyS)
        }
    }
    
    if let a = orgA as? [Int], let keyI = rmvObj as? Int { // 都是整型
        return a.filter { (element) -> Bool in
            return !(element == keyI)
        }
    }
    
    if let a = orgA as? [[String: Any]], let keyI = rmvObj as? String {
        return a.filter { (element) -> Bool in
            return !((element[key] as? String) == keyI)
        }
    }
    
    if let a = orgA as? [[String: Any]], let keyI = rmvObj as? Int {
        return a.filter { (element) -> Bool in
            return !((element[key] as? Int) == keyI)
        }
    }
    
    return orgA
}

/// 通过数组移除元素
func arrayRemove(orgA: [Any]?, rmvA: [Any]?, key: String) -> [Any]? {
    if let a = orgA as? [String], let b = rmvA as? [String] { // 都是字符串类型
        return a.filter { (element) -> Bool in
            return !b.contains(element)
        }
    }
    
    if let a = orgA as? [Int], let b = rmvA as? [Int] { // 都是整型
        return a.filter { (element) -> Bool in
            return !b.contains(element)
        }
    }
    
    if let a = orgA as? [[String: Any]], let b = rmvA as? [String] {
        return a.filter { (element) -> Bool in
            return !b.contains(element[key] as! String)
        }
    }
    
    if let a = orgA as? [[String: Any]], let b = rmvA as? [Int] {
        return a.filter { (element) -> Bool in
            if let value = element[key] as? Int {
                return !b.contains(value)
            }
            return false
        }
    }
    
    return orgA
}
/*************************************************************/
