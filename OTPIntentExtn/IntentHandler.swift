//
//  IntentHandler.swift
//  OTPIntentExtn
//
//  Created by Azhagusundaram Tamil on 27/10/20.
//

import Intents

class IntentHandler: INExtension {
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        return self
    }
}
//


extension IntentHandler: SelectOTPIntentHandling {
    func provideOtp1OptionsCollection(for intent: SelectOTPIntent, with completion: @escaping (INObjectCollection<OTPValue>?, Error?) -> Void) {
        
        print(intent.otp1)
        
        completion(INObjectCollection(items: getItems()), nil)
    }

    func confirm(intent: SelectOTPIntent, completion: @escaping (SelectOTPIntentResponse) -> Void) {
        
        completion(SelectOTPIntentResponse())
        
        print("Confirm method called")
    }
    
    func handle(intent: SelectOTPIntent, completion: @escaping (SelectOTPIntentResponse) -> Void) {
        completion(SelectOTPIntentResponse())
        
        print("Handle method called")
    }
    
    func getItems() -> [OTPValue] {
        
        
        var otpItems = [OTPValue]()
        getAllOTPModels().forEach { (otpModel) in
            print(otpModel.name.lowercased())
            let otpIntentObject = OTPValue(identifier: otpModel.id.uuidString, display: otpModel.name, subtitle: otpModel.email, image: INImage(named: otpModel.name.lowercased()))
            otpIntentObject.name = otpModel.name
            otpIntentObject.email = otpModel.email
            otpIntentObject.secret = otpModel.secret
            otpItems.append(otpIntentObject)
        }
        return otpItems
    }
    
    func getIcon(issuer: String) -> Icon {
        switch issuer {
        case "google":
            return Icon.google
        case "facebook":
            return Icon.facebook
        case "twitter":
            return Icon.twitter
        case "amazon":
            return Icon.amazon
        case "instagram":
            return Icon.instagram
            
        default:
            return Icon.google
        }
    }
    
    enum Icon: String {
        case google = "https://img-authors.flaticon.com/google.jpg"
        case facebook = "https://image.flaticon.com/icons/png/512/124/124010.png"
        case twitter = "https://image.flaticon.com/icons/png/512/124/124021.png"
        case instagram = "https://image.flaticon.com/icons/png/512/174/174855.png"
        case amazon = "https://cdn3.iconfinder.com/data/icons/flat-icons-web/40/Amazon-512.png"
    }
}
