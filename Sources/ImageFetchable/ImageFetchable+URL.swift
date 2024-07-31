//
//  File.swift
//  ImageFetchable
//
//  Created by xaoxuu on 2024/7/31.
//

import UIKit

public protocol ImageFetchableURL {
    /// 加载网络图片
    func fetchImage(imageURL: URL) async -> Result<UIImage?, Error>
}

public extension ImageFetchable where T == URL {
    
    var imp: ImageFetchableURL? { self as? ImageFetchableURL }
    
    /// 加载网络图片
    func fetchImage(_ imageURL: URL) async -> Result<UIImage?, Error> {
        guard let imp else { return .failure(ImageFetchError.missingImplementation) }
        return await imp.fetchImage(imageURL: imageURL)
    }
    
}

extension URL {
    var imageFetcher: ImageFetchable<URL> {
        .init(sourceType: self)
    }
}

public extension URL {
    
    func fetchImage() async throws -> UIImage? {
        switch await imageFetcher.fetchImage(self) {
        case .success(let image):
            return image
        case .failure(let error):
            throw error
        }
    }
    
}
