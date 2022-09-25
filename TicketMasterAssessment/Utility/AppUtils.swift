//
//  AppUtils.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 25/09/22.
//

import Foundation

class AppUtils {
    class func readJSONFromFile<T: Decodable>(fileName: String, resultType: T.Type) -> T?
    {
        var result: T?
        if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
            do {
                let fileUrl = URL(fileURLWithPath: path)
                // Getting data from JSON file using the file URL
                let responseData = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                result = try decoder.decode(T.self, from: responseData)
            } catch {}
        }
        return result
    }
}
