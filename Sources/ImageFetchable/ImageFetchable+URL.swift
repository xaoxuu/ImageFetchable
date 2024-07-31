//
//  File.swift
//  ImageFetchable
//
//  Created by xaoxuu on 2024/7/31.
//

import UIKit

public protocol ImageFetchableURL {
    func fetchImage(imageURL: URL) async -> Result<Data?, Error>
}

public extension ImageFetchable where T == URL {
    
    var imp: ImageFetchableURL? { self as? ImageFetchableURL }
    
    /// 加载网络图片数据
    func fetchImageData(_ imageURL: URL) async -> Result<Data?, Error> {
        guard let imp else { return .failure(ImageFetchError.missingImplementation) }
        return await imp.fetchImage(imageURL: imageURL)
    }
    
    /// 加载网络图片
    func fetchUIImage(_ imageURL: URL, scale: CGFloat? = nil) async -> Result<UIImage?, Error> {
        guard let imp else { return .failure(ImageFetchError.missingImplementation) }
        let result = await imp.fetchImage(imageURL: imageURL)
        switch result {
        case .success(let data):
            guard let data else {
                return .success(nil)
            }
            if let scale {
                return .success(.init(data: data, scale: scale))
            } else {
                return .success(.init(data: data))
            }
        case .failure(let error):
            return .failure(error)
        }
    }
    
}

extension URL {
    var imageFetcher: ImageFetchable<URL> {
        .init(sourceType: self)
    }
}

public extension URL {
    
    func fetchImageData() async throws -> Data? {
        switch await imageFetcher.fetchImageData(self) {
        case .success(let image):
            return image
        case .failure(let error):
            throw error
        }
    }
    
    func fetchImage(scale: CGFloat? = nil) async throws -> UIImage? {
        switch await imageFetcher.fetchUIImage(self, scale: scale) {
        case .success(let image):
            return image
        case .failure(let error):
            throw error
        }
    }
    
}
