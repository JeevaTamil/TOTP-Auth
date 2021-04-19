//
//  OAViewModel.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 03/04/21.
//

import Foundation
import WidgetKit


class OAViewModel: ObservableObject {
    
    @Published var otpList = [OTPModel]()
    private let key = "oa_otp_secrets"
    private let group = "group.com.jeeva.widgetauth"
    
    init() {
        readOTP()
    }
    
    //MARK:- create new OTP
    func createOTP(otp: OTPModel) {
        otpList.append(otp)
        encodeAndStoreOTPs(otpList: otpList)
        DispatchQueue.main.async {
            WidgetCenter.shared.reloadAllTimelines()
            print("widget reloaded")
        }
    }
    
    
    //MARK:- read OTPs
    func readOTP() {
        guard let otpData = UserDefaults(suiteName: group)?.data(forKey: key) else { return }
        do {
            otpList = try JSONDecoder().decode([OTPModel].self, from: otpData)
        } catch {
            print("Decoding error")
        }
    }
    
    //MARK:- update OTP
    func updateOTP(indexSet: IndexSet) {
        
    }
    
    //MARK:- delete OTP
    func deleteOTP(at indexSet: IndexSet) {
        
        for index in indexSet {
            otpList.remove(at: index)
        }
        
        //otpList.remove(atOffsets: indexSet)
        encodeAndStoreOTPs(otpList: otpList)
        //DispatchQueue.main.async {
            WidgetCenter.shared.reloadAllTimelines()
            print("widget reloaded")
       // }
        
        
        
    }
    
    //MARK:- Util
    func encodeAndStoreOTPs(otpList: [OTPModel]) {
        do {
            let otpData = try JSONEncoder().encode(otpList)
            UserDefaults(suiteName: group)?.set(otpData, forKey: key)
        } catch {
            print("Create otp error")
        }
        readOTP()
    }
    
   
    
}

//MARK:- Extensions

extension String {
    func separating(every: Int, separator: String) -> String {
        let regex = #"(.{\#(every)})(?=.)"#
        return self.replacingOccurrences(of: regex, with: "$1\(separator)", options: [.regularExpression])
    }
}


func generateOTPs(otp_vm: OTPViewModel) -> String {
    let period : Int = 30
    let digits : Int = 6
    let algorithm = "SHA1"
    
    let secretData = NSData(base32String: otp_vm.secret)
    
    let now = Date()
    let timeStamp = now.timeIntervalSince1970
    let generator =  TOTPGenerator(secret: secretData as Data?, algorithm: algorithm, digits: UInt(digits), period: TimeInterval(period))
    let code = generator?.generateOTP(for: Date.init(timeIntervalSince1970: TimeInterval(timeStamp))).separating(every: 3, separator: " ")
    guard let codeVal = code else {
        return "123 456"
    }
    return codeVal
}
