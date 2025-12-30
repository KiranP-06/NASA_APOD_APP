//
//  HomeViewModel.swift
//  NASA_APOD_APP
//
//  Created by admin34 on 30/12/25.
//

import Foundation
import SwiftUI
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    @Published var apodItem: APODItem?
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    // Default to Yesterday to avoid timezone crash
    @Published var selectedDate: Date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!

    private let service: APIService

    // Dependency Injection
    init(service: APIService = APIService()) {
        self.service = service
    }
    
 
    var minDate: Date {
        Calendar.current.date(from: DateComponents(year: 1995, month: 6, day: 16))!
    }
    
    var maxDate: Date {
        Date()
    }

 
    func onChangeDate() {
        Task {
            await loadAPOD()
        }
    }

    func loadAPOD() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let item = try await service.fetchAPOD(date: selectedDate)
            self.apodItem = item
        } catch {
            print("DEBUG ERROR: \(error)")
            self.errorMessage = "Error: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
