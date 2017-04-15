//
//  API.swift
//  handwriting
//
//  Created by Flavien SICARD on 13/04/2017.
//  Copyright © 2017 Flavien SICARD. All rights reserved.
//

import Foundation
import Alamofire

protocol APIProtocol {
    var Request: API.request { get }
}

class API: NSObject {
    
    private let url: String = "https://api.handwriting.io"
    private let headers = ["Content-Type": "application/json; charset=utf-8"]
    
    struct request {
        var url: String
        var method: HTTPMethod
    }
    
    private func valueForAPIKey(named keyname:String) -> String {
        let filePath = Bundle.main.path(forResource: "ApiKeys", ofType: "plist")
        let plist = NSDictionary(contentsOfFile:filePath!)
        let value = plist?.object(forKey: keyname) as! String
        return value
    }
    
    public func req(_ Req: requestEnum,
                    params: [String: String]? = nil,
                    completion: @escaping (_ success: Bool, _ data: Data?) -> ()) {
        Alamofire.request(
            url + Req.Request.url,
            method: Req.Request.method,
            parameters: params,
            headers: headers)
            .authenticate(user: self.valueForAPIKey(named: "API_HANDWRITING_TOKEN"), password: self.valueForAPIKey(named: "API_HANDWRITING_SECRET"))
            .response { response in
                switch response.response?.statusCode ?? 404 {
                case 200..<300:
                    completion(true, response.data)
                case 400..<500:
                    completion(false, response.data)
                default:
                    break
                }
        }
    }
    
    public enum requestEnum : APIProtocol {
        case getHandwritings
        case getHandwritingsId(id: String);
        case getRenderPNG;
        case getRenderPDF;

        var Request : request {
            switch self {
            case .getHandwritings:
                return request(url: "/handwritings", method: .get)
            case .getHandwritingsId(let id):
                return request(url: "/handwritings/\(id)", method: .get)
            case .getRenderPNG():
                return request(url: "/render/png", method: .get)
            case .getRenderPDF():
                return request(url: "/render/pdf", method: .get)
            }
        }
    }
    
}
