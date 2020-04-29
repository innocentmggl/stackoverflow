//
//  AnswerRepository.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/27.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//
 
import Foundation
import APIKit

final class AnswerRepository {
    
    func answers(questionId: QuestionId, handler: @escaping (Result<[Answer], Error>) -> Void) {
        let request = AnswerApi.AnswersRequest(questionId: questionId)
        Session.send(request) { result in
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
    }
}
