//
//  UITextField+Extensions.swift
//  weather-app
//
//  Created by 윤희슬 on 2023/10/24.
//

import UIKit

extension UITextField {
  func addLeftPadding() {
    let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: self.frame.height))
    self.leftView = paddingView
    self.leftViewMode = ViewMode.always
  }
}
