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
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var formVM: OTPFormViewModel
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Details")) {
                    FormField(fieldString: $formVM.issuer, isEditingChanged: $issuerChange, field: "Issuer", example: "ex: Google")
                    FormField(fieldString: $formVM.name, isEditingChanged: $nameChange, field: "Account", example: "ex: demo@example.com")
                    if !formVM.updating {
                    FormField(fieldString: $formVM.secret, isEditingChanged: $secretChange, field: "Secret", example: "ex: ASDFGHJKL...")
                    }
                }
                updateSaveButton
            }
            .navigationBarTitle(formVM.updating ? "Update Account" : "Add Account", displayMode: .inline)
            .navigationBarItems(leading: cancelButton)
        }
    }
}

extension OAAddManualView {
    func updateOTP() {
        let otp = OTPModel(id: formVM.id!, issuer: formVM.issuer, name: formVM.name, secret: formVM.secret)
        dataStore.updateOTP.send(otp)
        isPresented.wrappedValue.dismiss()
    }
    
    func addOTP() {
        let otp = OTPModel(issuer: formVM.issuer, name: formVM.name, secret: formVM.secret)
        dataStore.addOTP.send(otp)
        isPresented.wrappedValue.dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            isPresented.wrappedValue.dismiss()
        }
    }
    
    var updateSaveButton: some View {
        Button(formVM.updating ? "Update" : "Save", action: formVM.updating ? updateOTP : addOTP)
            .disabled(formVM.isDisabled)
    }
}

struct OAAddManualView_Previews: PreviewProvider {
    static var previews: some View {
        OAAddManualView(formVM: OTPFormViewModel())
            .environmentObject(DataStore())
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

