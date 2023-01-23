import UIKit

final class UserProfileController: UIViewController {

  let userProfileContainerView = UserProfileContainerView()
//  let avatarOpener = AvatarOpener()
//  let userProfileDataDatabaseUpdater = UserProfileDataDatabaseUpdater()
//  let phoneNumberKit = PhoneNumberKit()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//      view.backgroundColor = ThemeManager.currentTheme().generalBackgroundColor

      configureNavigationBar()
      configureContainerView()
      configureColorsAccordingToTheme()
    }

    fileprivate func configureNavigationBar() {
      extendedLayoutIncludesOpaqueBars = true
      let rightBarButton = UIBarButtonItem(title: "Done", style: .done, target: self,
                                           action: #selector(rightBarButtonDidTap))
      navigationItem.rightBarButtonItem = rightBarButton
      navigationItem.title = "Profile"
      navigationItem.setHidesBackButton(true, animated: true)
    }

    fileprivate func configureContainerView() {

      view.addSubview(userProfileContainerView)
      userProfileContainerView.translatesAutoresizingMaskIntoConstraints = false
      userProfileContainerView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
      userProfileContainerView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
      userProfileContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
      userProfileContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

      userProfileContainerView.iconImageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                                            action: #selector(openUserProfilePicture)))
//      userProfileContainerView.username.delegate = self
    }

    private func configureColorsAccordingToTheme() {
      userProfileContainerView.iconImageView.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor
//      userProfileContainerView.userData.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor
//      userProfileContainerView.username.textColor = ThemeManager.currentTheme().generalTitleColor
//      userProfileContainerView.username.keyboardAppearance = ThemeManager.currentTheme().keyboardAppearance
    }

    @objc private func openUserProfilePicture() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension UserProfileController {

  @objc func rightBarButtonDidTap () {
//   userProfileContainerView.name.resignFirstResponder()
//    if userProfileContainerView.name.text?.count == 0 ||
//       userProfileContainerView.name.text!.trimmingCharacters(in: .whitespaces).isEmpty {
//       userProfileContainerView.name.shake()
//    } else {

//      if currentReachabilityStatus == .notReachable {
//        basicErrorAlertWith(title: "No internet connection", message: noInternetError, controller: self)
//        return
//      }

//      updateUserData()

//      if Messaging.messaging().fcmToken != nil {
//        setUserNotificationToken(token: Messaging.messaging().fcmToken!)
//      }
//
//      setOnlineStatus()
//    }
  }
/*
  fileprivate func preparedPhoneNumber() -> String {

    guard let number = userProfileContainerView.phone.text else {
      return userProfileContainerView.phone.text!
    }

    var preparedNumber = String()

      do {
        let countryCode = try self.phoneNumberKit.parse(number).countryCode
        let nationalNumber = try self.phoneNumberKit.parse(number).nationalNumber
        preparedNumber = ("+" + String(countryCode) + String(nationalNumber))
      } catch {
        return number
    }
    return preparedNumber
  }


  func updateUserData() {
    guard let currentUID = Auth.auth().currentUser?.uid else { return }
    ARSLineProgress.ars_showOnView(self.view)

    let phoneNumber = preparedPhoneNumber()
    let userReference = Database.database().reference().child("users").child(currentUID)
    userReference.updateChildValues(["name": userProfileContainerView.name.text ?? "",
                                     "phoneNumber": phoneNumber,
                                     "bio": userProfileContainerView.bio.text ?? ""]) { (_, _) in
      ARSLineProgress.hide()

      if DeviceType.isIPad {
        let tabBarController = GeneralTabBarController()
        self.splitViewController?.show(tabBarController, sender: self)
      } else {
        self.dismiss(animated: true) {
          AppUtility.lockOrientation(.allButUpsideDown)
        }
      }
    }
  }
 */
}

extension UserProfileController: UITextViewDelegate {

  func textViewDidBeginEditing(_ textView: UITextView) {
    userProfileContainerView.countLabel.isHidden = false
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    userProfileContainerView.countLabel.isHidden = true
  }

  func textViewDidChange(_ textView: UITextView) {
//    if textView.isFirstResponder && textView.text == "" {
//      userProfileContainerView.bioPlaceholderLabel.isHidden = true
//    } else {
//      userProfileContainerView.bioPlaceholderLabel.isHidden = !textView.text.isEmpty
//    }
//    userProfileContainerView.countLabel.text = "\(userProfileContainerView.bioMaxCharactersCount - textView.text.count)"
  }
/*
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

    if text == "\n" {
      textView.resignFirstResponder()
      return false
    }

    return textView.text.count + (text.count - range.length) <= userProfileContainerView.bioMaxCharactersCount
  }
 */
}

extension UserProfileController: UITextFieldDelegate {

  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}

extension UserProfileController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.userProfileContainerView.iconImageView.image = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.userProfileContainerView.iconImageView.image  = image
        }
        picker.dismiss(animated: true)
    }
}

