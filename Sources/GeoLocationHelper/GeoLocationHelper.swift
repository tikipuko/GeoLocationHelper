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
    
    public func getCurrentAddress(_ coordinates: CLLocation, completion: @escaping (String?, Error?) -> Void) {
        geocoder.reverseGeocodeLocation(coordinates) { placemarks, error in

            guard error == nil else {
                completion(nil, error)
                return
            }
            
            guard let placemark = placemarks?.first else {
                completion(nil, nil)
                return
            }
                        
            if (placemark.isoCountryCode == "US" || placemark.isoCountryCode == "CA") {
                completion("\(placemark.subLocality ?? ""), \(placemark.locality ?? ""), \(placemark.postalCode ?? "")", nil)
            } else {
                completion("\(placemark.subLocality ?? ""), \(placemark.postalCode ?? ""), \(placemark.locality ?? "")", nil)
            }
        }
    }
}
