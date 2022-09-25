//
//  EventsResponseModel.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 23/09/22.
//

import Foundation

struct EventsResponseModel: Decodable {
    let errorMessage: String?
    let data: EventsDataModel?
}

struct EventsDataModel: Decodable {
    var _embedded: EventsListModel
}

struct EventsListModel: Decodable {
    var events: [EventModel]
}

struct EventModel: Decodable {
    var name: String
    var type: String
    var images: [Imagemodel]
    var dates: StartDate
}

struct Imagemodel: Decodable {
    var url: String
}

struct StartDate: Decodable {
    var start: DateModel
}

struct DateModel: Decodable {
    var localDate: String
}

