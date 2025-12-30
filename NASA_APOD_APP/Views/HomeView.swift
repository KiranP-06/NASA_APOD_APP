//
//  HomeView.swift
//  NASA_APOD_APP
//
//  Created by admin34 on 30/12/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var showingDetail = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(uiColor: .systemBackground).ignoresSafeArea()
                
                if viewModel.isLoading {
                    ProgressView("Fetching Space Data...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Image(systemName: "exclamationmark.triangle")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        Text(error)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task { await viewModel.loadAPOD() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding()
                } else if let item = viewModel.apodItem {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            
                            // Date Picker
                            DatePicker("Select Date",
                                       selection: $viewModel.selectedDate,
                                       in: viewModel.minDate...viewModel.maxDate,
                                       displayedComponents: .date)
                            .onChange(of: viewModel.selectedDate) { _ in
                                viewModel.onChangeDate()
                            }
                            .padding()
                            .background(Color.gray.opacity(0.1))
                            .cornerRadius(10)
                            
                            
                            if item.mediaType == "image" {
                                AsyncImage(url: URL(string: item.url)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView().frame(height: 300)
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .onTapGesture {
                                                showingDetail = true
                                            }
                                    case .failure:
                                        Image(systemName: "photo")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .foregroundColor(.gray)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                            } else {
                                
                                Link("Watch Video", destination: URL(string: item.url)!)
                                    .font(.headline)
                                    .padding()
                            }
                            
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text(item.title)
                                    .font(.title)
                                    .bold()
                                
                                if let copyright = item.copyright {
                                    Text("© \(copyright)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                                
                                Text(item.explanation)
                                    .font(.body)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                    
                    .fullScreenCover(isPresented: $showingDetail) {
                        if let item = viewModel.apodItem {
                            
                            let url = URL(string: item.hdurl ?? item.url)
                            
                            if let url = url {
                                DetailImageView(imageURL: url, title: item.title, explanation: item.explanation)
                            }
                        }
                    }
                }
            }
            .navigationTitle("NASA APOD")
            .task {
                await viewModel.loadAPOD()
            }
        }
    }
}
