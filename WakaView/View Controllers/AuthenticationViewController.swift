//
//  AuthenticationViewController.swift
//  WakaView
//
//  Created by Sam Galizia on 12/11/17.
//  Copyright © 2017 Sam Galizia. All rights reserved.
//

import OAuthSwift
import SwiftyJSON
import UIKit

class AuthenticationViewController: UIViewController {
  private var secrets: [String: String]?
  private var oauthswift: OAuth2Swift!
  private var userDefaults: UserDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Grab secrets and then instantiate OAuth
    secrets = getSecrets()
    
    oauthswift = OAuth2Swift(
      consumerKey: secrets!["client_id"]!,
      consumerSecret: secrets!["client_secret"]!,
      authorizeUrl: "https://wakatime.com/oauth/authorize",
      accessTokenUrl: "https://wakatime.com/oauth/token",
      responseType: "token"
    )
  }
  
  @IBAction func logIn(_ sender: UIButton) {
    let _ = oauthswift.authorize(
      withCallbackURL: URL(string: "wakaview://oauth-callback")!,
      scope: "email,read_logged_time,read_stats",
      state: randomAlphaNumericString(length: 20),
      success: { [weak self] (credential, response, params) in
        // Store token and refresh token
        self?.userDefaults.set(credential.oauthToken, forKey: "token")
        self?.userDefaults.set(credential.oauthRefreshToken, forKey: "refresh_token")
        
        // Switch root view controller to main storyboard
        UIApplication.shared.keyWindow?.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()
      }, failure: { error in
        // TODO: Handle this better. Maybe restart the flow?
        print(error.localizedDescription)
    })
  }
  
}

private extension AuthenticationViewController {
  func getSecrets() -> [String: String]
  {
    guard let file = Bundle.main.url(forResource: "secrets", withExtension: "json"),
          let data = try? Data(contentsOf: file)
      else { print("Error parsing contents of secrets file!"); return [:] }
    
    let json = JSON(data: data)
    return [
      "client_id": json["client_id"].stringValue,
      "client_secret": json["client_secret"].stringValue
    ]
  }
  
  func randomAlphaNumericString(length: Int) -> String {
    let allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let allowedCharsCount = UInt32(allowedChars.count)
    var randomString = ""
    
    for _ in 0..<length {
      let randomNum = Int(arc4random_uniform(allowedCharsCount))
      let randomIndex = allowedChars.index(allowedChars.startIndex, offsetBy: randomNum)
      let newCharacter = allowedChars[randomIndex]
      randomString += String(newCharacter)
    }
    
    return randomString
  }
}
