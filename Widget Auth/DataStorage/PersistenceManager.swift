//
//  PersistenceManager.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 27/04/21.
//

import Foundation

class PersistenceManager {
    
    private let key = "oa_otp_secrets"
    private let group = "group.com.jeeva.widgetauth"
    
    func saveOTPs(_ data: Data) {
        UserDefaults(suiteName: group)?.set(data, forKey: key)
    }
}
