//
//  Constants.swift
//  DigiTestApp
//
//  Created by Asadullah Jamadar on 11/12/2021.
//

import Foundation

enum APIConstants {
     static let BaseUrl: String = "https://api.seatgeek.com"
     static let ClientID: String = "MjQ4NzE1MzN8MTYzOTE0MTkyOC4wOTQwNzY0"
    
     static let BaseEventsUrl: String = String(format: "%@/2/events?client_id=%@&q=",BaseUrl, ClientID)

     static let EventsReqUrl: String = String(format: "%@%@",BaseEventsUrl, "Texas+Ranger") //"https://api.seatgeek.com/2/events?client_id=MjQ4NzE1MzN8MTYzOTE0MTkyOC4wOTQwNzY0&q=Texas+Ranger"
}

