//
//  File.swift
//  
//
//  Created by xaoxuu on 2024/7/17.
//

import UIKit

public extension ImageFetchable where T == UIImageView {
    
    var imp: ImageFetchable_UIImageView? { self as? ImageFetchable_UIImageView }
    
    /// 设置图片
    /// - Parameter urlStringOrImageName: 网络图片地址或本地图片素材名
    @discardableResult
    func setImage(_ urlStringOrImageName: String?) async -> Result<UIImage?, Error> {
        guard let urlStringOrImageName, urlStringOrImageName.count > 0 else { return .failure(ImageFetchError.invalidURL) }
        if urlStringOrImageName.contains("://") {
            return await setImage(.init(string: urlStringOrImageName), placeholder: nil)
        } else {
            guard let imp else { return .failure(ImageFetchError.missingImplementation) }
            return await imp.fetchImage(sourceType, imageName: urlStringOrImageName)
        }
    }
    
    /// 设置网络图片
    /// - Parameters:
    ///   - url: 网络图片地址
    ///   - placeholder: 占位图
    @discardableResult
    func setImage(_ url: URL?, placeholder: UIImage? = nil) async -> Result<UIImage?, Error> {
        guard let imp else { return .failure(ImageFetchError.missingImplementation) }
        return await imp.fetchImage(sourceType, imageURL: url, placeholder: placeholder)
    }
    
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

public protocol ImageFetchable_UIImageView {
    /// 设置本地图片
    @MainActor func fetchImage(_ imageView: UIImageView, imageName: String?) async -> Result<UIImage?, Error>
    /// 设置网络图片
    @MainActor func fetchImage(_ imageView: UIImageView, imageURL: URL?, placeholder: UIImage?) async -> Result<UIImage?, Error>
}

public extension UIImageView {
    
    /// 图片获取工具
    var fetcher: ImageFetchable<UIImageView> {
        .init(sourceType: self)
    }
    
    func setImage(_ urlStringOrImageName: String?) {
        fetcher.setImage(urlStringOrImageName)
    }
    
    func setImage(_ url: URL?, placeholder: UIImage? = nil) {
        fetcher.setImage(url, placeholder: placeholder)
    }
    
}
