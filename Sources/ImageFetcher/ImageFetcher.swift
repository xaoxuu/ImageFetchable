// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

// 本工具的意义在于使组件库不依赖具体的网络图片实现工具，面向协议开发。
// 顺便统一图片设置方式，使得本地图片也可以通过本协议的接口设置。
public struct ImageFetcher {
    
    /// UIImageView
    fileprivate var imageView: UIImageView?
    
    /// 创建一个实例
    /// - Parameter imageView: UIImageView
    init(imageView: UIImageView?) {
        self.imageView = imageView
    }
    
    private var imp: ImageFetcherImplementation? { self as? ImageFetcherImplementation }
    
    /// 设置图片
    /// - Parameter urlStringOrImageName: 网络图片地址或本地图片素材名
    @discardableResult
    public func setImage(_ urlStringOrImageName: String?) async -> Result<UIImage?, Error> {
        guard let urlStringOrImageName, urlStringOrImageName.count > 0 else { return .failure(ImageFetcherError.invalidURL) }
        if urlStringOrImageName.contains("://") {
            return await setImage(.init(string: urlStringOrImageName), placeholder: nil)
        } else {
            guard let imp else { return .failure(ImageFetcherError.missingImplementation) }
            guard let imageView = imageView else { return .failure(ImageFetcherError.missingImageView) }
            return await imp.imageFetcher(imageView, imageName: urlStringOrImageName)
        }
    }
    
    /// 设置网络图片
    /// - Parameters:
    ///   - url: 网络图片地址
    ///   - placeholder: 占位图
    @discardableResult
    public func setImage(_ url: URL?, placeholder: UIImage? = nil) async -> Result<UIImage?, Error> {
        guard let imp else { return .failure(ImageFetcherError.missingImplementation) }
        guard let imageView = imageView else { return .failure(ImageFetcherError.missingImageView) }
        return await imp.imageFetcher(imageView, imageURL: url, placeholder: placeholder)
    }
    
}

public extension ImageFetcher {
    
    /// 设置图片
    /// - Parameter urlStringOrImageName: 网络图片地址或本地图片素材名
    func setImage(_ urlStringOrImageName: String?) {
        Task {
            await setImage(urlStringOrImageName)
        }
    }
    
    /// 设置网络图片
    /// - Parameters:
    ///   - url: 网络图片地址
    ///   - placeholder: 占位图
    func setImage(_ url: URL?, placeholder: UIImage? = nil) {
        Task {
            await setImage(url, placeholder: placeholder)
        }
    }
    
}

public protocol ImageFetcherImplementation {
    /// 设置本地图片
    @MainActor func imageFetcher(_ imageView: UIImageView, imageName: String?) async -> Result<UIImage?, Error>
    /// 设置网络图片
    @MainActor func imageFetcher(_ imageView: UIImageView, imageURL: URL?, placeholder: UIImage?) async -> Result<UIImage?, Error>
}

public extension UIImageView {
    
    /// 图片获取工具
    var fetcher: ImageFetcher {
        .init(imageView: self)
    }
    
}


public enum ImageFetcherError: Error {
    case missingImplementation
    case missingImageView
    case invalidURL
}
