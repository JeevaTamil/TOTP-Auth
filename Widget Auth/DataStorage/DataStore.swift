//
//  DataStorage.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 26/04/21.
//

import Foundation
import Combine

class DataStore: ObservableObject {
    var otps = CurrentValueSubject<[OTPModel], Never>([])
    var appError = CurrentValueSubject<OTPErrorType?, Never>(nil)
    var addOTP = PassthroughSubject<OTPModel, Never>()
    var updateOTP = PassthroughSubject<OTPModel, Never>()
    var deleteOTP = PassthroughSubject<IndexSet, Never>()
    
    var loadOTPs = UserDefaults.shared
    
    var subscriptions = Set<AnyCancellable>()
    init() {
        addSubscriptions()
    }
    
    //Mark:- Add Subscription
    func addSubscriptions() {
        loadOTPs
            .publisher(for: \.otpData)
            .compactMap{ $0 }
            .decode(type: [OTPModel].self, decoder: JSONDecoder())
            .subscribe(on: DispatchQueue(label: "bg"))
            .receive(on: DispatchQueue.main)
            .sink { [unowned self]  complition in
                switch complition {
                case .finished:
                    print("decoding completed")
                    otpsSubscription()
                case .failure(_):
                    appError.send(OTPErrorType(error: OTPError.decodingError))
                    print("error happened")
                    otpsSubscription()
                }
            } receiveValue: { [unowned self] otps in
                self.objectWillChange.send()
                self.otps.value = otps
                print("otps assigned")
                otpsSubscription()
            }
            .store(in: &subscriptions)
        
      
        addOTP
            .sink { [unowned self] otp in
                self.objectWillChange.send()
                otps.value.append(otp)
            }
            .store(in: &subscriptions)
        
        updateOTP
            .sink { [unowned self] otp in
                guard let index = otps.value.firstIndex(where: { $0.id == otp.id }) else { return }
                self.objectWillChange.send()
                otps.value[index] = otp
            }
            .store(in: &subscriptions)
        deleteOTP
            .sink { [unowned self] indexSet in
                self.objectWillChange.send()
                otps.value.remove(atOffsets: indexSet)
            }
            .store(in: &subscriptions)
    }
    
    func otpsSubscription() {
        otps
            .subscribe(on: DispatchQueue(label: "bg"))
            .receive(on: DispatchQueue.main)
            .dropFirst()
            .encode(encoder: JSONEncoder())
            .tryMap { data in
                PersistenceManager().saveOTPs(data)
            }
            .sink { complition in
                switch complition {
                case .finished:
                    print("Saving completed")
                case .failure(_):
                    self.appError.send(OTPErrorType(error: OTPError.encodingError))
                }
            } receiveValue: { _ in
                print("Saved")
            }
            .store(in: &subscriptions)
    }
}

extension UserDefaults {
    static var shared: UserDefaults {
        return UserDefaults(suiteName: "group.com.jeeva.widgetauth")!
    }
    
    @objc dynamic var otpData: Data? {
        get {
            return data(forKey: "oa_otp_secrets")
        }
        set {
            setValue(newValue, forKey: "oa_otp_secrets")
        }
    }
}
