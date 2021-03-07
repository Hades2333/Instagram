//
//  LoginViewController.swift
//  Instagramm
//
//  Created by Hellizar on 6.03.21.
//

import UIKit

class LoginViewController: UIViewController {

    private let usernameEmailField: UITextField = {
        return UITextField()
    }()

    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        return field
    }()

    private let loginButton: UIButton = {
        return UIButton()
    }()

    private let termsButton: UIButton = {
        return UIButton()
    }()

    private let privacyButton: UIButton = {
        return UIButton()
    }()

    private let createAccountButton: UIButton = {
        return UIButton()
    }()

    private let headerView: UIView = {
        return UIView()
    }()

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        view.backgroundColor = .systemBackground
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        // assign frames
        headerView.frame = CGRect(x: 0,
                                  y: view.safeAreaInsets.top,
                                  width: view.width,
                                  height: 200)
    }

    //MARK: - Methods
    func addSubviews() {
        view.addSubviews(views: [usernameEmailField, passwordField,
                                 loginButton, termsButton,
                                 privacyButton, createAccountButton,
                                 headerView])
    }

    @objc private func didTappedLoginButton() {

    }

    @objc private func didTappedTermsButton() {

    }

    @objc private func didTappedPrivacyButton() {

    }

    @objc private func didTapCreateAccountButton() {

    }
}
