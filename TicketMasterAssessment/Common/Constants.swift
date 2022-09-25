//
//  Constants.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 23/09/22.
//

import Foundation

struct Constants {
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
    static let API_KEY = "DW0E98NrxUIfDDtNN7ijruVSm60ryFLX"
}

struct ApiEndpoints
{
    static let eventsList = "https://app.ticketmaster.com/discovery/v2/events.json?dmaId=324&apikey=%@"
}

struct CollectionViewCells {
    static let eventCollectionCellIdentifier = "EventCollectionViewCell"
}
