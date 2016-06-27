//
//  TogglResponse.swift
//  TogglKit
//
//  Created by tinpay on 2015/10/18.
//  Copyright © 2015年 tinpay. All rights reserved.
//

import Himotoki

public struct TimeEntry: Decodable {
    public let wid:Int
    public let pid:Int?
    public let start:String
    public let stop:String?
    public let duration:Int
    public let description:String
    public let tags:[String]?
    
    public static func decode(e: Extractor) throws -> TimeEntry {
        return self.init(
            wid:try e <| "wid",
            pid:try e <|? "pid",
            start:try e <| "start",
            stop:try e <|? "stop",
            duration:try e <| "duration",
            description:try e <| "description",
            tags:try e <||? "tags"
        )
    }
}

public struct Project: Decodable {
    public let name:String
    public let billable:Bool
    public let isPrivate:Bool
    public let active:Bool
    public let template:Bool
    public let color:String
    
    public static func decode(e: Extractor) throws -> Project {
        return self.init(
            name:try  e <| "name",
            billable:try  e <| "billable",
            isPrivate:try  e <| "is_private",
            active:try  e <| "active",
            template:try  e <| "template",
            color:try  e <| "color"
        )
    }
}