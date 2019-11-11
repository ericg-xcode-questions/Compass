import Foundation
import Combine
import CoreLocation

class Location: NSObject, ObservableObject, CLLocationManagerDelegate
{
    var objectWillChange = PassthroughSubject<String, Never>()
    
    @Published var location: String = "" {
        didSet {
            objectWillChange.send( location )
        }
    }
    
    @Published var occasionalLocation: String = ""
    
    private let locationManager: CLLocationManager
    
    override init() {
        self.locationManager = CLLocationManager()
        super.init()
        
        self.locationManager.delegate = self
        self.setup()
    }
  
    private var occasionalLocationCancellable: Cancellable? {
        didSet {
            oldValue?.cancel()
        }
    }
    
    deinit {
        occasionalLocationCancellable?.cancel()
    }
    
    private func setup() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        occasionalLocationCancellable = self.objectWillChange
                                                .debounce(for: .seconds( 2 ), scheduler: DispatchQueue.main)
                                                .sink(receiveValue: { (location) in
                                                    print( "Received: \(location)" )
                                                })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let currentLocation = locations.last!
        let now             = Date().description
        
        self.location = "\(now): \(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)"
    }
}
