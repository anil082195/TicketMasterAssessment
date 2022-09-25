//
//  MockEventsHttpClient.swift
//  TicketMasterAssessmentTests
//
//  Created by Anil Persaud on 25/09/22.
//

import Foundation
@testable import TicketMasterAssessment

class MockEventsHttpClient {
    var shouldReturnError = false
    var eventsListApiCalled = false
    
    enum MockServiceError: Error {
        case eventsList
    }
    
    func reset() {
        shouldReturnError = false
        eventsListApiCalled = false
    }
    
    convenience init() {
        self.init(false)
    }
    
    init(_ shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
}

extension MockEventsHttpClient: EventsProtocol {
    func eventsList<T: Decodable>(_ resultType: T.Type, completion : @escaping (_ result: EventsDataModel?, Error?) -> Void) {
        eventsListApiCalled = true
        
        if shouldReturnError {
            completion(nil, MockServiceError.eventsList)
        } else {
            let eventsListResponse = AppUtils.readJSONFromFile(fileName: "Events", resultType: resultType) as? EventsDataModel
            completion(eventsListResponse, nil)
        }
    }
}
