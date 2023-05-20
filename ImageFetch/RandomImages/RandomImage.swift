//
//  ImageFetch.swift
//  ImageFetch
//
//  Created by William on 5/16/23.
//

import SwiftUI

struct RandomImage: View {
    @StateObject private var viewModel = RandomImageViewModel(imageProvider: ImageProvider())
    
    var body: some View {
        ScrollView {
            if viewModel.images.isEmpty {
                if let image = viewModel.uiImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                } else {
                    ProgressView()
                }
            } else {
                LazyVGrid(columns: [GridItem(), GridItem()], pinnedViews: .sectionHeaders) {
                    Section(content: {
                        ForEach(viewModel.images) { image in
                            
                            Image(uiImage: image.image)
                                .resizable()
                                .scaledToFit()
                        }
                    }, header: {
                        Text("My Images")
                    })
                    
                }
            }
        }
        .onAppear {
            // Get a single image
            viewModel.getPicsumImage(string: "hello", size: 200, placeholder: UIImage(systemName: "star") ?? UIImage())
            // Get images
            //viewModel.getPicsumImages(placeholder: UIImage(systemName: "star") ?? UIImage(), size: 200)
        }
    }
    
}

struct ImageFetch_Previews: PreviewProvider {
    static var previews: some View {
        RandomImage()
    }
}
