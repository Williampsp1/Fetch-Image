//
//  ImageFetchViewModel.swift
//  ImageFetch
//
//  Created by William on 5/16/23.
//

import Foundation
import UIKit

class RandomImageViewModel: ObservableObject {
    private let imageProvider: ImageProviding
    @Published var uiImage: UIImage?
    @Published var images: [ImageModel] = []
    var error: ImageError?
    
    init(imageProvider: ImageProviding) {
        self.imageProvider = imageProvider
    }
    
    @discardableResult
    func getPicsumImage(string: String?, size: Int, placeholder: UIImage) -> Task<Void, Never> {
        let task = Task {
            do {
                let url = constructURL(string: string, size: size)
                let image = try await imageProvider.getImage(url: url)
                
                await MainActor.run {
                    uiImage = image
                }
            } catch let error {
                print("Error: \(error.localizedDescription)")
                self.error = error as? ImageError
                await MainActor.run {
                    uiImage = placeholder
                }
            }
        }
        
        return task
    }
    
    private func constructURL(string: String?, size: Int) -> URL? {
        let appendedString: String
        if let providedString = string, !providedString.isEmpty {
            appendedString = providedString
        } else {
            appendedString = "accesso"
        }
        let imageURL = URL(string: "https://picsum.photos/seed/\(appendedString)/\(size)")
        
        return imageURL
    }
    
    func getPicsumImages(placeholder: UIImage, size: Int) {
        // Fill array with temp models so we can place the images in order.
        images = Array(repeating: ImageModel(image: UIImage(), id: 0), count: 50)
        Task {
            for i in 0..<50 {
                Task {
                    let url = constructURL(string: String(i), size: size)
                    do {
                        let image = try await imageProvider.getImage(url: url)
                        
                        await MainActor.run {
                            images[i] = ImageModel(image: image, id: i)
                        }
                    } catch let error {
                        print("\(i) Error: \(error.localizedDescription)")
                        self.error = error as? ImageError
                        await MainActor.run {
                            images[i] = ImageModel(image: placeholder, id: i)
                        }
                    }
                }
            }
        }
    }
}
