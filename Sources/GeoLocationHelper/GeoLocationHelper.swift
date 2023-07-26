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
    
    public func getLocationString(_ location: CLLocation) -> String {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            
            if placemark.count>0 {
                let placemark = placemarks![0]

                self.formatedString = self.getFormatedAdress(placemark.subLocality!, placemark.postalCode!, placemark.locality!, placemark.administrativeArea!, placemark.isoCountryCode!)
                
            }
        }
        return formatedString
    }
    
}
