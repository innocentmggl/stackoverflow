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
    
    func search(title: String, handler: @escaping (Result<[Question], NSError>) -> Void) -> SessionTask? {
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
            case .failure(let error):
                switch error{
                //dont show cancelled request errors
                case .connectionError(let connectionError as NSError):
                    if connectionError.code == -999 {
                        return
                    }
                    handler(Result.failure(error as NSError))
                default:
                    handler(Result.failure(error as NSError))
                }
                #if DEBUG
                print("------------ Failed API Request ------------")
                print("\(error)")
                print("---------------------------------------------")
                #endif
            }
        }
        return session
    }
}
