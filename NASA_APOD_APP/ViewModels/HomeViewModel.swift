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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    // Default to Yesterday (-2 day) to avoid Timezone errors
    @Published var selectedDate: Date = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
    
    private let service = APIService()
    
    // Constraints as per requirements
    let minDate = Calendar.current.date(from: DateComponents(year: 1995, month: 6, day: 16))!
    let maxDate = Date()
    
    func loadAPOD() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let item = try await service.fetchAPOD(date: selectedDate)
            self.apodItem = item
        } catch {
            self.errorMessage = "Failed to load image. Please check your connection."
            
        }
        
        isLoading = false
    }
    
    
    func onChangeDate() {
        Task {
            await loadAPOD()
        }
    }
}
