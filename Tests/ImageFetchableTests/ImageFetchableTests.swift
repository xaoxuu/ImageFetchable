import Testing
import UIKit
@testable import ImageFetchable

extension ImageFetchable: ImageFetchable_UIButton {
    public func fetchButtonImage(_ button: UIButton, imageName: String?, for state: UIControl.State) async -> Result<UIImage?, any Error> {
        <#code#>
    }
    
    public func fetchButtonImage(_ button: UIButton, imageURL: URL?, placeholder: UIImage?, for state: UIControl.State) async -> Result<UIImage?, any Error> {
        <#code#>
    }
}

@Test func example() async throws {
    // Write your test here and use APIs like `#expect(...)` to check expected conditions.
    
    let imageURLStr = "https://avatars.githubusercontent.com/u/16400144?s=48&v=4"
    let imageName = "xxx"
    let urlStringOrImageName = ""
    
    let imgv = await UIImageView()
    let btn = await UIButton()
    
    // ---- UIImageView ----
    // 设置网络图片（字符串）
    await imgv.fetcher.setImage(imageURLStr)
    // 设置网络图片（URL）
    await imgv.fetcher.setImage(URL(string: imageURLStr))
    // 设置本地图片（和网络图片用法一致）
    await imgv.fetcher.setImage(imageName)
    
    // ---- UIButton ----
    // 设置网络图片（字符串）
    await btn.fetcher?.setImage(imageURLStr, for: .highlighted)
    // 设置网络图片（字符串，可不传 state 默认设为 normal）
    await btn.fetcher?.setImage(imageURLStr)
    // 设置网络图片（URL）
    await btn.fetcher?.setImage(URL(string: imageURLStr))
    
    // 语法糖：省略 .fetcher 的写法
    await imgv.setImage(urlStringOrImageName)
    await btn.setImage(urlStringOrImageName)
    
}
