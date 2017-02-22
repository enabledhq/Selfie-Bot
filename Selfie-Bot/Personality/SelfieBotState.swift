//
//  SelfieBotState.swift
//  Selfie-Bot
//
//  Created by Simeon on 22/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation

enum SelfieBotState {
    
    case idle(screen: AppState)
    case analysing(numFaces: Int)
    case judgment /* accepts high level abstraction on cognito results */
    case firstUse
    
}

struct SelfieBotMemory {
    
    typealias Event = (SelfieBotState, Date)
    
    var contents: [Event] = []
    
}
