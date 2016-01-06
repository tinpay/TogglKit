//
//  TogglError.swift
//  TogglKit
//
//  Created by cw_fukui on 2016/01/07.
//  Copyright © 2016年 tinpay. All rights reserved.
//

import Foundation

public enum TogglError: ErrorType,CustomStringConvertible {
    case InvalidToken
    case OtherError(String)
    public init(rawText: String) {
        let dic: [String:TogglError] = [
            "invalid_token"         : .InvalidToken,
        ]
        
        guard let v = dic[rawText] else {
            self = .OtherError(rawText)
            return
        }
        
        self = v
    }
    
    public var description: String {
        switch self {
        case InvalidToken        : return "Invalid token"
        case OtherError(let str) : return "Error: \(str)"
        }
    }
}
