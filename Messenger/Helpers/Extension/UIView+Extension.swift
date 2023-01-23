import UIKit

extension UIView {

    func configureBorder(radius: CGFloat = 30){
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 1
        self.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor
    }
}
