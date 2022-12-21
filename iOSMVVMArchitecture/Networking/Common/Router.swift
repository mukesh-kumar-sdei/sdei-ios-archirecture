//
//  Router.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 14/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation
import UIKit

extension String {
    var nsdata: Data {
        return self.data(using: String.Encoding.utf8, allowLossyConversion: false)!
    }
}

extension Date {
    var unixTime:String {
        let timestamp = self.timeIntervalSince1970
        return String(timestamp)
    }
}


public struct Router {

    /// Create Request object for processing response.
    ///
    /// - Parameters:
    ///   - url:         url of request
    ///   - method:      http request method .
    ///   - parameters:  parameter of request .
    ///   - encoder:     type of encoding  URLEncoding/JSONEncoding.
    ///
    /// - Returns: Request object.
    
    public static func data(_ endpoint: Endpoints,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoder:ParameterEncoding = URLEncoding.default) -> Request {
        
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        
        // Cerate request object
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.name
        
        
        if let params = parameters, !params.isEmpty {
            // Encode parameters based on encoder
            do { try encoder.encode(&urlRequest, with: params) } catch {}
        }
        

        return Request(with: urlRequest)
        
    }
    
    /// Create Request object for uploading files over server.
    ///
    /// - Parameters:
    ///   - path:       url of request
    ///   - method:     http request method .
    ///
    /// - Returns: Request object.
    public static func upload(_ endpoint: Endpoints,
                              filename: String,
                              name:String,
                              data:Data? = nil,
                              parameters: Parameters? = nil) -> Request {
        
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        
        // Cerate request object
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        let boundary = "Boundary-\(UUID().uuidString)"
        let boundaryPrefix = "--\(boundary)\r\n"
        let boundarySuffix = "--\(boundary)--\r\n"
        urlRequest.addValue("multipart/form-data; boundary=" + boundary, forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        if let params = parameters,params.count > 0{
            for (key, value) in params {
                body.append("--\(boundary)\r\n".nsdata)
                body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".nsdata)
                body.append("\((value as AnyObject).description ?? "")\r\n".nsdata)
            }
        }
        
        body.append(boundaryPrefix.nsdata)
        body.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(NSString(string: filename))\"\r\n\r\n".nsdata)
        let mimeType = "image/jpeg"
        body.append("Content-Type: \(mimeType)\r\n\r\n".nsdata)
        if let data = data {
            body.append(data)
            body.append("\r\n".nsdata)
        }
        body.append(boundarySuffix.nsdata)
        urlRequest.httpBody = body as Data
            
        return Request(with: urlRequest)
        
    }
}
