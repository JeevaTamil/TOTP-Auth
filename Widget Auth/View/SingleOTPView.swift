//
//  SingleOTPView.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 06/04/21.
//

import SwiftUI

struct SingleOTPView: View {
    let otp: OTPModel
    let width = UIScreen.main.bounds.width
    var period : Int = 30
    var digits : Int = 6
    var algorithm = "SHA1"
    var spacing: CGFloat = 5
    
    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main,  in: .common).autoconnect()
    @State private var timeRemaining = Int()
    @Binding var isToastPresented: Bool
    
    var body: some View {
        HStack {
            Image(otp.issuer.lowercased())
                .resizable()
                .scaledToFill()
                .frame(width: 34, height: 34)
                .cornerRadius(5)
                .shadow(color: Color.secondary.opacity(0.3), radius: 4, x: 0, y: 0)
            VStack(alignment: .leading, spacing: spacing) {
                Text(otp.issuer)
                    .font(.headline)
                    .bold()
                Text(otp.name)
                    .font(.caption)
            }
            Spacer()
            VStack(alignment: .trailing, spacing: spacing) {
                Text(generateOTPs(otp: otp))
                    .font(.system(size: 20, weight: .bold, design: .monospaced))
                Text("\(timeRemaining)")
                    .font(.callout)
            }
        }
        .onTapGesture {
            UIPasteboard.general.string = generateOTPs(otp: otp)
            print("copied")
            withAnimation {
                isToastPresented.toggle()
            }
        }
        .onReceive(timer, perform: { _ in
            scheduleTimer()
        })
    }
    
    func scheduleTimer() {
        var components = DateComponents.init()
        components = Calendar.current.dateComponents([.hour, .minute, .second], from: Date())
        let second = components.second
        self.timeRemaining = 30 - (second!%30)
    }
}


struct SingleOTPView_Previews: PreviewProvider {
    static var previews: some View {
        SingleOTPView(otp: OTPModel.sampleData.first!, isToastPresented: .constant(false))
            .previewLayout(.sizeThatFits)
    }
}
