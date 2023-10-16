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
    
    collectionView?.register(SaleCollectionViewCell.self, forCellWithReuseIdentifier: SaleCollectionViewCell.identifier)
    collectionView?.register(SaleCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SaleCollectionReusableView.idintifier)
    collectionView?.showsHorizontalScrollIndicator = false
    collectionView?.backgroundColor = .white
    
    guard let myCollection = collectionView else {
        return
    }
    view.addSubview(myCollection)
}

}


extension SaleViewController: UICollectionViewDelegate {

func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: true)
    print("You tapped me")
    let categoryDetailVC = CategoryDetailMenuViewController()
    
    navigationController?.pushViewController(categoryDetailVC, animated: true)
}

}

extension SaleViewController: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.identifier, for: indexPath) as! SaleCollectionViewCell
    
    cell.configure(name: models[indexPath.row], title: "Cola")
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

