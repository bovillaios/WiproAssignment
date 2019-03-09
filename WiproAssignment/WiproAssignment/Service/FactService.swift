//
//  Fact.swift
//  iOS
//
//  Created by GGKU5MACBOOK003 on 09/03/19.
//  Copyright © 2019 Ramgopal. All rights reserved.
//

import Foundation
import Alamofire

class FactService {
    
    static func fetchFactData(completionHandler: @escaping(_ sucess: Bool, _ factData: Fact?) -> Void) {
        Alamofire.request("https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json").validate().responseData { (dataResponse) in
            guard dataResponse.result.isSuccess else {
                
                completionHandler(false, nil)
                return
            }
            
            guard let data = dataResponse.data else {
                
                completionHandler(false, nil)
                return
            }
            
            guard let dataString = String(data: data, encoding: String.Encoding.isoLatin1) else {
                
                completionHandler(false, nil)
                return
            }

            guard let utf8Data = dataString.data(using: .utf8) else {
                
                completionHandler(false, nil)
                return
            }
            
            do {
                var fact = try JSONDecoder().decode(Fact.self, from: utf8Data)
                fact.rows = fact.rows.filter({!($0.title == nil && $0.description == nil && $0.imageHref == nil)})
                completionHandler(true, fact)
                return
            } catch {
                completionHandler(false, nil)
                return
            }
        }
    }
}
