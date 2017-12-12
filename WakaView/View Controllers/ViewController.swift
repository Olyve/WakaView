//
//  ViewController.swift
//  WakaView
//
//  Created by Sam Galizia on 11/15/17.
//  Copyright © 2017 Sam Galizia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  @IBAction func logoutUser() {
    UserDefaults.standard.removeObject(forKey: "token")
    UserDefaults.standard.removeObject(forKey: "refresh_token")
  }
}

