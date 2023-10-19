//
//  SaleViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

class SaleViewController: UIViewController {
    
    private var titleLabel = UILabel()
    private var collectionView: UICollectionView?
    
    private let sales: [Sale] = Sale.mockData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        
        layoutCollection()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        configureCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 350).integral
    }
    
    
    func layoutCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 200, height: 250)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.sectionHeadersPinToVisibleBounds = true
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    
    func configureCollectionView() {
        
        collectionView?.register(SaleCollectionViewCell.self, forCellWithReuseIdentifier: SaleCollectionViewCell.identifier)
        collectionView?.register(SaleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SaleCollectionReusableView.idintifier)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = .white
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }
    
}


extension SaleViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let detailSaleVC = DetailSaleViewController(sale: sales[indexPath.row])
        
        navigationController?.pushViewController(detailSaleVC, animated: true)
    }
    
}

extension SaleViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sales.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.identifier, for: indexPath) as! SaleCollectionViewCell
        
        cell.configure(name: sales[indexPath.row].imageName, title: sales[indexPath.row].title)
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SaleCollectionReusableView.idintifier, for: indexPath) as! SaleCollectionReusableView
        
        header.configureTitleLabel()
        return header
    }
    
}

extension SaleViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 10, height: 35)
    }
    
}

