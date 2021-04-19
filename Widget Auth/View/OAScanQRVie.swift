//
//  OAScanQRVie.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 06/04/21.
//

import SwiftUI

struct OAScanQRView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var isAddManualViewPresented = false
    @StateObject var oaVM = OAViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                CodeScannerView(codeTypes: [.qr]) { result in
                    switch result {
                    case .success(let code):
                        addOTPFromURL(otpURL: code)
                        presentationMode.wrappedValue.dismiss()
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
                VStack {
                    Spacer()
                    Button("Enter Manually") {
                        isAddManualViewPresented.toggle()
                    }
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(9)
                    .offset(y: -30.0)
                }
            }
            .navigationBarTitle("Scan QR", displayMode: .inline)
            .navigationBarItems(
                trailing: Button(action: {
                    presentationMode
                        .wrappedValue.dismiss()
                }){
                    Image(systemName: "multiply")
                        .resizable()
                        .frame(width: 16, height: 16, alignment: .center)
                        .padding()
                }
                
            )
            .sheet(isPresented: $isAddManualViewPresented, onDismiss: {
                presentationMode
                    .wrappedValue.dismiss()
            }) {
                OAAddManualView()
            }
        }
    }
    
    func addOTPFromURL(otpURL: String) {
        
        guard  let components = URLComponents(string: otpURL) else { return }
        guard components.queryItems != nil  else { return }
        
        let email = components.path.replacingOccurrences(of: "/", with: "")
        let secret = components.queryItems!["secret"]
        let issuer = components.queryItems!["issuer"]
        let digits = components.queryItems!["digits"]
        let algorithm = components.queryItems!["algorithm"]
        
        
        let otpModel = OTPModel(name: issuer ?? "", email: email, secret: secret!)
        oaVM.createOTP(otp: otpModel)
    }
}

struct OAScanQRView_Previews: PreviewProvider {
    static var previews: some View {
        OAScanQRView()
    }
}
