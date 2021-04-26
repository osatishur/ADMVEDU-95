//
//  SingInView.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit

protocol SignInDelegate {
    func signInClicked(_ signInView: SignInView)
    func logInClicked(_ signInView: SignInView)
}

class SignInView: UIView, AuthViewBuilder {
    struct Constants {
        static let textFieldInnerSpace: CGFloat = 20
        static let topLabelVerticalSpace: CGFloat = UIScreen.main.bounds.height * 0.1
        static let textFieldWidth: CGFloat = UIScreen.main.bounds.width * 0.8
        static let stackViewSpacing: CGFloat = 20
        static let textFieldHeight: CGFloat = 54
        static let registerButtonWidth: CGFloat = UIScreen.main.bounds.width * 0.6
        static let registerButtonHeight: CGFloat = 54
        static let errorLabelTopPadding: CGFloat = 30
        static let errorLabelWidth: CGFloat = UIScreen.main.bounds.width * 0.6
        static let bottomButtonSidePadding: CGFloat = 32
        static let bottomButtonBottomPadding: CGFloat = 12
        static let bottonButtonHeight: CGFloat = 30
    }
    //MARK: Views
    lazy private var topLabel: UILabel = {
        var label = buildLabel(text: "Registration".localized(),
                               font: UIFont.regularFont)
        return label
    }()
    
    lazy var emailTF: UITextField = {
        var textField = buildTextField(placegolder: "Email".localized(),
                                       isSecureTextEnter: false,
                                       sideWidth: Constants.textFieldInnerSpace)
        return textField
    }()
    
    lazy var passwordTF: UITextField = {
        var textField = buildTextField(placegolder: "Password".localized(),
                                       isSecureTextEnter: true,
                                       sideWidth: Constants.textFieldInnerSpace)
        return textField
    }()
    
    lazy var repeatPasswordTF: UITextField = {
        var textField = buildTextField(placegolder: "Repeat password".localized(),
                                       isSecureTextEnter: true,
                                       sideWidth: Constants.textFieldInnerSpace)
        return textField
    }()
    
    lazy private var registerButton: UIButton = {
        var button = buildButton(title: "Sign in".localized(),
                                 titleColor: .white,
                                 backgroundColor: .systemBlue)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var errorLabel: UILabel = {
        var label = buildLabel(text: "",
                               font: UIFont.subRegularFont)
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    lazy var bottomButton: UIButton = {
        var button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.black])
        attributedTitle.append(NSAttributedString(string: "Log in".localized(), attributes: [NSAttributedString.Key.font: UIFont.regularFont, NSAttributedString.Key.foregroundColor: UIColor.systemBlue]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(logInButtonTapped), for: .touchUpInside)
        return button
    }()
    
    var textFieldsStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.distribution = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    
    var delegate: SignInDelegate?
    //MARK: Life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    //MARK: Setup Layout
    private func setupLayout() {
        self.backgroundColor = .white
        setupSubviews()
        setupTopLabel()
        setupTextFields()
        setupRegisterButton()
        setupErrorLabel()
        setupBottomButton()
    }
    
    private func setupSubviews() {
        addSubview(topLabel)
        addSubview(textFieldsStack)
        addSubview(registerButton)
        addSubview(errorLabel)
        addSubview(bottomButton)
    }
    
    private func setupTopLabel() {
        topLabel.anchor(top: self.topAnchor, paddingTop: Constants.topLabelVerticalSpace)
        topLabel.centerAnchor(centerX: self.centerXAnchor)
    }
    
    private func setupTextFields() {
        emailTF.dimension(width: Constants.textFieldWidth,
                         height: Constants.textFieldHeight)
        passwordTF.dimension(width: Constants.textFieldWidth,
                             height: Constants.textFieldHeight)
        repeatPasswordTF.dimension(width: Constants.textFieldWidth,
                                   height: Constants.textFieldHeight)
        textFieldsStack.addArrangedSubview(emailTF)
        textFieldsStack.addArrangedSubview(passwordTF)
        textFieldsStack.addArrangedSubview(repeatPasswordTF)
        textFieldsStack.anchor(top: topLabel.bottomAnchor,
                               paddingTop: Constants.topLabelVerticalSpace)
        textFieldsStack.centerAnchor(centerX: self.centerXAnchor)
    }
    
    private func setupRegisterButton() {
        registerButton.anchor(top: textFieldsStack.bottomAnchor,
                              paddingTop: Constants.topLabelVerticalSpace)
        registerButton.centerAnchor(centerX: self.centerXAnchor)
        registerButton.dimension(width: Constants.registerButtonWidth,
                                 height: Constants.registerButtonHeight)
    }
    
    private func setupErrorLabel() {
        errorLabel.anchor(top: textFieldsStack.bottomAnchor,
                          paddingTop: Constants.errorLabelTopPadding,
                          left: textFieldsStack.leftAnchor)
        errorLabel.dimension(width: Constants.errorLabelWidth,
                             height: .zero)
    }
    
    private func setupBottomButton() {
        bottomButton.anchor(bottom: self.safeAreaLayoutGuide.bottomAnchor,
                            paddingBottom: Constants.bottomButtonBottomPadding,
                            left: self.leftAnchor,
                            paddingLeft: Constants.bottomButtonSidePadding,
                            right: self.rightAnchor,
                            paddingRight: Constants.bottomButtonSidePadding)
        bottomButton.dimension(width: .zero,
                               height: Constants.bottonButtonHeight)
    }
    //MARK: Configure View
    func configureView(viewcontroller: UIViewController) {
        emailTF.delegate = viewcontroller as? UITextFieldDelegate
        passwordTF.delegate = viewcontroller as? UITextFieldDelegate
        repeatPasswordTF.delegate = viewcontroller as? UITextFieldDelegate
        delegate = viewcontroller as? SignInDelegate
    }
    
    func changeErrorLabelVisibility(isHidden: Bool) {
        if isHidden {
            errorLabel.isHidden = true
        } else {
            errorLabel.isHidden = false
        }
    }
    
    func setErrorLabelText(text: String) {
        errorLabel.text = text
    }
    //MARK: Button actions
    @objc func registerButtonTapped() {
        delegate?.signInClicked(self)
    }
    
    @objc func logInButtonTapped() {
        delegate?.logInClicked(self)
    }
}
