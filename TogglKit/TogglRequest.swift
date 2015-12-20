//
//  TogglRequest.swift
//  TogglKit
//
//  Created by tinpay on 2015/09/11.
//  Copyright (c) 2015年 tinpay. All rights reserved.
//
import APIKit
import Himotoki


public protocol TogglRequest: RequestType {
    
}

public var togglAPIToken:String = ""

public extension TogglRequest {
    public var baseURL:NSURL {
        return NSURL(string:"https://www.toggl.com/api/v8")!
    }
    func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
        let username = togglAPIToken
        let password = "api_token"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        URLRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        return URLRequest
    }
}


public class TimeEntriesRequest:TogglRequest {
    let startDate:NSDate
    let endDate:NSDate
    
    public init(startDate:NSDate,endDate:NSDate){
        self.startDate = startDate
        self.endDate = endDate
    }
    public typealias Response = [TimeEntry]
    public var method: HTTPMethod {return .GET}
    public var path:String {return "/time_entries"}

    
    public var parameters: [String: AnyObject] {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss+09:00"
        return [
            "start_date": dateFormatter.stringFromDate(startDate),
            "end_date": dateFormatter.stringFromDate(endDate)
        ]
    }
    
    public func responseFromObject(object:AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return try? decodeArray(object)
    }
}



public class ProjectsRequest:TogglRequest {
    let projectId:Int
    public init(projectId:Int){
        self.projectId = projectId
    }
    public typealias Response = Project
    public var method: HTTPMethod {return .GET}
    public var path:String {return "/projects/\(projectId)"}
    

    public func responseFromObject(object:AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return try? decode(object)
    }
}


