//
//  IntentHandler.swift
//  OTPIntentExt
//
//  Created by Azhagusundaram Tamil on 26/10/20.
//

import Intents

class IntentHandler: INExtension, SelectOTPIntentHandling {
    //    func resolveOtp(for intent: SelectOTPIntent, with completion: @escaping (SelectedOTPResolutionResult) -> Void) {
    //
    //    }
    
    
    func provideOtpOptionsCollection(for intent: SelectOTPIntent, with completion: @escaping (INObjectCollection<SelectedOTP>?, Error?) -> Void) {
        let userDefaults = UserDefaults(suiteName: "group.com.jeeva.My-OTPs")
        let k_otp_secret = "otp_secrets"
        
        guard let otpData = userDefaults?.data(forKey: k_otp_secret) else { return nil }
        
        let decoadedOTPs: [OTPModel] = []
        
        do {
            let decoader = JSONDecoder()
            decoadedOTPs = try decoader.decode([OTPModel].self, from: otpData)
        } catch {
            print("Error while decoading")
        }
        
        let selectedOTPs: [SelectedOTP] = decoadedOTPs.map { otp in
            
            let myotp = SelectedOTP(identifier: otp.name, display: otp.name, pronunciationHint: nil, subtitle: otl.email, image: nil)
            
            myotp.name = otp.name
            
            return myotp
        }
        
        let collection = INObjectCollection(items: selectedOTPs)
        
        
        completion(collection, nil)
        
        
        
    }
    
    
    
    
    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.
        
        return self
    }
    
}
