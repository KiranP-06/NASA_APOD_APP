//
//  DetailImageView.swift
//  NASA_APOD_APP
//
//  Created by admin34 on 30/12/25.
//

import SwiftUI

struct DetailImageView: View {
    let imageURL: URL
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            
            GeometryReader { proxy in
                ScrollView([.horizontal, .vertical]) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: proxy.size.width, height: proxy.size.height)
                    } placeholder: {
                        ProgressView()
                    }
                }
            }
            
            
            Button(action: { dismiss() }) {
                Image(systemName: "xmark.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding()
            }
        }
        .background(Color.black)
    }
}
