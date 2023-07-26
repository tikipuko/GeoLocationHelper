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
    
    public func getLocationString(_ location: CLLocation, completion: @escaping (String?) -> Void) {
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                print("Error in reverseGeocode: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let placemark = placemarks?.first else {
                print("No placemark found")
                completion(nil)
                return
            }

            let postalCodeLocality: String
            if placemark.isoCountryCode == "US" || placemark.isoCountryCode == "CA" {
                postalCodeLocality = "\(placemark.locality ?? ""), \(placemark.administrativeArea ?? "") \(placemark.postalCode ?? "")"
            } else {
                postalCodeLocality = "\(placemark.locality ?? ""), \(placemark.postalCode ?? ""), \(placemark.administrativeArea ?? "")"
            }

            completion(postalCodeLocality)
        }
    }


    
}
