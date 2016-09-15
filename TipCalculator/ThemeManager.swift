//
//  ThemeManager.swift
//  TipCalculator
//
//  Created by Lyudmyla Ivanova on 9/8/16.
//  Copyright © 2016 Lyudmyla Ivanova. All rights reserved.
//

import UIKit

let kTheme = "currentTheme"

enum Theme: Int {
  case light, dark

  var backgroundColor: UIColor {
    switch self {
    case .light:
      return UIColor(red: 153.0/255.0, green: 1.0, blue: 153.0/255.0, alpha: 1.0)
    case .dark:
      return UIColor(red: 0.0, green: 104.0/255.0, blue: 52.0/255.0, alpha: 1.0)
    }
  }

  var tintColor: UIColor {
    switch self {
    case .light:
      return UIColor(red: 51.0/255.0, green: 102.0/255.0, blue: 0.0, alpha: 1.0)
    case .dark:
      return UIColor(red: 22.0/255.0, green: 24.0/255.0, blue: 24.0/255.0, alpha: 1.0)
    }
  }

  var tableSectionHeaderFontColor: UIColor {
    switch self {
    case .light:
      return UIColor(red: 22.0/255.0, green: 24.0/255.0, blue: 24.0/255.0, alpha: 1.0)
    case .dark:
      return UIColor(red: 207.0/255.0, green: 244.0/255.0, blue: 254.0/255.0, alpha: 1.0)
    }
  }
}

struct ThemeManager {
  static func currentTheme() -> Theme {
    if (UserDefaults.standard.object(forKey: kTheme) != nil) {
      return Theme.init(rawValue: UserDefaults.standard.integer(forKey: kTheme))!
    } else {
      return .light
    }
  }

  static func applyTheme(_ theme: Theme) {
    let application = UIApplication.shared
    application.delegate?.window??.tintColor = theme.tintColor
    application.delegate?.window??.backgroundColor = theme.backgroundColor
    UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self]).textColor = theme.tableSectionHeaderFontColor
  }
}
