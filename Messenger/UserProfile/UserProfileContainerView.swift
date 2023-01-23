import UIKit
//
//9. Требование к экрану «Профиль»
//• Должен содержать аватарку пользователя, номер телефона, никнейм, город проживания, дату рождения, знак зодиака по дате рождения, о себе.
//• Все данные пользователя можно получить запросом GET - /api/v1/users/me/.
//• Данные пользователя храним на устройстве, чтобы не делать повторных запросов.
//10. Требования к экрану «Редактировать профиль»
//• Изменение всех данных, кроме phone и username.
//• Изменение аватарки или добавление новой.
//• Сохраняем новые данные на устройстве и отправляем на сервер.
//• Отправка данных запросом PUT - /api/v1/users/me/.
//• Данные аватарки: название файла и сам файл base 64.


// выровнить по знаку =


import UIKit

final class UserProfileContainerView: UIView {

    //MARK: - var\let
    private enum Constants {
        static let space: CGFloat = 10
        static let topSpace: CGFloat = 30
        static let iconHeight: CGFloat = 100
        static let labelHeight: CGFloat = 50
        static let bioMaxCharactersCount = 120
    }

    let iconImageView = ProfileImageView()
    let iconLabel = UILabel()

    let usernameLabel = UILabel()
    let phoneLabel = UILabel()

    let addCityTextField = PasteRestrictedTextField()
    let addBirthdayTextField = PasteRestrictedTextField()
    let zadyakImageView = UIImageView()

    let bioTextView = BioTextView()
    let bioPlaceholderLabel = UILabel()
    let countLabel = UILabel()

    //MARK: - life cycle funcs
    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(iconImageView)
        addSubview(iconLabel)
        addSubview(addCityTextField)
        addSubview(addBirthdayTextField)
        addSubview(zadyakImageView)
        addSubview(bioTextView)
        addSubview(countLabel)
        addSubview(usernameLabel)
        addSubview(phoneLabel)
        bioTextView.addSubview(bioPlaceholderLabel)

        configure()
        configureColors()
        setupConstraints()

        NotificationCenter.default.addObserver(self, selector: #selector(profilePictureDidSet), name: .profilePictureDidSet, object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    //MARK: - objc funcs
    @objc func profilePictureDidSet() {
        if iconImageView.image == nil {
            iconLabel.isHidden = false
        } else {
            iconLabel.isHidden = true
        }
    }
}

private extension UserProfileContainerView {

    //MARK: - flow funcs
    func configure() {
        iconImageView.configureImageView()
        iconImageView.configureBorder(radius: Constants.iconHeight/2)
        iconLabel.configureLabel(with: "Add\nphoto".lacolized(), numberOfLines: 2)

        usernameLabel.configureLabel(with: "Alex")
        phoneLabel.configureLabel(with: "+7(122)371-82-37")

        bioTextView.configureBioTextView()
        bioPlaceholderLabel.configureLabel(with: "Bio")

        addCityTextField.configureTextField(with: "Add city".lacolized())
        addBirthdayTextField.configureTextField(with: "Add birthday".lacolized())
        zadyakImageView.configureImageView()
        zadyakImageView.configureBorder()
    }

    func configureColors() {
        backgroundColor = ThemeManager.currentTheme().generalBackgroundColor
        usernameLabel.textColor = ThemeManager.currentTheme().generalTitleColor
        phoneLabel.textColor = ThemeManager.currentTheme().generalTitleColor
        bioPlaceholderLabel.textColor = ThemeManager.currentTheme().generalSubtitleColor
        iconLabel.textColor = ThemeManager.currentTheme().tintColor
    }

    func setupConstraints() {

        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: Constants.topSpace),
            iconImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: Constants.iconHeight),
            iconImageView.heightAnchor.constraint(equalToConstant: Constants.iconHeight),

            iconLabel.centerXAnchor.constraint(equalTo: iconImageView.centerXAnchor),
            iconLabel.centerYAnchor.constraint(equalTo: iconImageView.centerYAnchor),
            iconLabel.widthAnchor.constraint(equalToConstant: Constants.iconHeight),
            iconLabel.heightAnchor.constraint(equalToConstant: Constants.iconHeight),

            usernameLabel.topAnchor.constraint(equalTo: iconImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: Constants.space),
            usernameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: Constants.labelHeight),

            phoneLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor),
            phoneLabel.leadingAnchor.constraint(equalTo: usernameLabel.leadingAnchor),
            phoneLabel.trailingAnchor.constraint(equalTo: usernameLabel.trailingAnchor),
            phoneLabel.heightAnchor.constraint(equalTo: usernameLabel.heightAnchor),

            addCityTextField.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: Constants.space),
            addCityTextField.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            addCityTextField.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            addCityTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.space),

            zadyakImageView.topAnchor.constraint(equalTo: addCityTextField.bottomAnchor, constant: Constants.space),
            zadyakImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            zadyakImageView.widthAnchor.constraint(equalToConstant: Constants.labelHeight),
            zadyakImageView.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            zadyakImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Constants.space),

            addBirthdayTextField.topAnchor.constraint(equalTo: zadyakImageView.topAnchor),
            addBirthdayTextField.leadingAnchor.constraint(equalTo: zadyakImageView.trailingAnchor, constant: Constants.space),
            addBirthdayTextField.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            addBirthdayTextField.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.space),

            bioTextView.topAnchor.constraint(equalTo: zadyakImageView.bottomAnchor, constant: Constants.space),
            bioTextView.heightAnchor.constraint(equalToConstant: Constants.labelHeight),
            bioTextView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            bioTextView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Constants.space),

//            bioPlaceholderLabel.centerXAnchor.constraint(equalTo: bioTextView.centerXAnchor),
//            bioPlaceholderLabel.centerYAnchor.constraint(equalTo: bioTextView.centerYAnchor),
//
//            countLabel.widthAnchor.constraint(equalToConstant: 30),
//            countLabel.heightAnchor.constraint(equalToConstant: 30),
//            countLabel.trailingAnchor.constraint(equalTo: bioTextView.rightAnchor, constant: -5),
//            countLabel.bottomAnchor.constraint(equalTo: bioTextView.bottomAnchor, constant: -5),
        ])

        bioPlaceholderLabel.font = UIFont.systemFont(ofSize: 20)//(bio.font!.pointSize - 1)
        bioPlaceholderLabel.isHidden = !bioTextView.text.isEmpty
    }
}

final class BioTextView: UITextView {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

    func configureBioTextView(){
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configureBorder()
        self.textAlignment = .left
        self.font = UIFont.systemFont(ofSize: 16)
        self.isScrollEnabled = false
        self.textContainerInset = UIEdgeInsets(top: 15, left: 35, bottom: 15, right: 35)
        self.keyboardAppearance = ThemeManager.currentTheme().keyboardAppearance
        self.backgroundColor = .clear
        self.textColor = ThemeManager.currentTheme().generalTitleColor
        self.indicatorStyle = ThemeManager.currentTheme().scrollBarStyle
        self.textContainer.lineBreakMode = .byTruncatingTail
        self.returnKeyType = .done
    }
}

final class PasteRestrictedTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

    func configureTextField(with text: String){
        self.font = UIFont.systemFont(ofSize: 20)
        self.enablesReturnKeyAutomatically = true
        self.textRect(forBounds: UIEdgeInsets(top: 15, left: 35, bottom: 15, right: 35)) = 
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left

            let placeholder = NSAttributedString(string: text,
                                                                                     attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().generalSubtitleColor])
            self.attributedPlaceholder = placeholder

        self.configureBorder(radius: 25)
        self.autocorrectionType = .no
        self.returnKeyType = .done
        self.keyboardAppearance = ThemeManager.currentTheme().keyboardAppearance
        self.textColor = ThemeManager.currentTheme().generalTitleColor

    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        super.textRect(forBounds: bounds)
        return CGRect.insetBy()

    }

}

final class ProfileImageView: UIImageView {
        override var image: UIImage? {
            didSet {
                NotificationCenter.default.post(name: .profilePictureDidSet, object: nil)
            }
        }
}


/*
 final class BioTextView: UITextView {
 override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
 if action == #selector(UIResponderStandardEditActions.paste(_:)) {
 return false
 }
 return super.canPerformAction(action, withSender: sender)
 }
 }

 final class PasteRestrictedTextField: UITextField {
 override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
 if action == #selector(UIResponderStandardEditActions.paste(_:)) {
 return false
 }
 return super.canPerformAction(action, withSender: sender)
 }
 }

 final class ProfileImageView: UIImageView {
 //    override var image: UIImage? {
 //        didSet {
 //            NotificationCenter.default.post(name: .profilePictureDidSet, object: nil)
 //        }
 //    }
 }

 final class UserProfileContainerView: UIView {

 //MARK: - let\var
 var profileImageView = FalconProfileImageView()
 var addPhotoLabel = UILabel()
 var username = PasteRestrictedTextField()
 var phone = PasteRestrictedTextField()
 var city = PasteRestrictedTextField()
 var birthDate = PasteRestrictedTextField()
 var zadyak = PasteRestrictedTextField()
 var bio = BioTextView()
 var bioPlaceholderLabel = UILabel()
 var userData = UIView()
 var countLabel = UILabel()

 let bioMaxCharactersCount = 120

 //MARK: - life cycle funcs
 override init(frame: CGRect) {
 super.init(frame: frame)

 addSubview(addPhotoLabel)
 addSubview(profileImageView)
 addSubview(userData)
 addSubview(bio)
 addSubview(countLabel)
 userData.addSubview(username)
 userData.addSubview(phone)
 userData.addSubview(city)
 userData.addSubview(birthDate)
 userData.addSubview(zadyak)
 bio.addSubview(bioPlaceholderLabel)


 configure()
 configureColors()
 setupConstraints()
 

 //          NotificationCenter.default.addObserver(self, selector: #selector(profilePictureDidSet), name: .profilePictureDidSet, object: nil)
 }

 deinit {
 NotificationCenter.default.removeObserver(self)
 }

 required init(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)!
 }

 //MARK: - flow funcs
 @objc func profilePictureDidSet() {
 if profileImageView.image == nil {
 addPhotoLabel.isHidden = false
 } else {
 addPhotoLabel.isHidden = true
 }
 }

 fileprivate func configureColors() {
 backgroundColor = ThemeManager.currentTheme().generalBackgroundColor
 addPhotoLabel.textColor = ThemeManager.currentTheme().tintColor
 }

 private func setupConstraints() {
 NSLayoutConstraint.activate([
 profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
 profileImageView.widthAnchor.constraint(equalToConstant: 100),
 profileImageView.heightAnchor.constraint(equalToConstant: 100),

 addPhotoLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
 addPhotoLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
 addPhotoLabel.widthAnchor.constraint(equalToConstant: 100),
 addPhotoLabel.heightAnchor.constraint(equalToConstant: 100),

 userData.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 0),
 userData.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10),
 userData.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0),

 username.topAnchor.constraint(equalTo: userData.topAnchor, constant: 0),
 username.leftAnchor.constraint(equalTo: userData.leftAnchor, constant: 0),
 username.rightAnchor.constraint(equalTo: userData.rightAnchor, constant: 0),
 username.heightAnchor.constraint(equalToConstant: 50),

 phone.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 0),
 phone.leftAnchor.constraint(equalTo: userData.leftAnchor, constant: 0),
 phone.rightAnchor.constraint(equalTo: userData.rightAnchor, constant: 0),
 phone.heightAnchor.constraint(equalToConstant: 50),

 city.topAnchor.constraint(equalTo: phone.bottomAnchor, constant: 0),
 city.leftAnchor.constraint(equalTo: userData.leftAnchor, constant: 0),
 city.rightAnchor.constraint(equalTo: userData.rightAnchor, constant: 0),
 city.heightAnchor.constraint(equalToConstant: 50),

 birthDate.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 0),
 birthDate.leftAnchor.constraint(equalTo: userData.leftAnchor, constant: 0),
 birthDate.rightAnchor.constraint(equalTo: userData.rightAnchor, constant: 0),
 birthDate.heightAnchor.constraint(equalToConstant: 50),

 zadyak.topAnchor.constraint(equalTo: birthDate.bottomAnchor, constant: 0),
 zadyak.leftAnchor.constraint(equalTo: userData.leftAnchor, constant: 0),
 zadyak.rightAnchor.constraint(equalTo: userData.rightAnchor, constant: 0),
 zadyak.heightAnchor.constraint(equalToConstant: 50),

 bio.topAnchor.constraint(equalTo: zadyak.bottomAnchor, constant: 10),

 countLabel.widthAnchor.constraint(equalToConstant: 30),
 countLabel.heightAnchor.constraint(equalToConstant: 30),
 countLabel.rightAnchor.constraint(equalTo: bio.rightAnchor, constant: -5),
 countLabel.bottomAnchor.constraint(equalTo: bio.bottomAnchor, constant: -5),

 bioPlaceholderLabel.centerXAnchor.constraint(equalTo: bio.centerXAnchor, constant: 0),
 bioPlaceholderLabel.centerYAnchor.constraint(equalTo: bio.centerYAnchor, constant: 0)
 ])
 }
 }

 //MARK: - private extension
 private extension UserProfileContainerView {

 func configure() {

 profileImageView = configureProfileImageView()
 addPhotoLabel = configureAddPhotoLabel()
 username = configure(with: "Enter name")
 phone = configureTextField(with: "Phone number")
 city = configureTextField(with: "city")
 birthDate = configureTextField(with: "birthDate")
 zadyak = configureTextField(with: "zadyak")

 bio = configureBio()
 bioPlaceholderLabel = configureBioPlaceholderLabel()

 userData = configureUserData()
 countLabel = configureCountLabel()
 }

 func configureProfileImageView() -> FalconProfileImageView {
 let profileImageView = FalconProfileImageView()
 profileImageView.translatesAutoresizingMaskIntoConstraints = false
 profileImageView.contentMode = .scaleAspectFill
 profileImageView.layer.masksToBounds = true
 profileImageView.layer.borderWidth = 1
 profileImageView.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor
 profileImageView.layer.cornerRadius = 48
 profileImageView.isUserInteractionEnabled = true

 return profileImageView
 }
 
 func configureTextField(with text: String) -> PasteRestrictedTextField {
 let textField = PasteRestrictedTextField()
 textField.font = UIFont.systemFont(ofSize: 20)
 textField.enablesReturnKeyAutomatically = true
 textField.translatesAutoresizingMaskIntoConstraints = false
 textField.textAlignment = .center

 let placeholder = NSAttributedString(string: text,
 attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().generalSubtitleColor])
 textField.attributedPlaceholder = placeholder

 textField.borderStyle = .none
 textField.autocorrectionType = .no
 textField.returnKeyType = .done
 textField.keyboardAppearance = ThemeManager.currentTheme().keyboardAppearance
 textField.textColor = ThemeManager.currentTheme().generalTitleColor

 return textField
 }

 func configureBio() -> BioTextView{
 let bio = BioTextView()
 bio.translatesAutoresizingMaskIntoConstraints = false
 bio.layer.cornerRadius = 28
 bio.layer.borderWidth = 1
 bio.textAlignment = .center
 bio.font = UIFont.systemFont(ofSize: 16)
 bio.isScrollEnabled = false
 bio.textContainerInset = UIEdgeInsets(top: 15, left: 35, bottom: 15, right: 35)
 bio.keyboardAppearance = ThemeManager.currentTheme().keyboardAppearance
 bio.backgroundColor = .clear
 bio.textColor = ThemeManager.currentTheme().generalTitleColor
 bio.indicatorStyle = ThemeManager.currentTheme().scrollBarStyle
 bio.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor
 bio.textContainer.lineBreakMode = .byTruncatingTail
 bio.returnKeyType = .done

 return bio
 }

 func configureUserData() -> UIView {
 let userData = UIView()
 userData.translatesAutoresizingMaskIntoConstraints = false
 userData.layer.cornerRadius = 30
 userData.layer.borderWidth = 1
 userData.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor

 return userData
 }


 func configureAddPhotoLabel() -> UILabel {
 let addPhotoLabel = UILabel()
 addPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
 addPhotoLabel.text = "Add\nphoto"
 addPhotoLabel.numberOfLines = 2
 addPhotoLabel.textAlignment = .center

 return addPhotoLabel
 }

 func configureBioPlaceholderLabel() -> UILabel {
 let bioPlaceholderLabel = UILabel()
 bioPlaceholderLabel.text = "Bio"
 bioPlaceholderLabel.sizeToFit()
 bioPlaceholderLabel.textAlignment = .center
 bioPlaceholderLabel.backgroundColor = .clear
 bioPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
 bioPlaceholderLabel.textColor = ThemeManager.currentTheme().generalSubtitleColor

 return bioPlaceholderLabel
 }

 func configureCountLabel() -> UILabel {
 let countLabel = UILabel()
 countLabel.translatesAutoresizingMaskIntoConstraints = false
 countLabel.sizeToFit()
 countLabel.textColor = ThemeManager.currentTheme().generalSubtitleColor
 countLabel.isHidden = true

 return countLabel
 }
 }
 */






















/*
 import UIKit

 final class BioTextView: UITextView {
 override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
 if action == #selector(UIResponderStandardEditActions.paste(_:)) {
 return false
 }
 return super.canPerformAction(action, withSender: sender)
 }
 }

 final class PasteRestrictedTextField: UITextField {
 override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
 if action == #selector(UIResponderStandardEditActions.paste(_:)) {
 return false
 }
 return super.canPerformAction(action, withSender: sender)
 }
 }

 final class FalconProfileImageView: UIImageView {
 //    override var image: UIImage? {
 //        didSet {
 //            NotificationCenter.default.post(name: .profilePictureDidSet, object: nil)
 //        }
 //    }
 }

 final class UserProfileContainerView: UIView {

 lazy var profileImageView: FalconProfileImageView = {
 let profileImageView = FalconProfileImageView()
 profileImageView.translatesAutoresizingMaskIntoConstraints = false
 profileImageView.contentMode = .scaleAspectFill
 profileImageView.layer.masksToBounds = true
 profileImageView.layer.borderWidth = 1
 profileImageView.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor
 profileImageView.layer.cornerRadius = 48
 profileImageView.isUserInteractionEnabled = true

 return profileImageView
 }()

 let addPhotoLabel: UILabel = {
 let addPhotoLabel = UILabel()
 addPhotoLabel.translatesAutoresizingMaskIntoConstraints = false
 addPhotoLabel.text = "Add\nphoto"
 addPhotoLabel.numberOfLines = 2
 addPhotoLabel.textAlignment = .center

 return addPhotoLabel
 }()

 var name: PasteRestrictedTextField = {
 let name = PasteRestrictedTextField()
 name.font = UIFont.systemFont(ofSize: 20)
 name.enablesReturnKeyAutomatically = true
 name.translatesAutoresizingMaskIntoConstraints = false
 name.textAlignment = .center

 let placeholder = NSAttributedString(string: "Enter name",
 attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().generalSubtitleColor])
 name.attributedPlaceholder = placeholder

 name.borderStyle = .none
 name.autocorrectionType = .no
 name.returnKeyType = .done
 name.keyboardAppearance = ThemeManager.currentTheme().keyboardAppearance
 name.textColor = ThemeManager.currentTheme().generalTitleColor

 return name
 }()

 let phone: PasteRestrictedTextField = {
 let phone = PasteRestrictedTextField()
 phone.font = UIFont.systemFont(ofSize: 20)
 phone.translatesAutoresizingMaskIntoConstraints = false
 phone.textAlignment = .center
 phone.keyboardType = .numberPad
 let placeholder = NSAttributedString(string: "Phone number",
 attributes: [NSAttributedString.Key.foregroundColor: ThemeManager.currentTheme().generalSubtitleColor])
 phone.attributedPlaceholder = placeholder

 phone.borderStyle = .none
 phone.isEnabled = false
 phone.textColor = ThemeManager.currentTheme().generalSubtitleColor
 phone.keyboardAppearance = ThemeManager.currentTheme().keyboardAppearance

 return phone
 }()

 let bioPlaceholderLabel: UILabel = {
 let bioPlaceholderLabel = UILabel()
 bioPlaceholderLabel.text = "Bio"
 bioPlaceholderLabel.sizeToFit()
 bioPlaceholderLabel.textAlignment = .center
 bioPlaceholderLabel.backgroundColor = .clear
 bioPlaceholderLabel.translatesAutoresizingMaskIntoConstraints = false
 bioPlaceholderLabel.textColor = ThemeManager.currentTheme().generalSubtitleColor

 return bioPlaceholderLabel
 }()

 let userData: UIView = {
 let userData = UIView()
 userData.translatesAutoresizingMaskIntoConstraints = false
 userData.layer.cornerRadius = 30
 userData.layer.borderWidth = 1
 userData.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor

 return userData
 }()

 let bio: BioTextView = {
 let bio = BioTextView()
 bio.translatesAutoresizingMaskIntoConstraints = false
 bio.layer.cornerRadius = 28
 bio.layer.borderWidth = 1
 bio.textAlignment = .center
 bio.font = UIFont.systemFont(ofSize: 16)
 bio.isScrollEnabled = false
 bio.textContainerInset = UIEdgeInsets(top: 15, left: 35, bottom: 15, right: 35)
 bio.keyboardAppearance = ThemeManager.currentTheme().keyboardAppearance
 bio.backgroundColor = .clear
 bio.textColor = ThemeManager.currentTheme().generalTitleColor
 bio.indicatorStyle = ThemeManager.currentTheme().scrollBarStyle
 bio.layer.borderColor = ThemeManager.currentTheme().inputTextViewColor.cgColor
 bio.textContainer.lineBreakMode = .byTruncatingTail
 bio.returnKeyType = .done

 return bio
 }()

 let countLabel: UILabel = {
 let countLabel = UILabel()
 countLabel.translatesAutoresizingMaskIntoConstraints = false
 countLabel.sizeToFit()
 countLabel.textColor = ThemeManager.currentTheme().generalSubtitleColor
 countLabel.isHidden = true

 return countLabel
 }()

 let bioMaxCharactersCount = 70


 fileprivate func configureColors() {
 backgroundColor = ThemeManager.currentTheme().generalBackgroundColor
 addPhotoLabel.textColor = ThemeManager.currentTheme().tintColor
 }

 override init(frame: CGRect) {
 super.init(frame: frame)

 addSubview(addPhotoLabel)
 addSubview(profileImageView)
 addSubview(userData)
 addSubview(bio)
 addSubview(countLabel)
 userData.addSubview(name)
 userData.addSubview(phone)
 bio.addSubview(bioPlaceholderLabel)

 configureColors()

 //        NotificationCenter.default.addObserver(self, selector: #selector(profilePictureDidSet), name: .profilePictureDidSet, object: nil)

 NSLayoutConstraint.activate([
 profileImageView.topAnchor.constraint(equalTo: topAnchor, constant: 30),
 profileImageView.widthAnchor.constraint(equalToConstant: 100),
 profileImageView.heightAnchor.constraint(equalToConstant: 100),

 addPhotoLabel.centerXAnchor.constraint(equalTo: profileImageView.centerXAnchor),
 addPhotoLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
 addPhotoLabel.widthAnchor.constraint(equalToConstant: 100),
 addPhotoLabel.heightAnchor.constraint(equalToConstant: 100),

 userData.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 0),
 userData.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 10),
 userData.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0),

 name.topAnchor.constraint(equalTo: userData.topAnchor, constant: 0),
 name.leftAnchor.constraint(equalTo: userData.leftAnchor, constant: 0),
 name.rightAnchor.constraint(equalTo: userData.rightAnchor, constant: 0),
 name.heightAnchor.constraint(equalToConstant: 50),

 phone.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 0),
 phone.leftAnchor.constraint(equalTo: userData.leftAnchor, constant: 0),
 phone.rightAnchor.constraint(equalTo: userData.rightAnchor, constant: 0),
 phone.heightAnchor.constraint(equalToConstant: 50),

 bio.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 10),

 countLabel.widthAnchor.constraint(equalToConstant: 30),
 countLabel.heightAnchor.constraint(equalToConstant: 30),
 countLabel.rightAnchor.constraint(equalTo: bio.rightAnchor, constant: -5),
 countLabel.bottomAnchor.constraint(equalTo: bio.bottomAnchor, constant: -5),

 bioPlaceholderLabel.centerXAnchor.constraint(equalTo: bio.centerXAnchor, constant: 0),
 bioPlaceholderLabel.centerYAnchor.constraint(equalTo: bio.centerYAnchor, constant: 0)
 ])

 bioPlaceholderLabel.font = UIFont.systemFont(ofSize: 20)//(bio.font!.pointSize - 1)
 bioPlaceholderLabel.isHidden = !bio.text.isEmpty

 if #available(iOS 11.0, *) {
 NSLayoutConstraint.activate([
 profileImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
 bio.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
 bio.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
 userData.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10)
 ])
 } else {
 NSLayoutConstraint.activate([
 profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
 bio.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
 bio.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
 userData.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
 ])
 }
 }

 deinit {
 NotificationCenter.default.removeObserver(self)
 }

 required init(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)!
 }

 @objc func profilePictureDidSet() {
 if profileImageView.image == nil {
 addPhotoLabel.isHidden = false
 } else {
 addPhotoLabel.isHidden = true
 }
 }
 }

 */
