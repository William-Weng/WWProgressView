//
//  Protocol.swift
//  WWProgressView
//
//  Created by William Weng on 2025/10/11.
//

import UIKit

public extension WWProgressView {
    
    // MARK: - WWProgressView.Delegate
    protocol Delegate: AnyObject {
        
        /// 取得目前進度 (0% ~ 100%)
        /// - Parameter progressView: WWProgressView
        /// - Returns: Double
        func percentage(_ progressView: WWProgressView) -> Double
    }
}
