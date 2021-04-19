//
//  OTPViewModel.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 26/10/20.
//

import Foundation

class OTPListViewModel: ObservableObject {
    
    @Published var OTPList: [OTPViewModel] = [OTPViewModel]()
    
    var period : Int = 30
    var digits : Int = 6
    var algorithm = "SHA1"
    
    
    let k_otp_secret = "otp_secrets"
    let suiteName = "group.com.jeeva.widgetauth"
    
    init() {
        getOTPs()
    }
    
    func addOTP(otp: OTPModel) {
        
        let keys = KeychainWrapper.standard.allKeys()
        let decoder = JSONDecoder()
        let encoder = JSONEncoder()
        var otpSecrets = [OTPModel]()
        
        if keys.contains(k_otp_secret) {
            guard let fetchedData = KeychainWrapper.standard.data(forKey: k_otp_secret) else { return }
            
            do {
                let decodedData = try decoder.decode([OTPModel].self, from: fetchedData)
                otpSecrets = decodedData
            } catch {
                print("erro while decoding the otp secrets")
            }
        }
        
        otpSecrets.append(otp)
    
        do {
            let encodedData = try encoder.encode(otpSecrets)
            KeychainWrapper.standard.removeObject(forKey: k_otp_secret)
            let result = KeychainWrapper.standard.set(encodedData, forKey: k_otp_secret)
           
            if let userDefaults =  UserDefaults(suiteName: suiteName) {
                userDefaults.set(encodedData, forKey: k_otp_secret)
            } else {
                print("No User defaultss")
            }
            if result {
                print("New datat added")
            } else {
                print("New data not added")
            }
        } catch {
            print("error while encoding the otp secret")
        }
    }
    
    func getOTPs() {
        let keys = KeychainWrapper.standard.allKeys()
        
        let decoder = JSONDecoder()
        
        var otpSecrets = [OTPModel]()
        
        if let userDefaults =  UserDefaults(suiteName: suiteName) {
            if let fetchedData = userDefaults.data(forKey: k_otp_secret) {
                do {
                    let decodedData = try decoder.decode([OTPModel].self, from: fetchedData)
                    
                    otpSecrets = decodedData
                } catch {
                    print("erro while decoding the otp secrets")
                }
            } else {
                print("No data found")
            }
            
            
        } else {
            print("No User defaultss")
        }
        
        if keys.contains(k_otp_secret) {
            guard let fetchedData = KeychainWrapper.standard.data(forKey: k_otp_secret) else { return }
            
            do {
                let decodedData = try decoder.decode([OTPModel].self, from: fetchedData)
                
                //otpSecrets = decodedData
            } catch {
                print("erro while decoding the otp secrets")
            }
        } else {
            print("Key not founs")
        }
        DispatchQueue.main.async {
            self.OTPList.append(contentsOf: otpSecrets.map{OTPViewModel(otpModel: $0)})
        }
    }
    
    func deleteOTP(indexSet: IndexSet) {
        for index in indexSet {
            let otpToDelete = self.OTPList[index]
            
            let keys = KeychainWrapper.standard.allKeys()
            
            let decoder = JSONDecoder()
            
            var otpSecrets = [OTPModel]()
            
            if keys.contains(k_otp_secret) {
                guard let fetchedData = KeychainWrapper.standard.data(forKey: k_otp_secret) else { return }
                
                do {
                    let decodedData = try decoder.decode([OTPModel].self, from: fetchedData)
                    otpSecrets = decodedData
                } catch {
                    print("erro while decoding the otp secrets")
                }
            }
            
            otpSecrets.remove(at: otpSecrets.firstIndex(where: { $0.id == otpToDelete.id })!)
            
            let encoder = JSONEncoder()
            
            do {
                let encodedData = try encoder.encode(otpSecrets)
                KeychainWrapper.standard.removeObject(forKey: k_otp_secret)
                let result = KeychainWrapper.standard.set(encodedData, forKey: k_otp_secret)
                if let userDefaults =  UserDefaults(suiteName: suiteName) {
                    userDefaults.set(encodedData, forKey: k_otp_secret)
                }else {
                    print("No User defaultss")
                }
                if result {
                    print("New datat added")
                } else {
                    print("New data not added")
                }
            } catch {
                print("error while encoding the otp secret")
            }
            
        }
    }
    
    func generateOTPs(otp_vm: OTPViewModel) -> String {
        let secretData = NSData(base32String: otp_vm.secret)
        
        let now = Date()
        let timeStamp = now.timeIntervalSince1970
        let generator =  TOTPGenerator(secret: secretData as Data?, algorithm: self.algorithm, digits: UInt(self.digits), period: TimeInterval(self.period))
        let code = generator?.generateOTP(for: Date.init(timeIntervalSince1970: TimeInterval(timeStamp))).separating(every: 3, separator: " ")
        return code!
    }
    
    func fetchAllOTPs() -> [OTPModel] {
        // let userDefaults = UserDefaults(suiteName: "group.com.jeeva.My-OTPs")
        // let k_otp_secret = "otp_secrets"
        
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
            print("decoading error")
        }
        
        return fetchedOTPs
    }
    
}

struct OTPViewModel: Identifiable {
   
    var otpModel: OTPModel
    
    init(otpModel: OTPModel) {
        self.otpModel = otpModel
    }
    
    var name: String {
        return self.otpModel.name
    }
    
    var email: String {
        return self.otpModel.email
    }
    
    var secret: String {
        return self.otpModel.secret
    }
    
    var id: UUID {
        return otpModel.id
    }
}
