//
//  RootViewModel.swift
//  Rxswift + TableView
//
//  Created by 이청준 on 2023/03/07.
//

import Foundation
import RxSwift

final class RootViewModel {
    let title = "June News"
    
    private let articleService: AriticleServiceProtocol
    
    init(articleService: AriticleServiceProtocol){
        self.articleService = articleService
    }
    
    // 아티클 내용 반환하기
    func fetchArticles() -> Observable<[ArticleViewModel]> {
        return articleService.fetchNews().map { $0.map { ArticleViewModel(article: $0) } }
    }
}
