//
//  EventDetailsView.swift
//
//
//

import SwiftUI
import SDWebImageSwiftUI

struct EventDetailsView: View {
    
    // 
    let event: Event
    
    // environmentobject used, to reuse the same instance amongst different views throughout the app
    @EnvironmentObject var favoriteEvents : FavoriteEvents
    
    var body: some View {
        VStack() {
            Divider()
            WebImage(url: URL(string: event.performers?[0].image ?? ""))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(10)
                .padding(.top)
                .padding(.bottom)

            Text(event.datetimeUTC?.fromUTCToLocalDateTime() ?? "")
                .fontWeight(.heavy)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 4)

            Text(String(format: "%@, %@, %@", event.venue?.address ?? "", event.venue?.state ?? "", event.venue?.city ?? ""))
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)

            Spacer()

        }.padding()

            .navigationBarTitle(Text(event.title ?? ""), displayMode: .inline)

            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if self.favoriteEvents.contains(event) {
                            self.favoriteEvents.remove(event)
                        } else {
                            self.favoriteEvents.add(event)
                        }
                    }) {
                        HStack {
                            Image(systemName: favoriteEvents.contains(event) ? "heart.fill" : "heart").foregroundColor(favoriteEvents.contains(event) ? .red : .white)
                                .shadow(color: .red, radius: 2)
                        }
                    }
                }
            }
    }
}

//struct EventDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        EventDetailsView(event: Event(from: <#Decoder#>), favoriteEvents: FavoriteEvents())
//    }
//}
