//
//  TipCalculatorViewController.swift
//  TipCalculator
//
//  Created by Lyudmyla Ivanova on 9/6/16.
//  Copyright © 2016 Lyudmyla Ivanova. All rights reserved.
//

import UIKit

class TipCalculatorViewController: UIViewController {

  @IBOutlet weak var tipLabel: UILabel!
  @IBOutlet weak var totalLabel: UILabel!
  @IBOutlet weak var billTextField: UITextField!
  @IBOutlet weak var tipSegmentedControl: UISegmentedControl!

  let minTipKey = "kMinimumTip"
  let defaultTipKey = "kDefaultTip"
  let maxTipKey = "kMaximumTip"
  let billAmountExpirationDateKey = "kBillAmountExpirationDate"
  let billAmountKey = "kBillAmount"
  let selectedTipPercentageKey = "kTipPercentage"

  let tipPercentages = ["18", "20", "25"]

  enum Keys: String {
    case kMinimumTip, kDefaultTip, kMaximumTip
    static let keysArray: Array = ["kMinimumTip", "kDefaultTip", "kMaximumTip"]
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    self.billTextField.becomeFirstResponder()
    if (UserDefaults.standard.object(forKey: billAmountExpirationDateKey) != nil) {
      let billAmountExpirationDate = UserDefaults.standard.object(forKey: billAmountExpirationDateKey) as! Date
      if ((billAmountExpirationDate.compare(Date()) == .orderedDescending) &&
        (UserDefaults.standard.string(forKey: billAmountKey) != nil)) {
        billTextField.text = UserDefaults.standard.string(forKey: billAmountKey)
        tipSegmentedControl.selectedSegmentIndex = UserDefaults.standard.integer(forKey: selectedTipPercentageKey)
      } else {
        tipSegmentedControl.selectedSegmentIndex = 1
      }
    }
    setSegmentedControlValues()

    calculateTip()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  func setSegmentedControlValues() {
    var index = 0
    for key in Keys.keysArray {
      if (UserDefaults.standard.integer(forKey: key) != 0) {
        tipSegmentedControl.setTitle("\(UserDefaults.standard.integer(forKey: key))%", forSegmentAt: index)
      } else {
        tipSegmentedControl.setTitle("\(tipPercentages[index])%", forSegmentAt: index)
      }
      index += 1
    }
  }

  @IBAction func onMainViewTapped(_ sender: AnyObject) {
    view.endEditing(true)
  }

  @IBAction func tipAmountSegmentedControlTapped(_ sender: AnyObject) {
    let defaults = UserDefaults.standard
    defaults.set(tipSegmentedControl.selectedSegmentIndex, forKey:selectedTipPercentageKey)
    defaults.synchronize()

    calculateTip()
  }

  @IBAction func billAmountChanged(_ sender: AnyObject) {
    let defaults = UserDefaults.standard
    if (Double(billTextField.text!) != nil) {
      defaults.set(Date(timeIntervalSinceNow: 600), forKey: billAmountExpirationDateKey)
      defaults.set(billTextField.text, forKey: billAmountKey)
      defaults.set(tipSegmentedControl.selectedSegmentIndex, forKey:selectedTipPercentageKey)
      defaults.synchronize()
    }
    calculateTip()
  }

  func calculateTip() {
    var bill = 0.0
    if (billTextField.text != "") {
      bill = Double(NumberFormatter().number(from: (billTextField.text)!)!).roundToDecimalPlaces(places:2)
    }
    let tip = bill * Double(String(tipSegmentedControl.titleForSegment(at: tipSegmentedControl.selectedSegmentIndex)!.characters.dropLast()))! / 100
    let total = bill + tip

    // display locale-specific currency and currency thousands separators
    let numberFormatter = NumberFormatter()
    numberFormatter.locale = Locale.current
    numberFormatter.usesGroupingSeparator = true
    numberFormatter.numberStyle = .currency
    numberFormatter.maximumFractionDigits = 2
    numberFormatter.minimumFractionDigits = 2
    numberFormatter.minimumIntegerDigits = 1
    tipLabel.text = numberFormatter.string(from: NSNumber(value:tip))!
    totalLabel.text = numberFormatter.string(from: NSNumber(value:total))!
  }
}
