//
//  RootViewController.swift
//  Rxswift + TableView
//
//  Created by 이청준 on 2023/03/05.
//

import UIKit
import RxSwift
import RxRelay

class RootViewController : UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    //relay (아티클뷰모델 값을 받아올때마다..) 옵져버블 형태로 받아와서
    private let articleViewModel = BehaviorRelay<[ArticleViewModel]>(value: [])
    var articleViewModelObserver: Observable<[ArticleViewModel]>{
        return articleViewModel.asObservable()
    }
    
    init(viewModel:RootViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad(){
        super.viewDidLoad()
        
        configureUI()
        fetchArticles()
        subscribe()
    }
    
    func configureUI(){
        view.backgroundColor  = .systemBackground
    }
    
    // 아티클 받아오기
    func fetchArticles(){
        viewModel.fetchArticles().subscribe(onNext: { articleViewModels in
            self.articleViewModel.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }
    
    // 아티클뷰모델을 관찰하고 있다가 구독을 하면, 컬렉션뷰를 리로드한다.
    func subscribe(){
        self.articleViewModelObserver.subscribe(onNext: { articles in
            // 콜렉션뷰 리로드
            print(articles)
        }).disposed(by: disposeBag)
    }

    
}
