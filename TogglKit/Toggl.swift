//
//  Toggl.swift
//  TogglKit
//
//  Created by tinpay on 2015/10/03.
//  Copyright © 2015年 tinpay. All rights reserved.
//

import APIKit
import Result

public class Toggl:Session {
    public static var token:String?
    
    public class func request<T:TogglRequest>(var request: T,completion: (result:Result<T.Response,TogglError> )->Void) -> Void {
        request.token = self.token
        sendRequest(request) {result in
            switch result {
            case .Success(let response):
                completion(result: .Success(response))
            case .Failure(_):
                completion(result: .Failure(TogglError(rawText:"error")))
            }
        }
    }
}

