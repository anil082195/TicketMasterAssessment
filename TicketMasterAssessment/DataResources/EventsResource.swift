//
//  EventsResource.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 23/09/22.
//

import Foundation

struct EventsResource: EventsProtocol {
    func eventsList<T: Decodable>(_ resultType: T.Type, completion : @escaping (_ result: EventsDataModel?, Error?) -> Void) {
        guard let eventUrl = URL(string: String(format: ApiEndpoints.eventsList, Constants.API_KEY)) else { return }
        let httpUtility = HttpUtility()
            httpUtility.getApiData(requestUrl: eventUrl, resultType: resultType) { (eventApiResponse, error) in
                if let eventApiResponse = eventApiResponse {
                    _ = completion(eventApiResponse as? EventsDataModel, nil)
                } else {
                    _ = completion(nil, error)
                }
                
        }
    }
}
