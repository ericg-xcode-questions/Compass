import Foundation
import SwiftUI


struct ContentView : View {
    @ObservedObject var currentLocation = Location()
    
    var body: some View {
        VStack {
  
            Text( currentLocation.location )            
        }
    }
}
