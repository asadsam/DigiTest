//
//  EventsView.swift
//  Shared
//
//  Created by Asadullah Jamadar on 10/12/2021.
//

import SwiftUI
import SDWebImageSwiftUI

struct EventsView: View {
    
    @State private var searchTerm : String = ""

    @StateObject private var model = EventsViewModel()

    @StateObject var favoriteEvents = FavoriteEvents()
    
    var body: some View {
        
        ZStack {
            NavigationView {
                List {
                    SearchBar(text: $searchTerm)
                    
                    ForEach(self.model.events.filter {
                        self.searchTerm.isEmpty ? true : $0.title?.localizedStandardContains(self.searchTerm) ?? false
                    }) { event in
                        
                        EventCell(event: event)
                    }
                }
                .listStyle(.plain)
                
                .navigationBarTitle(Text("Events"))
            }
            .environmentObject(favoriteEvents)
        }
        .onAppear(perform: model.fetchEvents)
        .alert(isPresented: $model.errorOccurred) {
            Alert(title: Text("Error!"), message: Text(model.errorMsg), dismissButton: .default(Text("OK")))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EventsView()
            .previewDevice("iPhone 11 Pro Max")
    }
}

struct EventCell: View {
    
    // dependency injected - to be sure to get correct event struct
    let event: Event

    // environmentobject used, to reuse the same instance amongst different views throughout the app
    @EnvironmentObject var favoriteEvents : FavoriteEvents

    var body: some View {
        return NavigationLink(destination: EventDetailsView(event: event)) {
            HStack {
                
                ZStack(alignment: .leading) {
                    
                    WebImage(url: URL(string: event.performers?[0].image ?? ""))
                               .resizable()
                               .frame(width: 60, height: 60)
                               .aspectRatio(contentMode: .fit)
                               .cornerRadius(6)
                    
                    Button(action: {
                        if self.favoriteEvents.contains(event) {
                            self.favoriteEvents.remove(event)
                        } else {
                            self.favoriteEvents.add(event)
                        }
                    }) {
                        HStack {
                            Image(systemName: favoriteEvents.contains(event) ? "heart.fill" : "heart").foregroundColor(favoriteEvents.contains(event) ? .red : .clear)
                                .shadow(color: .white, radius: 4)
                        }
                    }
                    .offset(x: -8, y: -26)

                }
                

                VStack(alignment: .leading) {
                    Text(event.title ?? "")
                        .font(.system(size: 16, weight: .bold))
                        .lineLimit(1)
                        .padding(.bottom, 1)
                    Text(String(format: "%@, %@", event.venue?.city ?? "", event.venue?.state ?? ""))
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                        .padding(.bottom, 1)
                    Text(event.datetimeUTC?.fromUTCToLocalDateTime() ?? "")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(.gray)
                }
                .padding(.leading)
            }
        }
    }
}
