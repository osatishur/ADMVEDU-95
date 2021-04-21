//
//  ResetPasswordView.swift
//  ADMVEDU95
//
//  Created by Satishur, Oleg on 21.04.2021.
//

import UIKit

protocol ResetPasswordDelegate {
    func requestRecovery()
}

class ResetPasswordView: UIView, AuthViewBuilder {
    struct Constants {
        static let textFieldInnerSpace: CGFloat = 20
        static let topLabelTopPadding: CGFloat = 30
        static let topLabelSidePadding: CGFloat = 30
        static let emailTFTopPadding: CGFloat = 30
        static let emailTFSidePadding: CGFloat = 30
        static let emailTFHeight: CGFloat = 54
        static let sendButtonWidth: CGFloat = UIScreen.main.bounds.width * 0.6
        static let sendButtonHeight: CGFloat = 54
        static let sendButtonTopPadding: CGFloat = UIScreen.main.bounds.height * 0.1
    }
    //MARK: Views
    lazy var topLabel: UILabel = {
        var label = buildLabel(text: "Please, enter your email".localized(), font: UIFont.regularFont)
        return label
    }()

    lazy var emailTF: UITextField = {
        var textField = buildTextField(placegolder: "Email".localized(),
                                       isSecureTextEnter: false,
                                       sideWidth: Constants.textFieldInnerSpace)
        return textField
    }()

    lazy var sendButton: UIButton = {
        var button = buildButton(title: "Send".localized(),
                                 titleColor: UIColor.white,
                                 backgroundColor: UIColor.systemBlue)
        button.addTarget(self, action: #selector(sendButtonClicked), for: .touchUpInside)
        return button
    }()
    
    var delegate: ResetPasswordDelegate?
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
        setupEmailTF()
        setupSendButton()
    }
    
    private func setupSubviews() {
        addSubview(topLabel)
        addSubview(emailTF)
        addSubview(sendButton)
    }
    
    private func setupTopLabel() {
        topLabel.anchor(top: self.safeAreaLayoutGuide.topAnchor,
                        paddingTop: Constants.topLabelTopPadding,
                        left: self.leftAnchor,
                        paddingLeft: Constants.topLabelSidePadding,
                        right: self.rightAnchor,
                        paddingRight: Constants.topLabelSidePadding)
    }
    
    private func setupEmailTF() {
        emailTF.anchor(top: topLabel.bottomAnchor,
                        paddingTop: Constants.topLabelTopPadding,
                        left: self.leftAnchor,
                        paddingLeft: Constants.emailTFSidePadding,
                        right: self.rightAnchor,
                        paddingRight: Constants.emailTFSidePadding)
        emailTF.dimension(width: .zero, height: Constants.emailTFHeight)
    }
    
    private func setupSendButton() {
        sendButton.anchor(top: emailTF.bottomAnchor,
                          paddingTop: Constants.sendButtonTopPadding)
        sendButton.centerAnchor(centerX: self.centerXAnchor)
        sendButton.dimension(width: Constants.sendButtonWidth,
                             height: Constants.sendButtonHeight)
    }
    //MARK: Configure View
    func configureView(viewController: UIViewController) {
        emailTF.delegate = viewController as? UITextFieldDelegate
        delegate = viewController as? ResetPasswordDelegate
    }
    
    
    @objc func sendButtonClicked() {
        delegate?.requestRecovery()
    }
}
