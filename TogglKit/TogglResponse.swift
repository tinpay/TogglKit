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
        return try build(TimeEntry.init)(
            e <| "wid",
            e <|? "pid",
            e <| "start",
            e <|? "stop",
            e <| "duration",
            e <| "description",
            e <||? "tags"
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
        return try build(Project.init)(
            e <| "name",
            e <| "billable",
            e <| "is_private",
            e <| "active",
            e <| "template",
            e <| "color"
        )
    }
}