//
//  SearchRespository.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/25.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import APIKit

final class SearchRespository {
    
    func search(title: String, handler: @escaping (Result<[Question], Error>) -> Void) -> SessionTask? {
        let request = SearchApi.SearchRequest(title: title, pageSize: 20)
        let session = Session.send(request) { result in
            switch result {
            case .success(let response):
                handler(Result.success(response))
                #if DEBUG
                print("------------ Success API Request ------------")
                print("\(response)")
                print("---------------------------------------------")
                #endif
            case .failure(let taskError):
                switch taskError {
                case .connectionError(let error):
                    handler(Result.failure(error))
                case .requestError(let error):
                    handler(Result.failure(error))
                case .responseError(let error):
                    handler(Result.failure(error))
                }
                #if DEBUG
                print("------------ Failed API Request ------------")
                print("\(taskError)")
                print("---------------------------------------------")
                #endif
            }
        }
        return session
    }
}
