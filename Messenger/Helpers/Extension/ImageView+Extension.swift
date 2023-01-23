import UIKit

extension UIImageView {

    func configureImageView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        self.isUserInteractionEnabled = true
    }
}
