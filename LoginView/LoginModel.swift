//
//  LoginPage.swift
//  coffeMachine_app
//
//  Created by Vladimir Mikhaylov on 31.03.2018.
//  Copyright © 2018 Vladimir Mikhaylov. All rights reserved.
//

import RxSwift
import Action
import AKMaskField
import SwiftyJSON

class LoginPageModel {

    var delegate = UIViewController()
    var loginDelegate: LoginProtocol? = nil
    var firstView = UIView()
    var secondView = UIView()
    var thirdView = UIView()
    var phoneInput = AKMaskField()
    var phoneInputSecond = AKMaskField()
    var codeInput = AKMaskField()
    var dateInput = AKMaskField()
    var nameInput = AKMaskField()
    var reSendSmsButton = UIButton()
    var reSendSmsLabel = UILabel()

    var reCheckTimer = Timer()
    var counter = 30
    var code = ""
    var currentUserId = ""

    let api = API()
    let UserAPI = UserRealmController()

    init() {

    }

    func close() {
        delegate.dismiss(animated: true, completion: nil)
    }

    func okFirst() {
        if (phoneInput.maskStatus == .complete) {
            phoneInputSecond.text = phoneInput.text
            firstView.isHidden = true
            secondView.isHidden = false
            sendSmS()
        } else {
            addedAnimation(field: self.phoneInput, view: self.phoneInput)
        }
    }

    func reSendSms() {
        if (phoneInputSecond.maskStatus == .complete) {
            sendSmS()
            reSendSmsButton.isHidden = true
            reSendSmsLabel.isHidden = false
            let counter = 30
            reSendSmsLabel.text = "Повторить попытку через: \(counter)"
            Timer.scheduledTimer(timeInterval: 31, target: self, selector: #selector(showReCheckButton), userInfo: nil, repeats: false)
            self.reCheckTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(showCount), userInfo: nil, repeats: true)
        } else {
            addedAnimation(field: self.phoneInputSecond, view: self.phoneInputSecond)
        }
    }

    @objc func showReCheckButton() {
        reSendSmsButton.isHidden = false
        reSendSmsLabel.isHidden = true
    }

    @objc func showCount() {
        counter -= 1
        reSendSmsLabel.text = "Повторить попытку через: \(counter)"
        if (counter == 0) {
            reCheckTimer.invalidate()
        }
    }

    func sendSmS() {
        if (appConfig.smsTurnOff) {
            self.code = "1111"
        } else {
            self.code = randomizePassword()
            guard let unwarpedPhone = phoneInputSecond.text else { return }
            api.PostUserPhoneVerification(phone: unwarpedPhone, message: code, completionHandler: {_,_ in })
        }
    }

    func randomizePassword(length: Int = 4) -> String {
        let base = "0123456789"
        var randomString: String = ""
        for _ in 0..<length {
            let randomValue = arc4random_uniform(UInt32(base.count))
            randomString += "\(base[base.index(base.startIndex, offsetBy: Int(randomValue))])"
        }
        return randomString
    }

    func login() {
        guard let unwarpedCode = codeInput.text  else { return }
        var truePasswordParts = unwarpedCode.components(separatedBy: " ")
        let truePasswordFromInput = truePasswordParts[0] + truePasswordParts[1]
        if (truePasswordFromInput == self.code) {
            loadUserOrCreateUser()
        } else {
            addedAnimation(field: self.codeInput, view: self.codeInput)
        }
    }

    func loadUserOrCreateUser() {
        let makePopUp = MakePopUp()
        let loadVC = makePopUp.darkLoadPopUp()
        delegate.present(loadVC, animated: false, completion: nil)

        api.PostCreateUser(phone: parsePhoneString(), completionHandler: { responseObject, error in
            if ((error) != nil) {
                loadVC.closeView()
            } else {
                guard let unwarpedUserId = responseObject as? String else { return }
                self.currentUserId = unwarpedUserId
                self.api.getUserData(id: unwarpedUserId, completionHandler: { responseObject, error in
                    if ((error) != nil) {
                        loadVC.closeView()
                    } else {
                        guard let unwarpedResponseObject = responseObject else { return }
                        let json = JSON(unwarpedResponseObject)
                        if (json["name"] == JSON.null || json["name"] == "") {
                            loadVC.closeView()
                            self.secondView.isHidden = true
                            self.thirdView.isHidden = false
                        } else {
                            self.updateUser(vc: loadVC)
                        }
                    }
                })
            }
        })
    }

    func updateUser(vc: SimplyBlackLoadView) {
        self.UserAPI.updateUser(id: currentUserId) { responseObject, error in
            if ((error) != nil) {
                vc.closeView()
            } else {
                vc.closeView()
                self.loginDelegate?.userLogin()
                self.close()
            }
        }
    }

    func parsePhoneString() -> String {
        guard let unwarpedPhone = phoneInputSecond.text else { return "" }
        let number = String(unwarpedPhone.dropFirst())
        let trimmedString = number.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
        let newNumber = "+" + trimmedString.replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
        return newNumber
    }

    func updateUserInfo() {
        if (self.checkData()) {
            self.addUserInfoAndFinishRegistration()
        } else {
            shake(view: self.thirdView)
        }
    }

    func checkData() -> Bool {
        var checkBool = false
        let maskStatus = dateInput.maskStatus
        if (maskStatus == .complete) {
            if (self.checkInputDate() && nameInput.text != "") {
                checkBool = true
            }
        } else {
            addedAnimation(field: self.dateInput, view: self.dateInput)
        }
        return checkBool
    }

    func checkInputDate() -> Bool {
        var checkBool = false
        let fullDate = self.dateInput.text?.components(separatedBy: "-")
        let date = fullDate?[0]
        let month = fullDate?[1]
        let year = fullDate?[2]
        if (date != nil && month != nil && year != nil ) {
            if (Int(date!)! >= 1 && Int(date!)! <= 31 && Int(month!)! >= 1 && Int(month!)! <= 12 && Int(year!)! >= 1900 && Int(year!)! <= 2400 ) {
                checkBool = true
            }
        }
        return checkBool
    }

    func addUserInfoAndFinishRegistration() {
        let vc = MakePopUp().darkLoadPopUp()
        self.delegate.present(vc, animated: false, completion: nil)

        let fullDate = self.dateInput.text?.components(separatedBy: "-")
        let date = fullDate?[0]
        let month = fullDate?[1]
        let year = fullDate?[2]
        let correctDate = year! + "-" + month! + "-" + date!

        api.PostUpdateUser(phone: parsePhoneString(), name: self.nameInput.text, email: nil, city: nil, birthday: correctDate) { responseObject, error in
            if ((error) != nil) {
                vc.closeView()
            } else {
                self.updateUser(vc: vc)
            }
        }
    }

    func dismissKeyboard() {
        delegate.view.endEditing(true)
    }

}
