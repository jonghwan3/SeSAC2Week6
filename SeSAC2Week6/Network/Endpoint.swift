//
//  Endpoint.swift
//  SeSAC2Week6
//
//  Created by 박종환 on 2022/08/08.
//

import Foundation

enum Endpoint {
    case blog
    case cafe
    //저장 프로퍼티를 못 쓰는 이유? init을 할 수 없어서, 연산 프로퍼티를 사용할 수 있는 이유? 메서드처럼 사용가능하기 때문에
    var requestURL: String {
        switch self {
        case .blog:
            return URL.makeEndPointString("blog?query=")
        case.cafe:
            return URL.makeEndPointString("cafe?query=")
        }
    }
}


