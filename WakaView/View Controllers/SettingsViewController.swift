//
//  SettingsViewController.swift
//  WakaView
//
//  Created by Sam Galizia on 12/12/17.
//  Copyright © 2017 Sam Galizia. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
  private var userDefaults: UserDefaults = UserDefaults.standard
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  @IBAction func logOut(_ sender: UIButton) {
    // Remove stored tokens to "log out" user
    userDefaults.removeObject(forKey: "token")
    userDefaults.removeObject(forKey: "refresh_token")
   
    // Swap back to auth view
    UIApplication
      .shared
      .keyWindow?
      .rootViewController = AuthenticationViewController(nibName: "AuthenticationViewController", bundle: nil)
  }
  
}
