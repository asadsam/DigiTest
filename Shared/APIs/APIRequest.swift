//
//  APIRequest.swift
//  DigiTestApp
//
//  Created by Asadullah Jamadar on 11/12/2021.
//

import Foundation

class APIRequest {
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func perform<T: Decodable>(with completion: @escaping (T?, String?, Error?, Bool) -> Void) {
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: .main)
        let task = session.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completion(nil, "data not found", nil, false)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            do
            {
                let parsedData = try decoder.decode(T.self, from: data)
                completion(parsedData, "success", nil, true)
                
            }catch let error as NSError
            {
                print(error)
                completion(nil, "parsing error", error, false)
            }
        }
        task.resume()
    }
}
