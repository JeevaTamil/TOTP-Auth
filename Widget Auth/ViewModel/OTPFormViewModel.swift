//
//  OTPViewModel.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 26/10/20.
//

import Foundation

class OTPFormViewModel: ObservableObject {
    @Published var issuer = ""
    @Published var name = ""
    @Published var secret = ""
    
    var id: String?
    
    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        issuer.isEmpty
    }
    
    init() {
        
    }
    
    init(_ currentOTP: OTPModel) {
        issuer = currentOTP.issuer
        name = currentOTP.name
        secret = currentOTP.secret
        id = currentOTP.id
    }
    
    
}

