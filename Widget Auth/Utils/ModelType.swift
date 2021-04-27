//
//  ModelType.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 26/04/21.
//

import SwiftUI

enum ModelType: Identifiable, View {
    case scanQR
    case manual
    case update(OTPModel)
    
    
    var id : String {
        switch self {
        case .scanQR:
            return "scanQR"
        case .manual:
            return "manual"
        case .update(_):
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .scanQR:
            OAScanQRView(formVM: OTPFormViewModel())
        case .manual:
            OAAddManualView(formVM: OTPFormViewModel())
        case .update(let otp):
            OAAddManualView(formVM: OTPFormViewModel(otp))
        }
    }
}

//return OAAddManualView(formVM: OTPFormViewModel())
