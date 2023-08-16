//
//  AlamofireAPIManager.swift
//  API_Project
//
//  Created by t2023-m0050 on 2023/08/16.
//

import Foundation

//데이터를 보낼 때 바꿔서 보낼것이다 : Encodable
//서버 연동할 때 데이터 보내주는 것
struct FotoAPIInput: Encodable {
    var limit: Int?
    var page: Int?
}
