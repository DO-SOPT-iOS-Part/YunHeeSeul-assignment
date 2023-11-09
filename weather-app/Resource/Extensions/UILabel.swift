import UIKit

extension UILabel{
    public func setLabel(font: UIFont ,bgColor: UIColor, textColor: UIColor ,text: String, textAlignment: NSTextAlignment) {
        self.text = text
        self.font = font
        self.textColor = textColor
        self.textAlignment = textAlignment
        self.adjustsFontSizeToFitWidth = true
    }
}
