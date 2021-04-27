//
//  DataStorage.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 26/04/21.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    @Published var otps: [OTPModel] = []
    @Published var appError: OTPErrorType? = nil
    
    var addOTP = PassthroughSubject<OTPModel, Never>()
    var updateOTP = PassthroughSubject<OTPModel, Never>()
    var deleteOTP = PassthroughSubject<IndexSet, Never>()
    
    var subscriptions = Set<AnyCancellable>()
    
    init() {
        addSubscriptions()
        loadOTPs() 
    }
    
    // Mark:- Add Subscription
    func addSubscriptions() {
        addOTP
            .sink { [unowned self] otp in
                otps.append(otp)
                saveOTPs()
            }
            .store(in: &subscriptions)
        
        updateOTP
            .sink { [unowned self] otp in
                guard let index = otps.firstIndex(where: { $0.id == otp.id }) else { return }
                otps[index] = otp
                saveOTPs()
            }
            .store(in: &subscriptions)
        deleteOTP
            .sink { [unowned self] indexSet in
                otps.remove(atOffsets: indexSet)
                saveOTPs()
            }
            .store(in: &subscriptions)
    }
    
    //MARK:- Load OTP
    func loadOTPs() {
        PersistenceManager().loadOTPs { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    otps = try decoder.decode([OTPModel].self, from: data)
                } catch {
                    print(OTPError.decodingError.localizedDescription)
                    appError = OTPErrorType(error: .decodingError)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK:- Save OTP array
    func saveOTPs() {
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(otps)
            PersistenceManager().saveOTPs(data)
        } catch {
            print(OTPError.encodingError.localizedDescription)
            appError = OTPErrorType(error: .encodingError)
        }
    }
    
}
