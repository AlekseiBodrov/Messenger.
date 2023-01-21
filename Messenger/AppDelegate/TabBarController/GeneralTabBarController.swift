import UIKit

enum Tabs: Int {
  case contacts = 0
  case chats = 1
  case settings = 2
}

class CurrentTab {
    static let shared = CurrentTab()
    var index = 0

}
class GeneralTabBarController: UITabBarController {

}
