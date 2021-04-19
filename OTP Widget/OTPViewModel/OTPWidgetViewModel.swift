//
//  OTPViewModel.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 26/10/20.
//

import Foundation
import OTPModel


class OTPWidgetViewModel {
    
    let k_otp_secret = "otp_secrets"
    let userDefaults = UserDefaults(suiteName: "group.com.jeeva.My-OTPs")
    
    func getOTPs() -> [OTPModel]? {
        guard let otpData = userDefaults?.data(forKey: k_otp_secret) else { return nil }
        
        do {
            let decoader = JSONDecoder()
            let decoadedOTPs = try decoader.decode([OTPModel].self, from: otpData)
            return decoadedOTPs
        } catch {
            print("Error while decoading")
        }
        
        return nil
    }
    
    
}
