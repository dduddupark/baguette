//
//  LoginViewController.swift
//  baguette
//
//  Created by blue park on 2022/12/08.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon
import GoogleSignIn

class LoginViewController: BaseViewController {
    
    private let label: UILabel = {
            let label = UILabel()
            label.text = "코드 베이스로 만든 뷰입니다"
            label.sizeToFit()
            label.font = .preferredFont(forTextStyle: .headline)
            label.textColor = .label
            return label
        }()
    
    private let logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "SplashText1")
       
            return logo
        }()
    
    private let kakaoImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Kakao")
            return img
        }()
    
    private let kakaoButton: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 26
        btn.backgroundColor = UIColor(named: "ColorFEDE00")
        btn.setTitle("카카오톡으로 로그인", for: .normal)
        btn.setTitleColor(UIColor(named: "Color3B1E1E"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    private let googleImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "google")
            return img
        }()
    
    private let googleButton: UIButton = {
       let btn = UIButton()
        btn.layer.cornerRadius = 26
        btn.backgroundColor = UIColor(named: "ColorF4F4F4")
        btn.setTitle("Google로 로그인", for: .normal)
        btn.setTitleColor(UIColor(named: "Color3B1E1E"), for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 14)
        return btn
    }()
    
    private let baguetteImage: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Baguette")
            return img
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(named: "Color4474F8")
        view.addSubview(logoImage)
        view.addSubview(kakaoButton)
        view.addSubview(kakaoImage)
        view.addSubview(googleButton)
        view.addSubview(googleImage)
        view.addSubview(baguetteImage)
        
        //카카오 버튼
        //뷰를 자동으로 리사이징 하지마!
        kakaoButton.translatesAutoresizingMaskIntoConstraints = false
        //가로크기를 50
        kakaoButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        //세로크기를 50
        kakaoButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        //X축 중앙에 배치
        kakaoButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        //Y축 중앙에 배치
        kakaoButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        //카카오 이미지
        kakaoImage.translatesAutoresizingMaskIntoConstraints = false
        kakaoImage.widthAnchor.constraint(equalToConstant: 19).isActive = true
        kakaoImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        kakaoImage.leadingAnchor.constraint(equalTo: kakaoButton.leadingAnchor, constant: 31).isActive = true
        kakaoImage.centerYAnchor.constraint(equalTo: kakaoButton.centerYAnchor).isActive = true
        
        //구글 버튼
        googleButton.translatesAutoresizingMaskIntoConstraints = false
        googleButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: 52).isActive = true
        googleButton.topAnchor.constraint(equalTo: kakaoButton.bottomAnchor, constant: 10).isActive = true
        googleButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //구글 이미지
        googleImage.translatesAutoresizingMaskIntoConstraints = false
        googleImage.widthAnchor.constraint(equalToConstant: 19).isActive = true
        googleImage.heightAnchor.constraint(equalToConstant: 20).isActive = true
        googleImage.leadingAnchor.constraint(equalTo: googleButton.leadingAnchor, constant: 31).isActive = true
        googleImage.centerYAnchor.constraint(equalTo: googleButton.centerYAnchor).isActive = true
        
        //텍스트 logo
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.widthAnchor.constraint(equalToConstant: 237).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: 81).isActive = true
        logoImage.bottomAnchor.constraint(equalTo: kakaoButton.topAnchor, constant: -81).isActive = true
        logoImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        //바게트 logo
        baguetteImage.translatesAutoresizingMaskIntoConstraints = false
        baguetteImage.widthAnchor.constraint(equalToConstant: 237).isActive = true
        baguetteImage.heightAnchor.constraint(equalToConstant: 81).isActive = true
        baguetteImage.bottomAnchor.constraint(equalTo: kakaoButton.topAnchor, constant: -81).isActive = true
        baguetteImage.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        
        kakaoButton.addTarget(self, action: #selector(moveMain), for: .touchUpInside)
    }

    @objc func moveMain(_ sender: Any) {
        self.moveMainVC()
    }
    
    @IBAction func goToKakaoLogin(_ sender: Any) {
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    _ = oauthToken
                    self.setUserInfo()
                    
                    self.moveMainVC()
                }
            }
        }
    }
    
    let signInConfig = GIDConfiguration.init(clientID: "850790552112-t4qo7a459kiegbm4sinn1nso47ad9n7s.apps.googleusercontent.com")
    
    @IBAction func goToGoogleLogint(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: self.signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user else { return }
              
            let email = user.profile?.email
            let name = user.profile?.name
            
            print("email = \(email), name = \(name)")
            
            // If sign in succeeded, display the app's main content View.
            self.moveMainVC()
          }
    }
    
    func moveMainVC() {
        let pushVC = MainViewController()
        pushVC.modalPresentationStyle = .fullScreen
        self.present(pushVC, animated: true)
//        self.navigationController?.pushViewController(pushVC, animated: true)
    }
    
    func setUserInfo() {
           UserApi.shared.me {(user, error) in
               if let error = error {
                   print(error)
               } else {
                   print("nickname: \(user?.kakaoAccount?.profile?.nickname ?? "no nickname")")
                   print("email: \(user?.kakaoAccount?.email ?? "no email")")
                   
                   guard let userId = user?.id else {return}
                   
                   print("닉네임 : \(user?.kakaoAccount?.profile?.nickname ?? "no nickname").....이메일 : \(user?.kakaoAccount?.email ?? "no nickname"). . . . .유저 ID : \(userId)")
               }
           }
       }
}

