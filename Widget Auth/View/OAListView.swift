//
//  SwiftUIView.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 03/04/21.
//

import SwiftUI

struct OAListView: View {
    @StateObject var oaVM = OAViewModel()
    @State private var isToastPresented = false
    @State var activeSheet: ActiveSheet?
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach (oaVM.otpList) { otp in
                        SingleOTPView(otp: otp, isToastPresented: $isToastPresented)
                    }
                    .onDelete(perform: oaVM.deleteOTP)
                }
            }
            .showToast("Copied", isPresented: $isToastPresented, color: .green, duration: 1, alignment: .bottom, toastType: .offsetToast)
            .navigationTitle("OTP List")
            .navigationBarItems(
                leading: EditButton(), trailing: addButton
            )
            .fullScreenCover(item: $activeSheet, onDismiss: oaVM.readOTP) { item in
                switch item {
                case .scanqr:
                    OAScanQRView()
                case .manual:
                    OAAddManualView()
                }
            }
            .onOpenURL(perform: performOnURL)
           
        }
    }
    
    func performOnURL(url: URL) {
        let selectedID = url.relativeString.replacingOccurrences(of: "oa://", with: "")
        let selectedOTP = oaVM.otpList.filter { $0.secret == selectedID }
        guard let otp = selectedOTP.first else { return }
        UIPasteboard.general.string = generateOTPs(otp_vm: OTPViewModel(otpModel: otp)).replacingOccurrences(of: " ", with: "")
        withAnimation {
            isToastPresented.toggle()
        }
    }
    
    var addButton: some View {
        Button(action:{
            activeSheet = .scanqr
        }) {
            Image(systemName: "plus.circle")
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
        }
    }
    
}

extension Collection where Element == URLQueryItem {
    subscript(_ name: String) -> String? {
        first(where: { $0.name == name })?.value
    }
}

struct OAListView_Previews: PreviewProvider {
    let vm = OAViewModel()
    let otpList = [
        OTPModel(name: "Google", email: "jeevat13@gmail.com", secret: ""),
        OTPModel(name: "Facebook", email: "jev.jeeva", secret: ""),
        OTPModel(name: "Amazon", email: "jeevapriyan@ymail.com", secret: ""),
        
    ]
    static var previews: some View {
        OAListView(oaVM: OAViewModel())
    }
}

enum ActiveSheet: Identifiable {
    case scanqr, manual
    
    var id: Int {
        hashValue
    }
}
