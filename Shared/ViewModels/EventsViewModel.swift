//
//  EventsViewModel.swift
//  DigiTestApp
//
//  Created by Asadullah Jamadar on 11/12/2021.
//

import Foundation
import UIKit

class EventsViewModel: ObservableObject {
    @Published var events = [Event]()
    
    @Published var errorOccurred: Bool = false

    @Published var errorMsg: String = "some error occurred"
    
    func fetchEvents() {
        guard let url = URL(string: APIConstants.EventsReqUrl)
        else {
                print("Invalid events url...")
                errorOccurred = true
                return
        }

        let request = APIRequest(url: url)
 
        request.perform { [weak self] (root: RootEvent?, msg, err, success ) in
            
            self?.events.removeAll()
            
            if success {
                if let rootEvents = root?.events{
                    self?.events = rootEvents
                }
                else {
                   print("no events")
                }
            }
            else {
                self?.errorMsg = msg ?? "some error occurred"
            }
                
            self?.errorOccurred = !success
        }
    }
}
