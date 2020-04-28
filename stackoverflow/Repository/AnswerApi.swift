//
//  AnswerApi.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import APIKit

final class AnswerApi {

    struct AnswersRequest: StackOverflowRequest {

        let questionId: Int
        let path: String
        let method: HTTPMethod = .get
        
        init(questionId: Int) {
            print(questionId)
            self.questionId = questionId
            self.path = "/questions/\(questionId)/answers"
        }

        var parameters: Any? {
            var params = [String: Any]()
            params["order"] = "desc"
            params["sort"] = "activity"
            params["site"] = "stackoverflow"
            params["filter"] = "withbody"
            return params
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [Answer] {
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let res = try decoder.decode(AnswersResponse.self, from: data)
            return res.items
        }
    }
}

