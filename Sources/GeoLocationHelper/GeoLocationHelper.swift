import CoreLocation
public class GeoLocationHelper {
    
    public init() {}
    
    private var locale: Locale {
        return Locale.current
    }
    
    private var formatedString: String = "Adress Not Found"
    
    let geocoder = CLGeocoder()
    
    func getFormatedAdress(_ street: String,
                            _ postalCode: String,
                            _ locality: String,
                            _ state: String,
                            _ countryCode: String) -> String {
        
        var postalCodeLocality: String
        if countryCode == "US" {
            postalCodeLocality = "\(locality), \(state) \(postalCode)"
        } else if countryCode == "CA" {
            postalCodeLocality = "\(locality), \(state) \(postalCode)"
        } else {
            postalCodeLocality = "\(locality), \(postalCode), \(state)"
        }
        return postalCodeLocality
    }
    
    public func getLocationString(_ location: CLLocation, completion: @escaping (String) -> Void) {
        var postalCodeLocality: String?
        
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("error in reverseGeocode: \(error.localizedDescription)")
                completion("Adress Not Found")
                return
            }
            
            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion("Adress Not Found")
                return
            }
            
            if placemark.isoCountryCode == "US" {
                postalCodeLocality = "\(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")"
            } else if placemark.isoCountryCode == "CA" {
                postalCodeLocality = "\(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")"
            } else {
                postalCodeLocality = "\(placemark.locality ?? ""), \(placemark.postalCode ?? ""), \(placemark.administrativeArea ?? "")"
            }
            
            completion(postalCodeLocality!)
        }
    }

    
}
