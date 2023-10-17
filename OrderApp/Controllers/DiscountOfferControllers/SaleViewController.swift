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

private let models: [Menu] = [
    Menu(imageName: "cube", title: "Combo", description: "Nice food", menuItem: [
        MenuItem(imageName: "cube", title: "Combo 1", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Combo 2", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Combo 3", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Combo 4", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Combo 5", description: "Good Choise to..")
        ]),
    Menu(imageName: "cube", title: "Burgers", description: "Nice food", menuItem: [
        MenuItem(imageName: "cube", title: "Burger 1", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Burger 2", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Burger 3", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Burger 4", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Burger 5", description: "Good Choise to..")
        ]),
    Menu(imageName: "cube", title: "Fries", description: "Nice food", menuItem: [
        MenuItem(imageName: "cube", title: "Fries 1", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Fries 2", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Fries 3", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Fries 4", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Fries 5", description: "Good Choise to..")
        ]),
    Menu(imageName: "cube", title: "Drinks", description: "Nice food", menuItem: [
        MenuItem(imageName: "cube", title: "Drinks 1", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Drinks 2", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Drinks 3", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Drinks 4", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Drinks 5", description: "Good Choise to..")
        ]),
    Menu(imageName: "cube", title: "Souses", description: "Nice food", menuItem: [
        MenuItem(imageName: "cube", title: "Souses 1", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Souses 2", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Souses 3", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Souses 4", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Souses 5", description: "Good Choise to..")
        ]),
    Menu(imageName: "cube", title: "Chicken", description: "Nice food", menuItem: [
        MenuItem(imageName: "cube", title: "Chicken 1", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Chicken 2", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Chicken 3", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Chicken 4", description: "Good Choise to.."),
        MenuItem(imageName: "cube", title: "Chicken 5", description: "Good Choise to..")
        ])
]

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
    collectionView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 250).integral
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
    let categoryDetailVC = CategoryDetailMenuViewController(menuItem: models[indexPath.row].menuItem)
    
    navigationController?.pushViewController(categoryDetailVC, animated: true)
}

}

extension SaleViewController: UICollectionViewDataSource {

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return models.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaleCollectionViewCell.identifier, for: indexPath) as! SaleCollectionViewCell
    
    cell.configure(name: models[indexPath.row].imageName, title: models[indexPath.row].title)
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

