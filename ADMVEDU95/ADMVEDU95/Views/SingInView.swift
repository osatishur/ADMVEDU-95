//
//  SingInView.swift
//  ADMVEDU95
//
//  Created by Satsishur on 20.04.2021.
//

import UIKit

protocol SignInDelegate {
    func signInClicked()
    func logInClicked()
}

class SingInView: UIView, AuthViewBuilder {
    struct Constants {
        static let textFieldInnerSpace: CGFloat = 20
        static let topLabelVerticalSpace: CGFloat = UIScreen.main.bounds.height * 0.1
        static let textFieldWidth: CGFloat = UIScreen.main.bounds.width * 0.8
        static let stackViewSpacing: CGFloat = 20
        static let textFieldHeight: CGFloat = 54
        static let registerButtonWidth: CGFloat = UIScreen.main.bounds.width * 0.6
        static let registerButtonHeight: CGFloat = 54
        static let bottomViewHeight: CGFloat = UIScreen.main.bounds.height * 0.15
        static let bottomLabelPaddingLeft: CGFloat = UIScreen.main.bounds.width * 0.22
        static let bottomLabelWidth: CGFloat = UIScreen.main.bounds.width * 0.5
        static let bottomLabelPaddingBottom =  UIScreen.main.bounds.height * 0.075
        static let bottonButtonPaddingLeft: CGFloat = 10
        static let bottonButtonHeight: CGFloat = 22
        static let bottomButtonWidth: CGFloat = UIScreen.main.bounds.width * 0.15
    }
    
    lazy private var topLabel: UILabel = {
        var label = buildLabel(text: "Registration", font: UIFont.regularFont)
        return label
    }()
    
    lazy var mailTF: UITextField = {
        var textField = buildTextField(placegolder: "Mail", isSecureTextEnter: false, sideWidth: Constants.textFieldInnerSpace)
        return textField
    }()
    
    lazy var passwordTF: UITextField = {
        var textField = buildTextField(placegolder: "Password", isSecureTextEnter: true, sideWidth: Constants.textFieldInnerSpace)
        return textField
    }()
    
    lazy var repeatPasswordTF: UITextField = {
        var textField = buildTextField(placegolder: "Repeat password", isSecureTextEnter: true, sideWidth: Constants.textFieldInnerSpace)
        return textField
    }()
    
    lazy private var registerButton: UIButton = {
        var button = buildButton(title: "Sign in", titleColor: .white, backgroundColor: .systemBlue)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy private var bottomLabel: UILabel = {
        let label = buildLabel(text: "Already have an account?", font: UIFont.regularFont)
        return label
    }()
    
    lazy private var bottomButton: UIButton = {
        var button = buildButton(title: "Log in", titleColor: .systemBlue, backgroundColor: .white)
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
    var bottomView = UIView()
    
    var delegate: SignInDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
        
    }
    
    private func setupLayout() {
        self.backgroundColor = .white
        setupSubviews()
        setupTopLabel()
        setupTextFields()
        setupRegisterButton()
        setupBottomView()
    }
    
    private func setupSubviews() {
        addSubview(topLabel)
        addSubview(textFieldsStack)
        addSubview(registerButton)
        addSubview(bottomView)
        bottomView.addSubview(bottomLabel)
        bottomView.addSubview(bottomButton)
    }
    
    private func setupTopLabel() {
        topLabel.anchor(top: self.topAnchor, paddingTop: Constants.topLabelVerticalSpace)
        topLabel.centerAnchor(centerX: self.centerXAnchor)
    }
    
    private func setupTextFields() {
        mailTF.dimension(width: Constants.textFieldWidth,
                         height: Constants.textFieldHeight)
        passwordTF.dimension(width: Constants.textFieldWidth,
                             height: Constants.textFieldHeight)
        repeatPasswordTF.dimension(width: Constants.textFieldWidth,
                                   height: Constants.textFieldHeight)
        textFieldsStack.addArrangedSubview(mailTF)
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
    
    private func setupBottomView() {
        bottomView.anchor(bottom: self.bottomAnchor,
                          left: self.leftAnchor,
                          right: self.rightAnchor)
        bottomView.dimension(width: .zero, height: Constants.bottomViewHeight)
        setupBottomLabel()
        setupBottomButton()
    }
    
    private func setupBottomLabel() {
        bottomLabel.anchor(left: bottomView.leftAnchor,
                           paddingLeft: Constants.bottomLabelPaddingLeft)
        bottomLabel.centerAnchor(centerY: bottomView.centerYAnchor)
        bottomLabel.dimension(width: Constants.bottomLabelWidth, height: .zero)
    }
    
    private func setupBottomButton() {
        bottomButton.anchor(left: bottomLabel.rightAnchor,
                            paddingLeft: Constants.bottonButtonPaddingLeft)
        bottomButton.centerAnchor(centerY: bottomLabel.centerYAnchor)
        bottomButton.dimension(width: Constants.bottomButtonWidth, height: Constants.bottonButtonHeight)
    }
    
    func configureView(viewcontroller: UIViewController) {
        mailTF.delegate = viewcontroller as? UITextFieldDelegate
        passwordTF.delegate = viewcontroller as? UITextFieldDelegate
        repeatPasswordTF.delegate = viewcontroller as? UITextFieldDelegate
        delegate = viewcontroller as? SignInDelegate
    }
    
    @objc func registerButtonTapped() {
        delegate?.signInClicked()
    }
    
    @objc func logInButtonTapped() {
        delegate?.logInClicked()
    }
}
