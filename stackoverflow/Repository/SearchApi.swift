//
//  SearchApi.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import APIKit

final class SearchApi {
    
    struct SearchRequest: StackOverflowRequest {

        let title: String
        let pageSize: Int
        let method: HTTPMethod = .get
        let path: String = "/search/advanced"

        init(title: String, pageSize: Int) {
            self.title = title
            self.pageSize = pageSize
        }

        var parameters: Any? {
            var params = [String: Any]()
            params["pageSize"] = pageSize
            params["order"] = "desc"
            params["sort"] = "activity"
            params["title"] = title
            params["site"] = "stackoverflow"
            params["filter"] = "withbody"
            return params
        }

        func response(from object: Any, urlResponse: HTTPURLResponse) throws -> [Question] {
            guard let data = object as? Data else {
                throw ResponseError.unexpectedObject(object)
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            let res = try decoder.decode(QuestionsResponse.self, from: data)
            return res.items
        }
    }
}

