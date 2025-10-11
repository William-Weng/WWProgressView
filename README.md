# WWProgressView
[![Swift-5.7](https://img.shields.io/badge/Swift-5.7-orange.svg?style=flat)](https://developer.apple.com/swift/) [![iOS-16.0](https://img.shields.io/badge/iOS-16.0-pink.svg?style=flat)](https://developer.apple.com/swift/) ![TAG](https://img.shields.io/github/v/tag/William-Weng/WWProgressView) [![Swift Package Manager-SUCCESS](https://img.shields.io/badge/Swift_Package_Manager-SUCCESS-blue.svg?style=flat)](https://developer.apple.com/swift/) [![LICENSE](https://img.shields.io/badge/LICENSE-MIT-yellow.svg?style=flat)](https://developer.apple.com/swift/)

### [Introduction - 簡介](https://swiftpackageindex.com/William-Weng)
- A dynamically flowing progress bar.
- 一個動態流動的進度條.

https://github.com/user-attachments/assets/361d7f9a-b046-44d7-bba8-d6a1dd6fa727

### [Installation with Swift Package Manager](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/使用-spm-安裝第三方套件-xcode-11-新功能-2c4ffcf85b4b)

```bash
dependencies: [
    .package(url: "https://github.com/William-Weng/WWProgressView.git", .upToNextMajor(from: "1.2.0"))
]
```

### Function - 可用函式
|函式|功能|
|-|-|
|settings(delegate:fullImage:progressImage:fps:radius:startAngle:angleSpeed:count:)|基本參數設定|
|running()|開始更新|
|stop()|停止更新|

### WWProgressView.Delegate
|函式|功能|
|-|-|
|percentage(_:)|取得目前進度 (0% ~ 100%)|

### Example
```swift
import UIKit
import WWProgressView

final class ViewController: UIViewController {

    @IBOutlet weak var myProgressView: WWProgressView!
    @IBOutlet weak var myButton: UIButton!
    
    private var percentage: Double = 0
    private var timer: Timer? = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        initSetting()
    }
    
    @IBAction func running(_ sender: UIButton) { runningAction() }
    
    @objc func timerAction(timer: Timer) { timerAction() }
}

// MARK: - WWProgressView.Delegate
extension ViewController: WWProgressView.Delegate {
    
    func percentage(_ progressView: WWProgressView) -> Double {
        return percentage
    }
}

// MARK: - 小工具
private extension ViewController {
    
    /// 初始化設定
    func initSetting() {
        myProgressView.settings(delegate: self, fullImage: UIImage(named: "FullWater"), progressImage: UIImage(named: "EmptyWater"))
    }
    
    /// 開始更新
    func runningAction() {
        
        percentage = 0
        myProgressView.running()
        
        timer?.invalidate()
        timer = nil
        timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(Self.timerAction(timer:)), userInfo: nil, repeats: true)
    }
    
    /// 更新進度值
    func timerAction() {
        
        if (percentage < 100.0) { percentage += 0.2; return }
        
        timer?.invalidate()
        timer = nil
        myProgressView.stop()
        myButton.setTitle("~裝滿了~", for: .normal)
        myButton.backgroundColor = .black
    }
}
```
