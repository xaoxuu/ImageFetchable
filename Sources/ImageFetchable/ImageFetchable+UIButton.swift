//
//  File.swift
//  
//
//  Created by xaoxuu on 2024/7/17.
//

import UIKit

public extension ImageFetchable where T == UIButton {
    
    var imp: ImageFetchableUIButton? { self as? ImageFetchableUIButton }
    
    /// 设置图片
    /// - Parameter urlStringOrImageName: 网络图片地址或本地图片素材名
    @discardableResult
    func setImage(_ urlStringOrImageName: String, for state: UIControl.State = .normal) async -> Result<UIImage?, Error> {
        guard urlStringOrImageName.count > 0 else { return .failure(ImageFetchError.invalidURL) }
        if urlStringOrImageName.contains("://") {
            return await setImage(.init(string: urlStringOrImageName), placeholder: nil, for: state)
        } else {
            guard let imp else { return .failure(ImageFetchError.missingImplementation) }
            return await imp.fetchButtonImage(sourceType, imageName: urlStringOrImageName, for: state)
        }
    }
    
    /// 设置网络图片
    /// - Parameters:
    ///   - url: 网络图片地址
    ///   - placeholder: 占位图
    @discardableResult
    func setImage(_ url: URL?, placeholder: UIImage? = nil, for state: UIControl.State = .normal) async -> Result<UIImage?, Error> {
        guard let imp else { return .failure(ImageFetchError.missingImplementation) }
        return await imp.fetchButtonImage(sourceType, imageURL: url, placeholder: placeholder, for: state)
    }
    
    /// 设置图片
    /// - Parameter urlStringOrImageName: 网络图片地址或本地图片素材名
    func setImage(_ urlStringOrImageName: String, for state: UIControl.State = .normal) {
        Task {
            await setImage(urlStringOrImageName, for: state)
        }
    }
    
    /// 设置网络图片
    /// - Parameters:
    ///   - url: 网络图片地址
    ///   - placeholder: 占位图
    func setImage(_ url: URL?, placeholder: UIImage? = nil, for state: UIControl.State = .normal) {
        Task {
            await setImage(url, placeholder: placeholder, for: state)
        }
    }
    
}

public protocol ImageFetchableUIButton {
    /// 设置本地图片
    @MainActor func fetchButtonImage(_ button: UIButton, imageName: String, for state: UIControl.State) async -> Result<UIImage?, Error>
    /// 设置网络图片
    @MainActor func fetchButtonImage(_ button: UIButton, imageURL: URL?, placeholder: UIImage?, for state: UIControl.State) async -> Result<UIImage?, Error>
}

public extension UIButton {
    
    /// 图片获取工具
    var fetcher: ImageFetchable<UIButton>? {
        .init(sourceType: self)
    }
    
    func setImage(_ urlStringOrImageName: String, for state: UIControl.State = .normal) {
        fetcher?.setImage(urlStringOrImageName, for: state)
    }
    
    func setImage(_ url: URL, placeholder: UIImage? = nil, for state: UIControl.State = .normal) {
        fetcher?.setImage(url, placeholder: placeholder, for: state)
    }
    
}
