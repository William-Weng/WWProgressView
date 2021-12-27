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
    
    private var percentage: Double = 0.0
    private var timer: CADisplayLink?
    private var startAngle: Int = 0
    
    override func viewDidLoad() { super.viewDidLoad() }
    
    @IBAction func running(_ sender: UIButton) { update() }
    
    /// 使用定時器更新 (CADisplayLink)
    func update() {
        timer = CADisplayLink(target: self, selector: #selector(updatePercentage))
        timer?.preferredFramesPerSecond = 60
        timer?._fire()
    }
    
    /// 更新進度條 (高度)
    /// - Parameter sender: CADisplayLink
    @objc private func updatePercentage(_ sender: CADisplayLink) {
        
        let height = myProgressView.frame.height * percentage / 100
        
        myProgressView.updateHeight(height, radius: 4.0, startAngle: startAngle % 360)
        startAngle += 5
        percentage += 0.1
    }
}
