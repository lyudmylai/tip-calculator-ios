//
//  Double+Conversion.swift
//  TipCalculator
//
//  Created by Lyudmyla Ivanova on 9/14/16.
//  Copyright © 2016 Lyudmyla Ivanova. All rights reserved.
//

import Foundation

extension Double {
  func roundToDecimalPlaces(places: Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
