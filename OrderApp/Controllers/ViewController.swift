//
//  ViewController.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class ViewController: UIViewController {
    
   // private var titleLabel = UILabel()
    private var collectionView: UICollectionView?

    private let models = Array(repeating: "cube", count: 10)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layoutCollection()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
       
        configureCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 100, width: view.frame.size.width, height: 150).integral
    }

    
    func layoutCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 150, height: 150)
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
//    func configureTitleLabel() {
//        view.addSubview(titleLabel)
//        titleLabel
//    }
    
    func configureCollectionView() {
        
        collectionView?.register(CircleCollectionViewCell.self, forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        collectionView?.register(HeaderCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.idintifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = .white
        guard let myCollection = collectionView else {
            return
        }
        
        view.addSubview(myCollection)
        
    }
    
}


extension ViewController: UICollectionViewDelegate {
    
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CircleCollectionViewCell.identifier, for: indexPath) as! CircleCollectionViewCell
        cell.configure(with: models[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.idintifier, for: indexPath) as! HeaderCollectionReusableView
        
        header.configureTitleLabel()
        return header

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 40)
    }
    
    
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
}
