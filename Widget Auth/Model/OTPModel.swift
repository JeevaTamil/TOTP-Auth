//
//  OTPModel.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 26/10/20.
//

import Foundation


struct OTPModel: Identifiable, Codable {
    var id: String = UUID().uuidString
    var issuer: String
    var name: String
    var secret: String
    
    static var sampleData = [
        OTPModel(issuer: "Google", name: "emma@gmail.com", secret: "Google"),
        OTPModel(issuer: "Facebook", name: "alex@facebook.com", secret: "Facebook"),
        OTPModel(issuer: "Apple", name: "jeeva@apple.com", secret: "Apple"),
    ]
}

func getAllOTPModels() -> [OTPModel] {
//    let k_otp_secret = "otp_secrets"
    let k_otp_secret = "oa_otp_secrets"
    let suiteName = "group.com.jeeva.widgetauth"
    var fetchedOTPs = [OTPModel]()
    do {
        if let userDefaults =  UserDefaults(suiteName: suiteName) {
            if let encodedOTPs = userDefaults.data(forKey: k_otp_secret) {
                let decoadedOTPs = try JSONDecoder().decode([OTPModel].self, from: encodedOTPs)
                fetchedOTPs = decoadedOTPs
            } else {
                print("No data found for the key in userdefaults")
            }
        }
    } catch {
        print("")
    }
    return fetchedOTPs 
}

