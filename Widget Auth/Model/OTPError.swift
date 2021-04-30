//
//  OTPError.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 27/04/21.
//

import Foundation

enum OTPError: Error, LocalizedError {
    case encodingError
    case decodingError
    case fetchingError
    
    var errorDescription: String? {
        switch self {
        case .encodingError:
            return NSLocalizedString("Something went wrong in encoding the OTPs", comment: "")
        case .decodingError:
            return NSLocalizedString("Something went wrong in decoding the OTPs", comment: "")
        case .fetchingError:
            return NSLocalizedString("Something went wrong in fetching the OTPs", comment: "")
        }
    }
}

struct OTPErrorType: Identifiable {
    var id = UUID()
    var error: OTPError
}
