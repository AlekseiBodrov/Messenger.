import UIKit

extension UILabel {

    func configureLabel(with text: String,numberOfLines: Int = 1){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.text = text.lacolized()
        self.backgroundColor = .clear
        self.numberOfLines = numberOfLines
        self.textAlignment = .center
        self.sizeToFit()
    }
}
