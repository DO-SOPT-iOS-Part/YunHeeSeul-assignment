import UIKit

enum FontName: String{
    case bold = "SFProDisplay-Bold"
    case semiBold = "SFProDisplay-Semibold"
    case regular = "SFProDisplay-Regular"
    case medium = "SFProDisplay-Medium"
    case light = "SFProDisplay-Light"
    case thin = "SFProDisplay-Thin"
    
    var fontName: String {
        return self.rawValue
    }
}

extension UIFont {
    class func bold(size: CGFloat)-> UIFont{
        return UIFont(name: FontName.bold.rawValue, size: size)!
    }
    class func semibold(size: CGFloat)-> UIFont{
        return UIFont(name: FontName.semiBold.rawValue, size: size)!
    }
    class func regular(size: CGFloat)-> UIFont{
        return UIFont(name: FontName.regular.rawValue, size: size)!
    }
    class func medium(size: CGFloat)-> UIFont{
        return UIFont(name: FontName.medium.rawValue, size: size)!
    }
    class func light(size: CGFloat)-> UIFont{
        return UIFont(name: FontName.light.rawValue, size: size)!
    }
    class func thin(size: CGFloat)-> UIFont{
        return UIFont(name: FontName.thin.rawValue, size: size)!
    }
}
