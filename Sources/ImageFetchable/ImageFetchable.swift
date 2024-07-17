// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

// 本工具的意义在于使组件库不依赖具体的网络图片实现工具，面向协议开发。
// 顺便统一图片设置方式，使得本地图片也可以通过本协议的接口设置。
public struct ImageFetchable<T> {
    
    /// UIImageView / UIButton ...
    let sourceType: T
    
    /// 创建一个实例
    /// - Parameter sourceType: UIImageView / UIButton ...
    init(sourceType: T) {
        self.sourceType = sourceType
    }
    
}


public enum ImageFetchError: Error {
    case missingImplementation
    case invalidURL
}
