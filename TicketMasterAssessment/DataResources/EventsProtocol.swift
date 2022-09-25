//
//  EventsProtocol.swift
//  TicketMasterAssessment
//
//  Created by Anil Persaud on 25/09/22.
//

import Foundation

protocol EventsProtocol {
    func eventsList<T: Decodable>(_ resultType: T.Type, completion : @escaping (_ result: EventsDataModel?, Error?) -> Void)
}
