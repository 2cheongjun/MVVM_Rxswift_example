//
//  ArticleService.swift
//  Rxswift + TableView
//
//  Created by 이청준 on 2023/03/06.
//

import Foundation
import Alamofire
import RxSwift

//프로토콜 생성, 뷰모델에 갖다씀
protocol AriticleServiceProtocol{
    func fetchNews() -> Observable<[Article]>
}

// 테스트 코드
class stubArticleService: AriticleServiceProtocol {
    func fetchNews() -> Observable<[Article]> {
        
        return Observable.create { (observer) -> Disposable in
            
            Article(author: "june", title: "title", urlToImage: "", description: "description", url: "123", publishedAt: "123213")
            Article(author: "june", title: "title", urlToImage: "",description: "description", url: "123", publishedAt: "123213")
            Article(author: "june", title: "title", urlToImage: "",description: "description", url: "123", publishedAt: "123213")
            
            return Disposables.create()
        }
    }
}


//뉴스요청API (프로토콜 적용)
class ArticleService : AriticleServiceProtocol {
    
    //Rx적용
    // 아티클의 옵져버블로  반환
    func fetchNews() -> Observable<[Article]> {
        return Observable.create { (observer) -> Disposable in
            
            // 콜백함수의 에러와 아티클 리턴값을 받는다.
            self.fetchNews{ (error,articles) in
                // 에러를 받았을때
                if let error = error {
                    observer.onError(error)
                }
                
                // 아티클을 받았을때
                if let articles  = articles{
                    observer.onNext(articles)
                }
                
                observer.onCompleted()
            }
            
            return Disposables.create()// 옵져버가 끝났을때 메모리 지움
        }
    }
    
    
    // 콜백함수
    private func fetchNews(completion: @escaping((Error?, [Article]?)->Void)) {
        let urlStirng = "https://newsapi.org/v2/everything?q=apple&from=2023-03-04&to=2023-03-04&sortBy=popularity&apiKey=9b1132a9267c46cda44b00521dff939c"
        
        guard let url = URL(string: urlStirng) else { return completion(NSError(domain: "june", code: 404, userInfo: nil),nil)}
        
        AF.request(url, method: HTTPMethod.get, parameters: nil, encoding: JSONEncoding.default, headers: nil, interceptor: nil, requestModifier:
                    nil).responseDecodable(of: ArticleResponse.self) { response in
            
            // 에러가 있으면 에러리턴
            if let error = response.error {
                return completion(error, nil)
            }
            
            // 에러가 없으면 아티클리턴
            if let articles = response.value?.articles {
                return completion(nil, articles)
            }
                
        }
    }
    
}
