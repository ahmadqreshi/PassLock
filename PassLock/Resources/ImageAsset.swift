//
//  ImageAsset.swift
//  PassLock
//
//  Created by Ahmad Qureshi on 01/08/22.
//

import Foundation
import UIKit
enum ImageAsset : String {
    case tutorialBg
    case backButton = "arrow.left"
    case delete
    var asset : UIImage? {
        return UIImage(named: self.rawValue)
    }
    var systemAsset : UIImage? {
        return UIImage(systemName: self.rawValue)
    }
}
