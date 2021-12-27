//
//  ProgressView.swift
//  WWProgressView
//
//  Created by William.Weng on 2021/12/27.
//

import UIKit

// MARK: - 動態的進度條
open class WWProgressView: UIView {
    
    @IBInspectable var fullImage: UIImage = UIImage()
    @IBInspectable var progressImage: UIImage = UIImage()
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var progressImageView: UIImageView!
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initViewFromXib()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initViewFromXib()
    }
    
    override public func draw(_ rect: CGRect) {
        
        initSetting()
        updateHeight()
        
        #if TARGET_INTERFACE_BUILDER
        #endif
    }
    
    /// [IB Designables: Failed to render and update auto layout status](https://stackoverflow.com/questions/46723683/ib-designables-failed-to-render-and-update-auto-layout-status)
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        contentView.prepareForInterfaceBuilder()
    }
}

// MARK: - 公開function
extension WWProgressView {
    
    /// [更新百分比](https://www.hangge.com/blog/cache/detail_2278.html)
    /// - Parameters:
    ///   - height: [整體的高度](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-cashapelayer-將-view-變成任意形狀-da7e5b700c70)
    ///   - radius: [弦波的半徑](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/將-view-變成任意形狀的三種方法-d43e6e4b8fb5)
    ///   - startAngle: [弦波的起始角度](https://www.jianshu.com/p/3e0e25fd9b85)
    ///   - count: [弦波的數量](https://zh.wikipedia.org/zh-tw/三角函数)
    public func updateHeight(_ height: Double = 0, radius: Double = 10.0, startAngle: Int = 0, count: Double = 1.0) {
        
        let maskLayer = CAShapeLayer()
        let path = waveBezierPathMaker(at: contentView, height: height, radius: radius, startAngle: startAngle, count: count)
        
        maskLayer.frame = contentView.frame
        maskLayer.path = path.cgPath
        
        fullImageView.layer.mask = maskLayer
    }
}

// MARK: - 小工具
extension WWProgressView {
    
    /// 讀取Nib畫面 => 加到View上面
    private func initViewFromXib() {
        
        let bundle = Bundle.module
        let name = String(describing: Self.self)
        
        bundle.loadNibNamed(name, owner: self, options: nil)
        contentView.frame = bounds
        
        addSubview(contentView)
    }
    
    /// 初始化設定
    private func initSetting() {
        self.fullImageView.image = fullImage
        self.progressImageView.image = progressImage
    }
    
    /// [弦波路徑產生器](https://www.hangge.com/blog/cache/detail_2278.html)
    /// - Parameters:
    ///   - contentView: [UIView](https://www.jianshu.com/p/3e0e25fd9b85)
    ///   - height: [整體的高度](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/利用-cashapelayer-將-view-變成任意形狀-da7e5b700c70)
    ///   - radius: [弦波的半徑](https://medium.com/彼得潘的-swift-ios-app-開發問題解答集/將-view-變成任意形狀的三種方法-d43e6e4b8fb5)
    ///   - startAngle: 弦波的起始角度
    ///   - count: [弦波的數量](https://zh.wikipedia.org/zh-tw/三角函数)
    /// - Returns: UIBezierPath
    private func waveBezierPathMaker(at contentView: UIView, height: Double = 100.0, radius: Double = 8.0, startAngle: Int = 90, count: Double = 1.0) -> UIBezierPath {
        
        let path = UIBezierPath()
        let size = contentView.bounds.size
        
        path.move(to: CGPoint(x: size.width, y: size.height - height))
        path.addLine(to: CGPoint(x: size.width, y: size.height))
        path.addLine(to: CGPoint(x: 0, y: size.height))
        path.addLine(to: CGPoint(x: 0, y: size.height - height))
        
        for angle in 0...Int(size.width) {
            let scale = sin(Double(angle + startAngle)._radian() * count)
            let nextPoint = CGPoint(x: 0 + CGFloat(angle), y: size.height - height - radius * scale)
            path.addLine(to: nextPoint)
        }
        
        return path
    }
}
