//
//  OAAddManualView.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 03/04/21.
//

import SwiftUI

struct OAAddManualView: View {
 
    @State private var issuerChange: Bool = false
    @State private var nameChange: Bool = false
    @State private var secretChange: Bool = false
    
    @Environment(\.presentationMode) var isPresented
    
    @StateObject var addManualViewModel = OAAddManualViewModel()
    @StateObject var oaVM = OAViewModel()
    
    var body: some View {
        
        NavigationView {
            Form {
                Section(header: Text("Details"), footer: Text(addManualViewModel.errorMessage).foregroundColor(.red)) {
                    FormField(fieldString: $addManualViewModel.issuer, isEditingChanged: $issuerChange, field: "Issuer", example: "ex: Google")
                    FormField(fieldString: $addManualViewModel.email, isEditingChanged: $nameChange, field: "Account", example: "ex: demo@example.com")
                    FormField(fieldString: $addManualViewModel.secret, isEditingChanged: $secretChange, field: "Secret", example: "ex: ASDFGHJKL...")
                }
                
                Button(action: addOTPSecret, label: {
                    Text("ADD")
                })
                .disabled(!addManualViewModel.isValid)
            }
            .navigationBarTitle("Add OTP", displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                isPresented.wrappedValue.dismiss()
            }){
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 16, height: 16, alignment: .center)
            })
        }
    }
    
    func addOTPSecret() {
        let otpObj = OTPModel(name: addManualViewModel.issuer, email: addManualViewModel.email, secret: addManualViewModel.secret)
        
        oaVM.createOTP(otp: otpObj)
        isPresented.wrappedValue.dismiss()
    }
}

struct OAAddManualView_Previews: PreviewProvider {
    static var previews: some View {
        OAAddManualView()
    }
}

struct FormField: View {
    @Binding var fieldString: String
    @Binding var isEditingChanged: Bool
    var field: String
    var example: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(field)
                .foregroundColor(isEditingChanged ? .blue : .secondary)
            TextField(example, text: $fieldString) { (val) in
                withAnimation {
                     isEditingChanged = val
                }
            }
        }
    }
}

