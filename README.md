# WWProgressView
[![Swift-5.6](https://img.shields.io/badge/Swift-5.6-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-14.0](https://img.shields.io/badge/iOS-14.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWProgressView) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- A dynamically flowing progress bar.
- 一個動態流動的進度條.

![](./Example.gif)

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)

```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWProgressView.git", .upToNextMajor(from: "1.1.0"))
]
```
![](./IBDesignable.png)

### Function - 可用函式
|函式|功能|
|-|-|
|settings(fps:radius:startAngle:angleSpeed:count:delegate:)|基本參數設定|
|running()|開始更新|
|stop()|停止更新|

### WWProgressViewDelegate
|函式|功能|
|-|-|
|percentage(_:)|取得目前進度 (0% ~ 100%)|

### Example
```swift
import UIKit
import WWProgressView

final class ViewController: UIViewController {

    @IBOutlet weak var myProgressView: WWProgressView!
    
    private var percentage: Double = 0
    private var timer: Timer? = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func running(_ sender: UIButton) { runningAction() }
    
    @objc func timerAction(timer: Timer) { timerAction() }
}

extension ViewController: WWProgressViewDelegate {
    
    func percentage(_ progressView: WWProgressView) -> Double {
        return percentage
    }
}

private extension ViewController {
    
    func initSetting() {
        myProgressView.settings(fps: 60, radius: 5, startAngle: 0, angleSpeed: 3, count: 5, delegate: self)
    }
    
    func runningAction() {
        
        percentage = 60
        myProgressView.running()
        
        timer?.invalidate()
        timer = nil
        timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Self.timerAction(timer:)), userInfo: nil, repeats: true)
    }
    
    func timerAction() {
        
        if (percentage > 100.0) {
            timer?.invalidate()
            timer = nil
            myProgressView.stop()
            return
        }
        
        percentage += 0.5
    }
}
```
