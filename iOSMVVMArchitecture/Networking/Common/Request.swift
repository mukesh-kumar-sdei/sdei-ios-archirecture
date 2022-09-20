//
//  Request.swift
//  iOSMVVMArchitecture
//
//  Created by Amit Shukla on 22/01/20.
//  Copyright © 2020 smartData Enterprises (I) Ltd. All rights reserved.
//

import Foundation


public typealias ResponseHandler = (Result<Any?>) -> Void

public enum Result <T>{
    case Success(T)
    case Error(ErrorResult)
}

protocol ResponseProtocol {
    
    // MARK: - Parameters
    var urlRequest:URLRequest? {get}
    
    // MARK: - Required method
    init(with request:URLRequest?)
    
    // MARK: - Helper methods
    func headers(_ headers: HTTPHeaders?) -> Self
    func authenticate(_ token: String) -> Self
    func response(completion: @escaping (Result<Any?>) -> Void) -> Void
    func responseDecodable<T: Decodable>(decodingType: T.Type, completion: @escaping (Result<T>) -> Void) -> Void
}

public class Request:ResponseProtocol {
    
    var urlRequest:URLRequest?
    
    required init(with request:URLRequest?) {
        self.urlRequest = request
    }
    
    /// Add headers in request.
    /// - Parameter headers: `HTTPHeaders`
    /// - Returns:          Self
    
    public func headers(_ headers: HTTPHeaders?) -> Self {
        self.urlRequest?.allHTTPHeaderFields = headers
        return self
    }
    
    /// Add authentication token in request.
    /// - Parameter token: `String`
    /// - Returns:          Self
    public func authenticate(_ token: String) -> Self {
        self.urlRequest?.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        return self
    }
    
    
    /// Add parameters in request with encoding.
    /// - Parameter parameters: `Parameters`,
    /// - Parameter encoder: `URLEncoding`,
    /// - Returns:          Self
    func parameters(_ parameters: Parameters? = nil,
                           _ encoder:ParameterEncoding = URLEncoding.default) -> Self {
        if var request = urlRequest,
            let params = parameters, !params.isEmpty {
            // Encode parameters based on encoder
            do { try encoder.encode(&request, with: params) } catch {}
        }
        return self
    }
    
    private func perform(completion: @escaping (Data?, ErrorResult?) -> Void) {
        
        guard let request = urlRequest else {
            return completion(nil, ErrorResult.missingURL)
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60.0
        
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(nil, .networkError)
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                guard let data = data else {
                    return completion(nil, .invalidData)
                }
                completion(data,nil)
                
            default:
                return completion(nil, .responseFailed)
            }
        }
        task.resume()
    }
    
    // Process request and send response in completionhandler.
    /// - Parameter completion: `Result<Any?>) -> Void`
    /// - Returns:          No return type
     public func response(completion: @escaping (Result<Any?>) -> Void) -> Void {
        
         self.perform { (data, error) in
             
             if let error = error {
                 completion(.Error(error))
             } else {
                 do {
                     let json = try JSONSerialization.jsonObject(with: data!, options: [])
                     completion(.Success(json))
                     
                 } catch { completion(.Error(.jsonConversionFailure)) }
             }
             
         }
         
     }
    
    /// Process request and send response in decodable formate to completionhandler.
    // - Parameter completion: `Result<T>) -> Void`
    /// - Returns:          No return type
    public func responseDecodable<T: Decodable>(decodingType: T.Type,
                                                    completion: @escaping (Result<T>) -> Void) -> Void {
           
           self.perform { (data, error) in
            
            if let error = error {
                completion(.Error(error))
            } else {
                do {
                    let model = try JSONDecoder().decode(decodingType, from: data!)
                    completion(.Success(model))
                } catch {
                    completion(.Error(.jsonConversionFailure))
                }
            }
        }
    }
    
}

