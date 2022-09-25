//
//  EventsViewModel.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 9/23/22.
//

import Foundation

protocol EventsViewModelDelegate {
    func didReceiveEventsResponse(_ eventsResponse: EventsResponseModel)
}

struct EventViewModel {
    var delegate : EventsViewModelDelegate?
    
    func getEventsList() {
        let eventResource = EventsResource()
        eventResource.eventsList(EventsDataModel.self) { (eventApiResponse, error) in
            if let eventApiResponse = eventApiResponse {
                let eventResponseModel = EventsResponseModel(errorMessage: nil, data: eventApiResponse)
                self.delegate?.didReceiveEventsResponse(eventResponseModel)
            } else {
                self.delegate?.didReceiveEventsResponse(EventsResponseModel(errorMessage: error.debugDescription, data: nil))
            }
        }
    }
}


