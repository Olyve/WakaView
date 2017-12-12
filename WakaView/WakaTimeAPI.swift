//
//  WakaTimeAPI.swift
//  WakaView
//
//  Created by Sam Galizia on 12/11/17.
//  Copyright © 2017 Sam Galizia. All rights reserved.
//

import Moya

enum WakaTimeAPIService {
  case user
  case stats(range: StatsTimeRange)
}

// MARK: - TargetType Protocol Implementation
extension WakaTimeAPIService: TargetType {
  var baseURL: URL {
    return URL(string: "https://wakatime.com/api/v1/")!
  }
  
  var path: String {
    switch self {
    case .user:
      return "/users/current"
    case .stats(let range):
      return "/users/current/stats/\(range)"
    }
  }
  
  var method: Moya.Method {
    return .get
  }
  
  var task: Task {
    return .requestPlain
  }
  
  var headers: [String: String]? {
    let token = UserDefaults.standard.value(forKey: "token") as! String
    return ["Authorization": "Bearer \(token)"]
  }
  
  // Not implementing testing right now
  var sampleData: Data {
    return Data()
  }
}

// MARK: - Stats Time Range Enum
enum StatsTimeRange: String {
  case last_7_days = "last_7_days"
  case last_30_days = "last_30_days"
  case last_6_months = "last_6_months"
  case last_year = "last_year"
}
