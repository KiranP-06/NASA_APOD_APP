//
//  DetailImageView.swift
//  NASA_APOD_APP
//
//  Created by admin34 on 30/12/25.
//

import SwiftUI

struct DetailImageView: View {
    let imageURL: URL
    let title: String
    let explanation: String
    
    @Environment(\.dismiss) var dismiss
    @State private var showInfo = false
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.black.ignoresSafeArea()
            
            // 1. Zoomable Image
            ZoomableScrollView {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    default:
                        ProgressView().foregroundColor(.white)
                    }
                }
            }
            
          
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: { showInfo.toggle() }) {
                        Image(systemName: "info.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
            }
            .padding()
            
          
            Button(action: { dismiss() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white.opacity(0.7))
                    .padding()
            }
        }
   
        .sheet(isPresented: $showInfo) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text(title).font(.title).bold()
                    Text(explanation).font(.body)
                }
                .padding()
            }
            .presentationDetents([.medium, .fraction(0.3)])
        }
    }
}
