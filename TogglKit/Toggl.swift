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
}

extension Toggl {

    public class func request<T:TogglRequest>(request: T,completion: (result:Result<T.Response,APIError> )->Void) -> Void {
        
        sendRequest(request) {result in
            switch result {
            case .Success(let response):
                completion(result: .Success(response))
            case .Failure(let error):
                completion(result: .Failure(error))
            }
        }
    }
}