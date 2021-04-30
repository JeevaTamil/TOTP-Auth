//
//  IntentHandler.swift
//  OTPIntentExtn
//
//  Created by Azhagusundaram Tamil on 27/10/20.
//

import Intents
import UIKit

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
        
        var otpItems = [OTPValue]()
        getAllOTPModels().forEach { (otpModel) in
            print(otpModel.name.lowercased())

            var otpIntentObject: OTPValue
            if UIImage(named: otpModel.issuer.lowercased()) != nil {
                otpIntentObject = OTPValue(identifier: otpModel.id, display: otpModel.issuer, subtitle: otpModel.name, image: INImage(named: otpModel.issuer.lowercased()))
            } else {
                otpIntentObject = OTPValue(identifier: otpModel.id, display: otpModel.issuer, subtitle: otpModel.name, image: INImage(named: "shield"))
            }


            otpIntentObject.name = otpModel.issuer
            otpIntentObject.email = otpModel.name
            otpIntentObject.secret = otpModel.secret
            otpItems.append(otpIntentObject)
        }

        if let selectedOTPArr = intent.otp1 {
            otpItems =  otpItems.filter { (intentOTP) -> Bool in
                return !selectedOTPArr.contains { (selectedOTP) -> Bool in
                    selectedOTP.secret == intentOTP.secret
                }
            }
        }

        completion(INObjectCollection(items: otpItems), nil)
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
