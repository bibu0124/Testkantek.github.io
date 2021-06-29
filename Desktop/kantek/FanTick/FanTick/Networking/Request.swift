//
//  RequestService.swift
//  Kiple
//
//  Created by TVT on 8/9/17.
//  Copyright © 2017 com.futurify.vn. All rights reserved.
//

import Foundation
import Alamofire
import NVActivityIndicatorView
import Codextended

typealias CompleteHandleJSONCode = (_ isSuccess: Bool, _ json: Any?, _ statusCode: Int?)->()
var isShowAlert = false

class Connectivity {
    class func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}


struct RequestService {
    
    static let shared = RequestService()
    fileprivate init() {}
    let activityIndicatorView = NVActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: SCREEN_HEIGHT), type: .ballScale, color: .lightGray, padding: 0)

    
    func requestWith<T: Codable>(_ url: String,_ method: HTTPMethod, _ parameters: [String: Any]?,_ header: HTTPHeaders?, objectType: T.Type,  encoding: ParameterEncoding? = URLEncoding.default, _ animated : Bool = true,_ complete: @escaping ( _ model: Any?)->()) {
        SHARE_APPLICATION_DELEGATE.window?.rootViewController?.view.addSubview(activityIndicatorView)
        
        if !Connectivity.isConnectedToInternet() {
            print("!Connectivity.isConnectedToInternet")
            
            if !isShowAlert {
                isShowAlert = true
                //                let alert = CommonAlert.instanceFromNib()
                //                alert.show(title: "Thông báo", desc: "Bạn đã mất kết nối với internet, vui lòng thử lại sau", dissmissTitle: "Đóng") {
                //                    isShowAlert = false
                //                }
            }
            
            complete(nil)
            
            
        } else {
            var headers = header
            let token = Token()
            if token.tokenExists {
                headers = [
                    "authorization": "Bearer \(token.token ?? "")",
//                    "Content-Type": "x-www-form-urlencoded"
                ]
            }else {
                headers = [
//                    "Content-Type": "x-www-form-urlencoded"
                ]
            }
            if animated {
                DispatchQueue.main.async {
                    self.activityIndicatorView.startAnimating()
                }
            }
          
            AF.request(url, method: method, parameters: parameters, encoding: encoding! , headers: headers).validate(statusCode: 200..<300).responseJSON { response in
                print("URL: \(url)")
                print("METHOD: \(method.rawValue)" )
                print("PRAM: \(parameters ?? [:])")
                print("HEADER: \(headers ?? [:] )")
                print("STATUS_CODE: \(response.response?.statusCode ?? 0)")
                self.response(objectType, response) { (data) in
                    complete(data)
                }
            }
        }
    }
    
    func response<T: Codable>(_ objectType: T.Type,_ response: AFDataResponse<Any>,_ complete: @escaping (_ model: Any?)->()) {
        self.activityIndicatorView.stopAnimating()
        self.handleStatusCode(statusCode: response.response?.statusCode ?? 0)
        switch response.result {
        case let .success(value):
            print("RESPONE: \(value)")
            guard let json = value as? [String : Any] else {
                complete(nil)
                return
            }
            if let model = json.toCodableObject() as T? {
                complete(model)
            } else {
                complete(json)
            }
            
        case let .failure(error):
            print("RESPONE: \(error)")
            complete(nil)
        }
    }
    
    func upload<T: Codable>(_ url: String,_ method: HTTPMethod, _ parameters: [String: Any]?,_ header: HTTPHeaders?, objectType: T.Type, dataImages: [Dictionary<String, Any>]?, _ complete: @escaping CompleteHandleJSONCode) {
        var headers = header
        let token = Token()
        if token.tokenExists {
            headers = [
                "authorization": "Bearer \(token.token ?? "")",
            ]
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let encode = "\(value)".data(using: String.Encoding.utf8) {
                        multipartFormData.append(encode, withName: key)
                    }
                }
            }
            if let dataImages = dataImages {
                for dict in dataImages {
                    guard let data: Data = dict["value"] as? Data, let key: String = dict["key"] as? String else {return}
                    multipartFormData.append(data, withName: key, fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpeg")
                }
            }
        }, to: url).responseJSON { response in
            print("URL: \(url)")
            print("METHOD: \(method.rawValue)" )
            print("PRAM: \(parameters ?? [:])")
            print("HEADER: \(headers ?? [:] )")
            self.response(objectType, response) { (data) in
                complete(true, data, response.response?.statusCode)
            }
        }
    }
    
    func handleStatusCode(statusCode : Int?) {
        switch statusCode {
        case 401:
            if Token().tokenExists {
                Token().clear()
                
                Utils.shared.gotoLogin()
                
            }
        default:
            break
        }
    }
}

extension Dictionary {
    func toCodableObject<T: Codable>() -> T? {
        
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted) {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .useDefaultKeys
            if let obj = try? decoder.decode(T.self, from: jsonData) {
                return obj
            }
            return nil
        }
        return nil
    }
    
}

extension Data {
    func toCodableObject<T: Codable>() -> T? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .useDefaultKeys
        if let obj = try? decoder.decode(T.self, from: self) {
            return obj
        }
        return nil    }
    
}
