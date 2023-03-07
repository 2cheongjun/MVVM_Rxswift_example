//
//  ArticleCell.swift
//  Rxswift + TableView
//
//  Created by 이청준 on 2023/03/08.
//

import UIKit
import RxSwift
import SDWebImage

class ArticleCell: UICollectionViewCell {
    
    // MARK : Properties
    var viewModel = PublishSubject<ArticleViewModel>()
    let disposBag = DisposeBag()
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.layer.cornerRadius = 8
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.widthAnchor.constraint(equalToConstant: 60).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 60).isActive = true
        iv.backgroundColor = .secondarySystemBackground
        return iv
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        return label
    }()
    
    private lazy var descriptionLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        return label
    }()
    
    
    
    // MARK : Lifecycles
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
        subscribe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // 뷰모델 값이 변하면 구독하는 함수
    func subscribe(){
        self.viewModel.subscribe(onNext: { articleViewModel in
            if let urlString = articleViewModel.imageUrl {
                self.imageView.sd_setImage(with:URL(string: urlString), completed: nil)
                
                self.titleLabel.text = articleViewModel.title
                self.descriptionLabel.text = articleViewModel.description
            }
        })
    }
    
    
    //MARK: Configures
    func configureUI(){
        backgroundColor = .systemBackground
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 20).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -40).isActive = true
        
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo:titleLabel.leftAnchor).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: titleLabel.rightAnchor).isActive = true
    }
}
