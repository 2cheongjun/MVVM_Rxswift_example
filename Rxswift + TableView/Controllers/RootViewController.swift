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
    
    // MARK : properties
    let disposeBag = DisposeBag()
    let viewModel: RootViewModel
    
    // collectionView
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = .systemBackground
        
        return cv
        
    }()
    
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
        configureCollectionView()
        fetchArticles()
        subscribe()
    }
    
    func configureUI(){
        view.backgroundColor  = .systemBackground
        
        self.title = self.viewModel.title
        
        //컬렉션뷰 붙이기
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    func configureCollectionView(){
        self.collectionView.register(ArticleCell.self, forCellWithReuseIdentifier:  "cell")
    }
    
    
    // 아티클 받아오기
    func fetchArticles(){
        viewModel.fetchArticles().subscribe(onNext: { articleViewModels in
            
            print("articleViewModels",articleViewModels)
            self.articleViewModel.accept(articleViewModels)
        }).disposed(by: disposeBag)
    }
    
    // 아티클뷰모델을 관찰하고 있다가 구독을 하면, 컬렉션뷰를 리로드한다.
    func subscribe(){
        self.articleViewModelObserver.subscribe(onNext: { articles in
            // 콜렉션뷰 리로드
//            print(articles)
           
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }).disposed(by: disposeBag)
    }
}


extension RootViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.articleViewModel.value.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ArticleCell
        
        cell.imageView.image = nil
        
        let articleViewModel = self.articleViewModel.value[indexPath.row]
        cell.viewModel.onNext(articleViewModel)
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath:IndexPath) ->CGSize{
        return CGSize(width: view.frame.width, height: 120)
    }

    
    
}
