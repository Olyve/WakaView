//
//  ViewController.swift
//  WakaView
//
//  Created by Sam Galizia on 11/15/17.
//  Copyright © 2017 Sam Galizia. All rights reserved.
//

import Moya
import SwiftyJSON
import UIKit

class ViewController: UIViewController {
  private let provider = MoyaProvider<WakaTimeAPIService>()
  @IBOutlet weak var testOutput: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    getStats()
  }

}

// MARK: - Helper methods
private extension ViewController {
  // TODO: You could easily make this return a JSON value and then
  // take the JSON and put the data into charts from here.
  func getStats() {
    provider.request(.stats(range: .last_7_days)) { result in
      switch result {
      case let .success(moyaResponse):
        let data = moyaResponse.data
        let json = JSON(data)
        print(json)
        self.testOutput.text = json.rawString()
      case let .failure(error):
        print(error.localizedDescription)
      }
    }
  }
}
