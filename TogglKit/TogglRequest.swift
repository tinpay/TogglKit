//
//  TogglRequest.swift
//  TogglKit
//
//  Created by tinpay on 2015/09/11.
//  Copyright © 2015年 tinpay. All rights reserved.
//
import APIKit
import Himotoki


public protocol TogglRequest: RequestType {
    var token:String? {get set}
}

private var tokenStringKey: UInt8 = 0

public extension TogglRequest where Self: AnyObject {
    public var token: String? {
        get {
            guard let object = objc_getAssociatedObject(self, &tokenStringKey) as? String else {
                return nil
            }
            return object
        }
        set {
            objc_setAssociatedObject(self, &tokenStringKey, newValue, .OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    public var baseURL:NSURL {
        return NSURL(string:"https://www.toggl.com/api/v8")!
    }
    func configureURLRequest(URLRequest: NSMutableURLRequest) throws -> NSMutableURLRequest {
        guard let username = token else {
            throw NSError(domain: "", code: 500, userInfo: nil)
        }
        let password = "api_token"
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions([])
        
        URLRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        return URLRequest
    }
}

public class WorkspacesRequest:TogglRequest {
    public init(){
    }
    public typealias Response = [Workspace]
    public var method: HTTPMethod {return .GET}
    public var path:String {return "/workspaces"}
    
    
    public func responseFromObject(object:AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return try? decodeArray(object)
    }
    
}

public class ProjectsRequest:TogglRequest {
    let workspaceId:Int
    public init(workspaceId:Int){
        self.workspaceId = workspaceId
    }
    public typealias Response = [Project]
    public var method: HTTPMethod {return .GET}
    public var path:String {return "/workspaces/\(workspaceId)/projects"}
    
    
    public func responseFromObject(object:AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return try? decodeArray(object)
    }
}


public class ProjectRequest:TogglRequest {
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


public class ClientsRequest:TogglRequest {
    let workspaceId:Int
    public init(workspaceId:Int){
        self.workspaceId = workspaceId
    }
    public typealias Response = [Client]
    public var method: HTTPMethod {return .GET}
    public var path:String {return "/workspaces/\(workspaceId)/clients"}
    
    
    public func responseFromObject(object:AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return try? decodeArray(object)
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
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        return [
            "start_date": dateFormatter.stringFromDate(startDate),
            "end_date": dateFormatter.stringFromDate(endDate)
        ]
    }
    
    public func responseFromObject(object:AnyObject, URLResponse: NSHTTPURLResponse) -> Response? {
        return try? decodeArray(object)
    }
}

