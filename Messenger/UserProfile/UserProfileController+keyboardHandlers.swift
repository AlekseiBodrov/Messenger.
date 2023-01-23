import UIKit

extension UIViewController {
 final func hideKeyboardWhenTappedAround() {
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                             action: #selector(UIViewController.dismissKeyboard))
    view.addGestureRecognizer(tap)
  }

  @objc final func dismissKeyboard() {
    view.endEditing(true)
  }
}
