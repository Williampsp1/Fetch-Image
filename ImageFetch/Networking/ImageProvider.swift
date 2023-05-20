//
//  ImageProvider.swift
//  ImageFetch
//
//  Created by William on 5/16/23.
//

import Foundation
import UIKit

protocol ImageProviding {
    func getImage(url: URL?) async throws -> UIImage
}

enum ImageError: Error, LocalizedError, Equatable {
    case URLError
    case ResponseError
    case DecodingError
    
    var errorDescription: String? {
        switch self {
        case .URLError:
            return "Bad URL"
        case .ResponseError:
            return "Response Error"
        case .DecodingError:
            return "Image Decoding Error"
        }
    }
}

struct ImageProvider: ImageProviding {
    func getImage(url: URL?) async throws -> UIImage {
        guard let url = url else {
            throw ImageError.URLError
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw ImageError.ResponseError
        }
        
        guard let image = UIImage(data: data) else {
            throw ImageError.DecodingError
        }
        
        return image
    }
}
