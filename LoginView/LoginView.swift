//
//  LoginPageView.swift
//  coffeMachine_app
//
//  Created by Vladimir Mikhaylov on 31.03.2018.
//  Copyright © 2018 Vladimir Mikhaylov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxGesture
import AKMaskField

class LoginPageView: UIViewController {

    let scrollView: UIScrollView = {
        var scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let firstView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()

    let secondView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()

    let thirdView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.isHidden = true
        return view
    }()

    let closeButton: CloseButton = {
        var button = CloseButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isAddButton = true
        button.fillColor = UIColor.clear
        button.secondColor = UIColor.white
        return button
    }()

    let phoneHeaderLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let phoneHeaderLabelSecond: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let codeLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let phoneInput: AKMaskField = {
        var field = AKMaskField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.textColor = UIColor.gray
        field.borderStyle = UITextBorderStyle.roundedRect
        field.keyboardType = UIKeyboardType.decimalPad
        field.maskExpression = "+7 ({ddd}) {ddd}-{dd}-{dd}"
        field.maskTemplate = "+7"
        return field
    }()

    let phoneInputSecond: AKMaskField = {
        var field = AKMaskField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.textColor = UIColor.gray
        field.borderStyle = UITextBorderStyle.roundedRect
        field.keyboardType = UIKeyboardType.decimalPad
        field.maskExpression = "+7 ({ddd}) {ddd}-{dd}-{dd}"
        field.maskTemplate = "+7"
        return field
    }()

    let codeInput: AKMaskField = {
        var field = AKMaskField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.textColor = UIColor.gray
        field.borderStyle = UITextBorderStyle.roundedRect
        field.keyboardType = UIKeyboardType.decimalPad
        field.maskExpression = "{dd} {dd}"
        field.maskTemplate = ""
        return field
    }()

    let firstViewButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"button_check"), for: .normal)
        button.setImage(UIImage(named:"button_check_white"), for: .disabled)
        return button
    }()

    let secondViewButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"button_check"), for: .normal)
        button.setImage(UIImage(named:"button_check_white"), for: .disabled)
        return button
    }()

    let reSendSmsButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Выслать sms еще раз", for: .normal)
        button.setTitleColor(UIColor.cMachineRed, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return button
    }()

    let reSendCouldownLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Повторить попытку через: "
        label.isHidden = true
        return label
    }()

    let confirmCodeButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"button_check"), for: .normal)
        button.setImage(UIImage(named:"button_check_white"), for: .disabled)
        return button
    }()

    let nameLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    let nameInput: AKMaskField = {
        var field = AKMaskField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.textColor = UIColor.gray
        field.borderStyle = UITextBorderStyle.roundedRect
        return field
    }()

    let birthdayLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.text = "Укажите вашу дату рождения:"
        return label
    }()

    let dateInput: AKMaskField = {
        var field = AKMaskField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.textAlignment = .center
        field.textColor = UIColor.gray
        field.borderStyle = UITextBorderStyle.roundedRect
        field.keyboardType = UIKeyboardType.decimalPad
        field.maskExpression = "{dd}-{dd}-{dddd}"
        return field
    }()

    let moreUserDataButton: UIButton = {
        var button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named:"button_check"), for: .normal)
        button.setImage(UIImage(named:"button_check_white"), for: .disabled)
        return button
    }()

    let viewModel = LoginPageModel()
    let disposeBag = DisposeBag()
    var loginDelegate: LoginProtocol? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        viewModel.loginDelegate = loginDelegate
        autolayout()
        setFirstView()
        setSecondView()
        setThirdView()
        setButtonActions()
        registerForKeyboardNotifocations()

        viewModel.phoneInput = phoneInput
        viewModel.firstView = firstView
        viewModel.secondView = secondView
        viewModel.thirdView = thirdView
        viewModel.phoneInputSecond = phoneInputSecond
        viewModel.reSendSmsButton = reSendSmsButton
        viewModel.reSendSmsLabel = reSendCouldownLabel
        viewModel.codeInput = codeInput
        viewModel.nameInput = nameInput
        viewModel.dateInput = dateInput
    }

    func autolayout() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addSubview(scrollView)
        view.addSubview(closeButton)

         if #available(iOS 11.0, *) {
            NSLayoutConstraint.activate([
                closeButton.widthAnchor.constraint(equalToConstant: 50),
                closeButton.heightAnchor.constraint(equalToConstant: 50),
                closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
                closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -32),
            ])
         } else {
            NSLayoutConstraint.activate([
                closeButton.widthAnchor.constraint(equalToConstant: 50),
                closeButton.heightAnchor.constraint(equalToConstant: 50),
                closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 8),
                closeButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32),
                ])
        }

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            ])
    }

    func setFirstView() {
        scrollView.addSubview(firstView)
        firstView.addSubview(phoneHeaderLabel)
        firstView.addSubview(phoneInput)
        firstView.addSubview(firstViewButton)
        setPhoneLabel(label: phoneHeaderLabel)

        NSLayoutConstraint.activate([
            firstView.heightAnchor.constraint(equalToConstant: 300),
            firstView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            firstView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            firstView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
            firstView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0),

            phoneHeaderLabel.topAnchor.constraint(equalTo: firstView.topAnchor, constant: 16),
            phoneHeaderLabel.leftAnchor.constraint(equalTo: firstView.leftAnchor, constant: 8),
            phoneHeaderLabel.rightAnchor.constraint(equalTo: firstView.rightAnchor, constant: -8),
            phoneHeaderLabel.bottomAnchor.constraint(equalTo: phoneInput.topAnchor, constant: -8),

            phoneInput.heightAnchor.constraint(equalToConstant: 30),
            phoneInput.widthAnchor.constraint(equalToConstant: 250),
            phoneInput.centerXAnchor.constraint(equalTo: firstView.centerXAnchor, constant: 0),
            phoneInput.bottomAnchor.constraint(equalTo: firstViewButton.topAnchor, constant: -8),

            firstViewButton.widthAnchor.constraint(equalToConstant: 75),
            firstViewButton.heightAnchor.constraint(equalToConstant: 75),
            firstViewButton.centerXAnchor.constraint(equalTo: firstView.centerXAnchor, constant: 0),
            firstViewButton.bottomAnchor.constraint(equalTo: firstView.bottomAnchor, constant: -16)
            ])
    }

    func setSecondView() {
        scrollView.addSubview(secondView)
        secondView.addSubview(phoneHeaderLabelSecond)
        secondView.addSubview(phoneInputSecond)
        secondView.addSubview(codeLabel)
        secondView.addSubview(codeInput)
        secondView.addSubview(reSendSmsButton)
        secondView.addSubview(reSendCouldownLabel)
        secondView.addSubview(confirmCodeButton)
        setPhoneLabel(label: phoneHeaderLabelSecond)
        setCodeLabel(label: codeLabel)


        NSLayoutConstraint.activate([
            secondView.heightAnchor.constraint(equalToConstant: 400),
            secondView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            secondView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            secondView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
            secondView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0),

            phoneHeaderLabelSecond.topAnchor.constraint(equalTo: secondView.topAnchor, constant: 16),
            phoneHeaderLabelSecond.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 8),
            phoneHeaderLabelSecond.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -8),
            phoneHeaderLabelSecond.bottomAnchor.constraint(equalTo: phoneInputSecond.topAnchor, constant: -8),

            phoneInputSecond.heightAnchor.constraint(equalToConstant: 30),
            phoneInputSecond.widthAnchor.constraint(equalToConstant: 250),
            phoneInputSecond.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: 0),
            phoneInputSecond.bottomAnchor.constraint(equalTo: codeLabel.topAnchor, constant: -8),

            codeLabel.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 8),
            codeLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -8),
            codeLabel.bottomAnchor.constraint(equalTo: codeInput.topAnchor, constant: -8),

            codeInput.heightAnchor.constraint(equalToConstant: 30),
            codeInput.widthAnchor.constraint(equalToConstant: 100),
            codeInput.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: 0),
            codeInput.bottomAnchor.constraint(equalTo: reSendSmsButton.topAnchor, constant: -8),

            reSendSmsButton.widthAnchor.constraint(equalToConstant: 150),
            reSendSmsButton.heightAnchor.constraint(equalToConstant: 30),
            reSendSmsButton.centerXAnchor.constraint(equalTo: secondView.centerXAnchor, constant: 0),
            reSendSmsButton.topAnchor.constraint(equalTo: codeInput.bottomAnchor, constant: 8),
            reSendSmsButton.bottomAnchor.constraint(equalTo: reSendCouldownLabel.topAnchor, constant: -8),

            reSendCouldownLabel.topAnchor.constraint(equalTo: reSendSmsButton.bottomAnchor, constant: 8),
            reSendCouldownLabel.bottomAnchor.constraint(equalTo: secondView.bottomAnchor, constant: -8),
            reSendCouldownLabel.leftAnchor.constraint(equalTo: secondView.leftAnchor, constant: 8),
            reSendCouldownLabel.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -8),

            confirmCodeButton.widthAnchor.constraint(equalToConstant: 60),
            confirmCodeButton.heightAnchor.constraint(equalToConstant: 60),
            confirmCodeButton.centerYAnchor.constraint(equalTo: codeInput.centerYAnchor, constant: 0),
            confirmCodeButton.rightAnchor.constraint(equalTo: secondView.rightAnchor, constant: -8)
            ])

    }

    func setThirdView() {
        scrollView.addSubview(thirdView)
        thirdView.addSubview(nameLabel)
        thirdView.addSubview(nameInput)
        thirdView.addSubview(birthdayLabel)
        thirdView.addSubview(dateInput)
        thirdView.addSubview(moreUserDataButton)

        setNameLabel(label: nameLabel)

        NSLayoutConstraint.activate([

            thirdView.heightAnchor.constraint(equalToConstant: 300),
            thirdView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            thirdView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            thirdView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor, constant: 0),
            thirdView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor, constant: 0),


            nameLabel.topAnchor.constraint(equalTo: thirdView.topAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: nameInput.topAnchor, constant: -8),

            nameInput.heightAnchor.constraint(equalToConstant: 30),
            nameInput.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            nameInput.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 16),
            nameInput.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -16),

            birthdayLabel.heightAnchor.constraint(equalToConstant: 30),
            birthdayLabel.leftAnchor.constraint(equalTo: thirdView.leftAnchor, constant: 16),
            birthdayLabel.rightAnchor.constraint(equalTo: thirdView.rightAnchor, constant: -16),
            birthdayLabel.topAnchor.constraint(equalTo: nameInput.bottomAnchor, constant: 8),
            birthdayLabel.bottomAnchor.constraint(equalTo: dateInput.topAnchor, constant: -8),

            dateInput.heightAnchor.constraint(equalToConstant: 30),
            dateInput.widthAnchor.constraint(equalToConstant: 200),
            dateInput.centerXAnchor.constraint(equalTo: thirdView.centerXAnchor, constant: 0),
            dateInput.topAnchor.constraint(equalTo: birthdayLabel.bottomAnchor, constant: 8),
            dateInput.bottomAnchor.constraint(equalTo: moreUserDataButton.topAnchor, constant: -8),

            moreUserDataButton.widthAnchor.constraint(equalToConstant: 75),
            moreUserDataButton.heightAnchor.constraint(equalToConstant: 75),
            moreUserDataButton.centerXAnchor.constraint(equalTo: thirdView.centerXAnchor, constant: 0),
            moreUserDataButton.topAnchor.constraint(equalTo: dateInput.bottomAnchor, constant: -16),
            moreUserDataButton.bottomAnchor.constraint(equalTo: thirdView.bottomAnchor, constant: -8),
        ])

    }

    func setPhoneLabel(label: UILabel) {
        let attributedText = NSMutableAttributedString(string: "Зарегистрируйтесь", attributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.regular), NSAttributedStringKey.foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: "\n\nЧтобы получить возможность совершать заказ с оплатой сразу через приложение", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        attributedText.append(NSAttributedString(string: "\n\nВаш телефон:", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.black]))
        label.attributedText = attributedText
    }

    func setCodeLabel(label: UILabel) {
        let attributedText = NSMutableAttributedString(string: "На ваш номер выслано sms-сообщение с кодом вида xx xx", attributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.regular), NSAttributedStringKey.foregroundColor: UIColor.gray])
        attributedText.append(NSAttributedString(string: "\n\nКод из sms:", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20), NSAttributedStringKey.foregroundColor: UIColor.black]))
        label.attributedText = attributedText
    }

    func setNameLabel(label: UILabel) {
        let attributedText = NSMutableAttributedString(string: "Остался последний шаг", attributes:[NSAttributedStringKey.font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.regular), NSAttributedStringKey.foregroundColor: UIColor.black])
        attributedText.append(NSAttributedString(string: "\n\nВведите ваше имя:", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.black]))
        label.attributedText = attributedText
    }

    func setButtonActions() {
        view.isUserInteractionEnabled = true
        view.rx.tapGesture().when(.recognized).subscribe(onNext: { _ in
            self.viewModel.dismissKeyboard()
        }).disposed(by: disposeBag)

        firstViewButton.rx.tap.subscribe(onNext: { _ in
            self.viewModel.okFirst()
        }).disposed(by: disposeBag)

        closeButton.rx.tap.subscribe(onNext: { _ in
            self.viewModel.close()
        }).disposed(by: disposeBag)

        reSendSmsButton.rx.tap.subscribe(onNext: { _ in
            self.viewModel.reSendSms()
        }).disposed(by: disposeBag)

        confirmCodeButton.rx.tap.subscribe(onNext: { _ in
            self.viewModel.login()
        }).disposed(by: disposeBag)

        moreUserDataButton.rx.tap.subscribe(onNext: { _ in
            self.viewModel.updateUserInfo()
        }).disposed(by: disposeBag)
    }

    func registerForKeyboardNotifocations() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func removeKeyboardNotifocations() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @objc func keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x:0, y: kbFrameSize.height / 2)
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentOffset = CGPoint.zero
    }
}
