import Foundation
import UIKit

extension UIFont {
    static func yarin(ofSize size: CGFloat) -> UIFont {
        let font = UIFont(name: "Yarin", size: size)
         ?? .systemFont(ofSize: size)
        
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
}
