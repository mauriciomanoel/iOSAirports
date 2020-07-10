//
//  Router.swift
//  Airports
//
//  Created by Mauricio on 6/18/20.
//  Copyright © 2020 Mauricio. All rights reserved.
//

import Foundation

public protocol NetworkRouter {
    associatedtype EndPoint : EndPointType
    func request(_ route: EndPoint, completion: @escaping (_ data: Data?,_ response: URLResponse?,_ error: Error?)->())
}

public class Router<EndPoint : EndPointType> : NetworkRouter{
    private var task : URLSessionTask?
    
    public init() {}
    
    public func request(_ route: EndPoint, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        let session = URLSession.shared
        do{
            let request = try self.buildRequestApi(url: route)
            if let body = request.httpBody{
                print("📤 URL => \(String(describing: request.url!)) \n \(String(describing: String(data: body, encoding: .utf8) ?? ""))")
            }else{
                 print("📤 URL => \(String(describing: request.url!))")
            }
            task = session.dataTask(with: request, completionHandler: { (data, response, erro) in
                if erro != nil{
                        print("📥 ❌ URL => \(String(describing: (erro?.localizedDescription)!))")
                    completion(nil,nil,erro)
                }else{
                    print("📥 ✅ URL => \(String(describing: String(data: data!, encoding: .utf8)!))")
                    completion(data, response, erro)
                }
            })
        }catch{
            print("📥 ❌ URL => \(String(describing: error.localizedDescription))")
            completion(nil,nil,error)
        }
        
        self.task?.resume()
    }
    
    fileprivate func buildRequestApi( url : EndPoint) throws -> URLRequest{

        switch url.task {
            
        case .request(let data, let query, let headers):
            
           var component = URLComponents(url: url.completeURL , resolvingAgainstBaseURL: false)
           
           if (query.count > 0) {
               var itemQuery = [URLQueryItem]()
               for (key, value) in query {
                   itemQuery.append(URLQueryItem(name: key, value: value))
               }
               component?.queryItems = itemQuery
            }
           
           var urlRequest = URLRequest(url: (component?.url)!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 15.0)
           urlRequest.httpBody = data
           urlRequest.httpMethod = url.httpMethod.rawValue
           
           if (headers.count > 0) {
              for (key, value) in headers {
                  urlRequest.setValue(value, forHTTPHeaderField: key)
              }
           }

           return urlRequest
        }
    }
}

