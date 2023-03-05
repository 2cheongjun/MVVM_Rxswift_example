//
//  Article.swift
//  Rxswift + TableView
//
//  Created by 이청준 on 2023/03/06.
//

import Foundation


//9b1132a9267c46cda44b00521dff939c

//뉴스 API를 받아올 구조체 생성
struct ArticleResponse : Codable {
    let status: String
    let totalResults: Int
    let articles:[Article]
}

struct Article: Codable {
    let author: String?
    let title: String?
    let description: String?
    let url:String?
    let publishedAt: String?
}
