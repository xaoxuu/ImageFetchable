# ImageFetchable

图片拉取协议，使组件库可以不依赖具体的网络库

组件库中这样设置图片：

```swift
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
```

集成组件的工程实现协议：

```swift
import ImageFetchable
import 任意网络库工具

extension ImageFetchable: ImageFetchable_UIImageView {
    public func fetchImage(_ imageView: UIImageView, imageName: String?) async -> Result<UIImage?, any Error> {
        <#code#>
    }
    
    public func fetchImage(_ imageView: UIImageView, imageURL: URL?, placeholder: UIImage?) async -> Result<UIImage?, any Error> {
        <#code#>
    }
}

extension ImageFetchable: ImageFetchable_UIButton {
    public func fetchButtonImage(_ button: UIButton, imageName: String?, for state: UIControl.State) async -> Result<UIImage?, any Error> {
        <#code#>
    }
    
    public func fetchButtonImage(_ button: UIButton, imageURL: URL?, placeholder: UIImage?, for state: UIControl.State) async -> Result<UIImage?, any Error> {
        <#code#>
    }
}
```
