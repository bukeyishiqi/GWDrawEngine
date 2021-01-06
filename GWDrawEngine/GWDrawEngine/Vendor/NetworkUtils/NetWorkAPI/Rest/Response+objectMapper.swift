//
//  Response+objectMapper.swift
//  icar
//
//  Created by 陈琪 on 2019/12/16.
//  Copyright © 2019 Carisok. All rights reserved.
//

import Foundation



//public extension FCApiResponse {
//    
//    func mapObject<T: ModelSerializable>(_ type: T.Type) throws -> T {
//        
//        let data = self.responseData
//        guard let rawData = data,  let obj = type.apiToObj(data: rawData)  else {
//            print("***转换对象\(type)出错***")
//            throw RestError.jsonMapping(self)
//        }
//        return obj
//    }
//    
//    func mapArray<T: ModelSerializable>(_ type: T.Type, for key: String? = nil) throws -> [T] {
//        
//        if let mapKey = key {
//            if let data = OYUtils.jsonDctionary(data: self.responseData as Any) {
//                if let dataJson = data["data"], let list = dataJson.dictionary?[mapKey] {
//                    if let rawData = try? list.rawData(), let rawList = type.apiToArrayObj(data: rawData)  {
//                        return rawList
//                    }
//                }
//            }
//            print("***转换对象数组【\(type)】出错***")
//            throw RestError.jsonMapping(self)
//            
//        } else {
////            let data = self.responseData
//            guard let rawData = try? OYUtils.jsonDctionary(data: self.responseData as Any)?["data"]?.rawData(),  let list = type.apiToArrayObj(data: rawData)  else {
//                print("***转换对象数组【\(type)】出错***")
//                throw RestError.jsonMapping(self)
//            }
//            return list
//        }
//    }
//
//    func mapJSON() -> Any {
//        return OYUtils.jsonDctionary(data: self.responseData as Any) as Any
//    }
//}



//extension ObservableType where Element: FCApiResponse {
//
//    public func mapJSON() -> RxSwift.Observable<Any> {
//        return  flatMapLatest { (response) -> Observable<Any> in
//
//            return Observable.just(response.mapJSON())
//        }
//    }
//
//    public func mapObject<T>(_ type: T.Type) -> RxSwift.Observable<T> where T : ModelSerializable {
//
//        return  flatMapLatest { (response) -> Observable<T> in
//
//            return Observable.just(try response.mapObject(type))
//        }
//    }
//
//    public func mapArray<T>(_ type: T.Type, for key: String? = nil) -> RxSwift.Observable<[T]> where T : ModelSerializable {
//
//        return  flatMapLatest { (response) -> Observable<[T]> in
//
//            return Observable.just(try response.mapArray(type, for: key))
//        }
//    }

    
//    public func rxRequestApiForObj<T: ModelSerializable>(_ type: T.Type) -> Observable<Result<T, BSError>> {
//
//        return flatMapLatest { (response) -> Observable<Result<T, BSError>> in
//            return FCNetWorkService.share.request(response)
//                .observeOn(MainScheduler.instance)
//                .map {
//                    type.apiToObj(data: $0.responseData())
//                }
//            .compactMap({
//                Result.success($0!)
//            }).catchError({ (error) in
//
//                return Observable.just(Result.failure(BSError.businessError(code: 99, message: error.localizedDescription)))
//            })
//        }
//
//    }
//}
