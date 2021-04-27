//
//  OAScanQRVie.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 06/04/21.
//

import SwiftUI

struct OAScanQRView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var formVM: OTPFormViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    CodeScannerView(codeTypes: [.qr]) { result in
                        switch result {
                        case .success(let code):
                            addOTPFromURL(otpURL: code)
                            presentationMode.wrappedValue.dismiss()
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
                .navigationBarTitle("Scan QR Code", displayMode: .inline)
                .navigationBarItems(leading: cancelButton)
            }
        }
    }
}

extension OAScanQRView {
    func addOTPFromURL(otpURL: String) {
        guard  let components = URLComponents(string: otpURL) else { return }
        guard components.queryItems != nil  else { return }
        
        let email = components.path.replacingOccurrences(of: "/", with: "")
        let secret = components.queryItems!["secret"]
        let issuer = components.queryItems!["issuer"]
        let digits = components.queryItems!["digits"]
        let algorithm = components.queryItems!["algorithm"]
        
        let otpModel = OTPModel(issuer: issuer ?? "", name: email, secret: secret!)
        dataStore.addOTP.send(otpModel)
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct OAScanQRView_Previews: PreviewProvider {
    static var previews: some View {
        OAScanQRView(formVM: OTPFormViewModel())
    }
}
