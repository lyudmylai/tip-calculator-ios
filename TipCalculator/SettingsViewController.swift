//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Lyudmyla Ivanova on 9/6/16.
//  Copyright © 2016 Lyudmyla Ivanova. All rights reserved.
//

import UIKit
let themeKey = "currentTheme"

class SettingsViewController: UITableViewController, UITextFieldDelegate {
  @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
  @IBOutlet weak var minimumTextField: UITextField!
  @IBOutlet weak var defaultTextField: UITextField!
  @IBOutlet weak var maximumTextField: UITextField!
  @IBOutlet var settingsTableView: UITableView!

  let minTipKey = "kMinimumTip"
  let defaultTipKey = "kDefaultTip"
  let maxTipKey = "kMaximumTip"

  var filteredInput = ""

  override func viewDidLoad() {
    super.viewDidLoad()

    self.settingsTableView.backgroundColor = UIApplication.shared.delegate?.window??.backgroundColor
    self.themeSegmentedControl.selectedSegmentIndex = (UserDefaults.standard.integer(forKey: kTheme))
    self.minimumTextField.delegate = self
    self.minimumTextField.becomeFirstResponder()
    self.defaultTextField.delegate = self
    self.maximumTextField.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func setTipAmount(_ textFieldIdentifier:String, text:String) {
    let defaults = UserDefaults.standard
    switch textFieldIdentifier {
    case "minimumTextField":
      defaults.set(Int(text)!, forKey: minTipKey)
    case "defaultTextField":
      defaults.set(Int(text)!, forKey: defaultTipKey)
    case "maximumTextField":
      defaults.set(Int(text)!, forKey: maxTipKey)
    default:
      break
    }
  }

  @IBAction func themeSegmentedControlTapped(_ sender: AnyObject) {
    setAppTheme()
  }

  func setAppTheme() {
    let appThemes = ["0", "1"]
    let defaults = UserDefaults.standard
    defaults.set(appThemes[themeSegmentedControl.selectedSegmentIndex], forKey: themeKey)
    defaults.synchronize()
    let theme = ThemeManager.currentTheme()

    // animate change of the theme
    UIView.animate(withDuration: 1.0, animations: {
      ThemeManager.applyTheme(theme)
      self.settingsTableView.backgroundColor = UIApplication.shared.delegate?.window??.backgroundColor
    })


    let indexSet = IndexSet(integersIn: (NSRange(location: 0, length: self.tableView.numberOfSections)).toRange() ?? 0..<0);
    self.tableView.reloadSections(indexSet, with: UITableViewRowAnimation.none)
  }

  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    return true
  }

  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
    UserDefaults.standard.synchronize()
    filteredInput = ""
    return true
  }

  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let digits = CharacterSet.decimalDigits
    let input = string
    for unicodeScalar in (input.unicodeScalars) {
      if digits.contains(UnicodeScalar(unicodeScalar.value)!) {
        filteredInput.append(String(unicodeScalar))
      }
    }
    if (filteredInput.characters.count > 0) {
      setTipAmount(textField.restorationIdentifier!, text: filteredInput)
    }
    return true
  }
}
