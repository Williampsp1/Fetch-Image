//
//  ImageFetchTests.swift
//  ImageFetchTests
//
//  Created by William on 5/16/23.
//

import XCTest

final class RandomImageViewModelTests: XCTestCase {
    
    func testImageFetch() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProvider())
        
        await viewModel.getPicsumImage(string: "random", size: 200, placeholder: UIImage(systemName: "star.fill") ?? UIImage())
        
        XCTAssertEqual(UIImage(systemName: "star"), viewModel.uiImage)
        XCTAssertEqual(viewModel.error, nil)
    }
    
    func testImageFetchNoString() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProviderEmptyString())
        
        await viewModel.getPicsumImage(string: "", size: 200, placeholder: UIImage(systemName: "star.fill") ?? UIImage())
        
        XCTAssertEqual(UIImage(systemName: "star.square"), viewModel.uiImage)
        XCTAssertEqual(viewModel.error, nil)
    }
    
    func testGetPictures() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProvider())
        let expectation = XCTestExpectation(description: "Get pictures")
        
        await viewModel.getPicsumImages(placeholder: UIImage(systemName: "star.square") ?? UIImage(), size: 200)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(50, viewModel.images.count)
            XCTAssertEqual(UIImage(systemName: "star"), viewModel.images[0].image)
            XCTAssertEqual(0, viewModel.images[0].id)
            XCTAssertEqual(viewModel.error, nil)
            expectation.fulfill()
        }
        
        await fulfillment(of:[expectation], timeout: 5)
    }
    
    func testGetPicturesResponseError() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProviderResponseError())
        let expectation = XCTestExpectation(description: "Get pictures")
        
        await viewModel.getPicsumImages(placeholder: UIImage(systemName: "star.square") ?? UIImage(), size: 200)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(50, viewModel.images.count)
            XCTAssertEqual(UIImage(systemName: "star.square"), viewModel.images[0].image)
            XCTAssertEqual(0, viewModel.images[0].id)
            XCTAssertEqual(viewModel.error, ImageError.ResponseError)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func testGetPicturesURLError() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProviderURLError())
        let expectation = XCTestExpectation(description: "Get pictures")
        
        await viewModel.getPicsumImages(placeholder: UIImage(systemName: "star.square") ?? UIImage(), size: 200)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(50, viewModel.images.count)
            XCTAssertEqual(UIImage(systemName: "star.square"), viewModel.images[0].image)
            XCTAssertEqual(0, viewModel.images[0].id)
            XCTAssertEqual(viewModel.error, ImageError.URLError)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func testGetPicturesDecodingError() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProviderDecodingError())
        let expectation = XCTestExpectation(description: "Get pictures")
        
        await viewModel.getPicsumImages(placeholder: UIImage(systemName: "star.square") ?? UIImage(), size: 200)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(50, viewModel.images.count)
            XCTAssertEqual(UIImage(systemName: "star.square"), viewModel.images[0].image)
            XCTAssertEqual(0, viewModel.images[0].id)
            XCTAssertEqual(viewModel.error, ImageError.DecodingError)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 5)
    }
    
    func testImageFetchResponseError() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProviderResponseError())
        
        await viewModel.getPicsumImage(string: "random", size: 200, placeholder: UIImage(systemName: "star.fill") ?? UIImage())
        
        XCTAssertEqual(UIImage(systemName: "star.fill"), viewModel.uiImage)
        XCTAssertEqual(viewModel.error, ImageError.ResponseError)
    }
    
    func testImageFetchDecodingError() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProviderDecodingError())
        
        await viewModel.getPicsumImage(string: "random", size: 200, placeholder: UIImage(systemName: "star.fill") ?? UIImage())
        
        XCTAssertEqual(UIImage(systemName: "star.fill"), viewModel.uiImage)
        XCTAssertEqual(viewModel.error, ImageError.DecodingError)
    }
    
    func testImageFetchURLError() async {
        let viewModel = RandomImageViewModel(imageProvider: MockImageProviderURLError())
        
        await viewModel.getPicsumImage(string: "random", size: 200, placeholder: UIImage(systemName: "star.fill") ?? UIImage())
        
        XCTAssertEqual(UIImage(systemName: "star.fill"), viewModel.uiImage)
        XCTAssertEqual(viewModel.error, ImageError.URLError)
    }
    
}
