//
//  MockImageProvider.swift
//  ImageFetch
//
//  Created by William on 5/19/23.
//

import Foundation
import UIKit

struct MockImageProvider: ImageProviding {
    func getImage(url: URL?) async throws -> UIImage {
        return UIImage(systemName: "star") ?? UIImage()
    }
}

struct MockImageProviderEmptyString: ImageProviding {
    func getImage(url: URL?) async throws -> UIImage {
        return UIImage(systemName: "star.square") ?? UIImage()
    }
}

struct MockImageProviderResponseError: ImageProviding {
    func getImage(url: URL?) async throws -> UIImage {
        throw ImageError.ResponseError
    }
}

struct MockImageProviderDecodingError: ImageProviding {
    func getImage(url: URL?) async throws -> UIImage {
        throw ImageError.DecodingError
    }
}

struct MockImageProviderURLError: ImageProviding {
    func getImage(url: URL?) async throws -> UIImage {
        throw ImageError.URLError
    }
}
