//
//  ViewController.swift
//  Naver-Login
//
//  Created by 이동건 on 2018. 5. 15..
//  Copyright © 2018년 이동건. All rights reserved.
//

import UIKit
import Alamofire
import NaverThirdPartyLogin

class ViewController: UIViewController {
    //MARK: IBOutlet
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var logoutBtn: UIButton! {
        didSet{
            logoutBtn.isHidden = true
        }
    }
    @IBOutlet weak var emailLabel: UILabel! {
        didSet{
            emailLabel.text = nil
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet{
            nameLabel.text = nil
        }
    }
    @IBOutlet weak var birthLabel: UILabel! {
        didSet{
            birthLabel.text = nil
        }
    }
    //MARK: Properties
    let loginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()        
    }
    //MARK: IBAction
    @IBAction func handleLogin(_ sender: Any) {
        loginInstance?.delegate = self
        loginInstance?.requestThirdPartyLogin()
    }
    @IBAction func handleLogout(_ sender: Any) {
//        loginConn?.resetToken() // 로그아웃
        loginInstance?.requestDeleteToken() // 연동해제
        logoutBtn.isHidden = true
        loginBtn.isHidden = false
    }
}

extension ViewController: NaverThirdPartyLoginConnectionDelegate{
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
        let naverSignInViewController = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request)!
        present(naverSignInViewController, animated: true, completion: nil)
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        print("Success oauth20ConnectionDidFinishRequestACTokenWithAuthCode")
        getNaverEmailFromURL()
        logoutBtn.isHidden = false
        loginBtn.isHidden = true
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        print("Success oauth20ConnectionDidFinishRequestACTokenWithRefreshToken")
        getNaverEmailFromURL()
        logoutBtn.isHidden = false
        loginBtn.isHidden = true
    }
    func oauth20ConnectionDidFinishDeleteToken() {
        
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(error.localizedDescription)
        print(error)
    }
    
    func getNaverEmailFromURL(){
        guard let loginConn = NaverThirdPartyLoginConnection.getSharedInstance() else {return}
        guard let tokenType = loginConn.tokenType else {return}
        guard let accessToken = loginConn.accessToken else {return}
        
        let authorization = "\(tokenType) \(accessToken)"
        Alamofire.request("https://openapi.naver.com/v1/nid/me", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Authorization" : authorization]).responseJSON { (response) in
            guard let result = response.result.value as? [String: Any] else {return}
            guard let object = result["response"] as? [String: Any] else {return}
            guard let birthday = object["birthday"] as? String else {return}
            guard let name = object["name"] as? String else {return}
            guard let email = object["email"] as? String else {return}
            
            self.birthLabel.text = birthday
            self.emailLabel.text = email
            self.nameLabel.text = name
            print(result)
        }
    }
}
