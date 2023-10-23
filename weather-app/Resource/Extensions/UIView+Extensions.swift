//
//  UIView+Extensions.swift
//  weather-app
//
//  Created by 윤희슬 on 2023/10/24.
//

import UIKit

extension UIView {
    public func addSubViews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
    }
}
