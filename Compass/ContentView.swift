import Foundation
import SwiftUI


struct ContentView : View {
    @ObservedObject var currentLocation = Location()
    
    var body: some View {
        VStack {
  
            Text( currentLocation.location )

//            ZStack {
//                ForEach(Marker.markers(), id: \.self) { marker in
//                    CompassMarkerView(marker: marker,
//                                      compassDegress: self.compassHeading.degrees)
//                }
//            }
//            .frame(width: 300,
//                   height: 300)
//            .rotationEffect(Angle(degrees: self.compassHeading.degrees))
//            .statusBar(hidden: true)
        }
    }
}
