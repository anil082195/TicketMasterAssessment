//
//  TicketMasterAssessmentTests.swift
//  TicketMasterAssessmentTests
//
//  Created by Anil Persaud on 25/09/22.
//

import XCTest
@testable import TicketMasterAssessment

class TicketMasterAssessmentTests: XCTestCase {
    
    let mockEventsHttpClient = MockEventsHttpClient()
   
    func testEventsListResponse() {
        let expectation = self.expectation(description: "EventsList Response parse exception")
        mockEventsHttpClient.eventsList(EventsDataModel.self) { (eventsListResponse, error) in
            XCTAssertNil(error)
            guard let eventsListResponse = eventsListResponse else {
                XCTFail()
                return
            }
            XCTAssertNotNil(eventsListResponse)
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }

}
