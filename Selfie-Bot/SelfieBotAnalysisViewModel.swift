//
//  SelfieBotAnalysisViewModel.swift
//  Selfie-Bot
//
//  Created by John Smith on 24/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import UIKit

class SelfieBotAnalysisViewModel {
    let image: UIImage
    let options: [String:Double]
    let qoute: String
    
    init(image: UIImage, options: [String:Double], qoute: String) {
        self.image = image
        self.options = options
        self.qoute = qoute
    }
}
