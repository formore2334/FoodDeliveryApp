//
//  ViewController.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class PopularCategoriesViewController: UIViewController {
        
    private var titleLabel = UILabel()
    private var collectionView: UICollectionView?

    private let models = Array(repeating: "cube", count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Welcome!"
        
        navigationController?.navigationBar.isHidden = false
        
        layoutCollection()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 250).integral
    }

    
    func layoutCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 130, height: 130)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.sectionHeadersPinToVisibleBounds = true

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    
    func configureCollectionView() {
        
        collectionView?.register(PopularCategoriesCollectionViewCell.self, forCellWithReuseIdentifier: PopularCategoriesCollectionViewCell.identifier)
        collectionView?.register(PopularCategoriesHeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PopularCategoriesHeaderCollectionReusableView.idintifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = .white
        
        guard let myCollection = collectionView else {
            return
        }
        view.addSubview(myCollection)
    }
    
}


extension PopularCategoriesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        print("You tapped me")
        let categoryDetailVC = CategoryDetailMenuViewController()
        
        navigationController?.pushViewController(categoryDetailVC, animated: true)
    }
    
}

extension PopularCategoriesViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCategoriesCollectionViewCell.identifier, for: indexPath) as! PopularCategoriesCollectionViewCell
        
        cell.configure(name: models[indexPath.row], title: "Cola")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: PopularCategoriesHeaderCollectionReusableView.idintifier, for: indexPath) as! PopularCategoriesHeaderCollectionReusableView

        header.configureTitleLabel()
        return header
    }  
}

extension PopularCategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 35)
    }
}
