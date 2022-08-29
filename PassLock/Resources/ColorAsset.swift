//
//  ColorAsset.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 23/08/22.
//

import Foundation
import UIKit
enum ColorAsset : String {
    case lightBlue
    case lightRed
    case lightYellow
    case lightGray
    var asset : UIColor? {
        return UIColor(named: self.rawValue)
    }
}
