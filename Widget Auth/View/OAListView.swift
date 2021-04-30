//
//  SwiftUIView.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 03/04/21.
//

import SwiftUI

struct OAListView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var isToastPresented = false
    @State private var modelType: ModelType? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach (dataStore.otps.value) { otp in
                        SingleOTPView(otp: otp, isToastPresented: $isToastPresented)
                            .onLongPressGesture {
                                modelType = .update(otp)
                            }
                    }
                    .onDelete(perform: dataStore.deleteOTP.send)
                }
                .listStyle(InsetGroupedListStyle())
            }
            .showToast("Copied", isPresented: $isToastPresented, color: .secondary, duration: 1, alignment: .bottom, toastType: .offsetToast)
            .navigationTitle("Authenticator")
            .navigationBarItems(
                trailing: addButton
            )
            .alert(item: $dataStore.appError.value) { appError in
                Alert(title: Text("Oh ho"), message: Text(appError.error.localizedDescription), dismissButton: .default(Text("OK")))
            }
            //.onOpenURL(perform: performOnURL)
        }
        .sheet(item: $modelType) { $0
        }
    }
}

extension OAListView {
    //    func performOnURL(url: URL) {
    //        let selectedID = url.relativeString.replacingOccurrences(of: "oa://", with: "")
    //        let selectedOTP = oaVM.otpList.filter { $0.secret == selectedID }
    //        guard let otp = selectedOTP.first else { return }
    //        UIPasteboard.general.string = generateOTPs(otp: otp).replacingOccurrences(of: " ", with: "")
    //        withAnimation {
    //            isToastPresented.toggle()
    //        }
    //    }
    
    var addButton: some View {
        Menu {
            Button(action: {
                modelType = .scanQR
            }){
                Label("Scan QR", systemImage: "qrcode")
            }
            Button(action: {
                modelType = .manual
            }){
                Label("Enter Manually", systemImage: "square.and.pencil")
            }
            
        } label: {
            Image(systemName: "plus.circle.fill")
                .resizable()
                .frame(width: 24, height: 24, alignment: .center)
                .padding()
        }
    }
}

extension Collection where Element == URLQueryItem {
    subscript(_ name: String) -> String? {
        first(where: { $0.name == name })?.value
    }
}

struct OAListView_Previews: PreviewProvider {
    static var previews: some View {
        OAListView()
            .environmentObject(DataStore())
    }
}

enum ActiveSheet: Identifiable {
    case scanqr, manual
    var id: Int {
        hashValue
    }
}
