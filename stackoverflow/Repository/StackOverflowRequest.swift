//
//  StackOverflowRequest.swift
//  stackoverflow
//
//  Created by Innocent Magagula on 2020/04/26.
//  Copyright © 2020 Innocent Magagula. All rights reserved.
//

import Foundation
import APIKit

protocol StackOverflowRequest: Request {}

extension StackOverflowRequest {
    var baseURL: URL {
        return URL(string: "https://api.stackexchange.com/2.2")!
    }
}

extension StackOverflowRequest {
    func intercept(object: Any, urlResponse: HTTPURLResponse) throws -> Any {
        switch urlResponse.statusCode {
        case 200..<300:
            return object
        default:
            throw NSError(domain: "Bad Status Response", code: urlResponse.statusCode, userInfo: nil)
        }
    }
}

struct DecodableDataParser: DataParser {
    let contentType: String? = "application/json"

    func parse(data: Data) throws -> Any {
        return data
    }
}

extension StackOverflowRequest where Response: Decodable {
    var dataParser: DataParser {
        return DecodableDataParser()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        guard let data = object as? Data else {
            throw ResponseError.unexpectedObject(object)
        }
        return try JSONDecoder().decode(Response.self, from: data)
    }
}

