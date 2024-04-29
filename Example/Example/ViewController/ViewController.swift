//
//  ViewController.swift
//  Example
//
//  Created by William.Weng on 2021/9/15.
//  ~/Library/Caches/org.swift.swiftpm/
//  file:///Users/william/Desktop/WWProgressView

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

// MARK: - WWProgressViewDelegate
extension ViewController: WWProgressViewDelegate {
    
    func percentage(_ progressView: WWProgressView) -> Double {
        return percentage
    }
}

// MARK: - 小工具
private extension ViewController {
    
    /// 初始化設定
    func initSetting() {
        myProgressView.settings(delegate: self, fps: 60, radius: 5, startAngle: 0, angleSpeed: 3, count: 5)
    }
    
    /// 開始更新
    func runningAction() {
        
        percentage = 60
        myProgressView.running()
        
        timer?.invalidate()
        timer = nil
        timer = Timer()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Self.timerAction(timer:)), userInfo: nil, repeats: true)
    }
    
    /// 更新進度值
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
