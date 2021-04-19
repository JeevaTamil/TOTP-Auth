//
//  OAAddManualViewModel.swift
//  Widget Auth
//
//  Created by Azhagusundaram Tamil on 06/04/21.
//

import Foundation
import Combine

class OAAddManualViewModel: ObservableObject {
    
    @Published var issuer = ""
    @Published var email = ""
    @Published var secret = ""
    @Published var errorMessage = ""
    @Published var isValid = false
    
    private var cancellable = Set<AnyCancellable>()
    
    private var isIssuerValidPublisher: AnyPublisher<Bool, Never> {
        $issuer
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map {
                !$0.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        $email
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .map {
                !$0.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var isSecretValidPublisher: AnyPublisher<Bool, Never> {
        $secret
            .debounce(for: 0.3, scheduler: RunLoop.main)
            .map {
                !$0.isEmpty
            }
            .eraseToAnyPublisher()
    }
    
    private var formErrorPublisher: AnyPublisher<String, Never> {
        Publishers.CombineLatest3(isIssuerValidPublisher, isEmailValidPublisher, isSecretValidPublisher)
            .map {
                if !$0 { return "Issuer cannot be empty" }
                if !$1 { return "Email or Account name cannot be empty" }
                if !$2 { return "Secret cannot be empty" }
                return ""
            }
            .eraseToAnyPublisher()
    }
    
    private var isFormValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest3(isIssuerValidPublisher, isEmailValidPublisher, isSecretValidPublisher)
            .map {
                $0 && $1 && $2
            }
            .eraseToAnyPublisher()
    }
    
    init() {
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in: &cancellable)
        
        formErrorPublisher
            .dropFirst()
            .receive(on: RunLoop.main)
            .assign(to: \.errorMessage, on: self)
            .store(in: &cancellable)
    }
    
}
