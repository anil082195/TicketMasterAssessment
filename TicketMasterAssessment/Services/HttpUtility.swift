//
//  HttpUtility.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 23/09/22.
//

import Foundation

struct HttpUtility
{
    func getApiData<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler:@escaping(_ result: T?, Error?)-> Void)
    {
        URLSession.shared.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            if(error == nil && responseData != nil && responseData?.count != 0)
            {
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(T.self, from: responseData!)
                    _=completionHandler(result, nil)
                }
                catch let error {
                    _=completionHandler(nil, error)
                }
            }

        }.resume()
    }
}
