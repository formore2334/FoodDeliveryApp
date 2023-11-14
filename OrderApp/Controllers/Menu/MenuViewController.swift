//
//  MenuViewController.swift
//  OrderApp
//
//  Created by ForMore on 28/10/2023.
//

import UIKit

class MenuViewController: UICollectionViewController {

    var coordinator: MainCoordinator?
    
    var menu: [Menu] = Menu.mockData
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureVC()
    }
    
    func configureVC() {
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: MenuCell.identifier)
        collectionView.register(MenuHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: MenuHeaderView.identifier)
        collectionView.collectionViewLayout = layoutCollection()
        setBackgroundImage()
    }
    
    func setBackgroundImage() {
        let backgroundImageView = UIImageView(image: UIImage(named: "backgroundFullImage"))
        backgroundImageView.contentMode = .scaleAspectFit
        backgroundImageView.clipsToBounds = true
        backgroundImageView.layer.opacity = 0.3

        collectionView.backgroundView = backgroundImageView
    }

}


//MARK: - Data Source

extension MenuViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menu.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu[section].menuItem.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MenuCell.identifier, for: indexPath) as! MenuCell

        let menuItem = menu[indexPath.section].menuItem[indexPath.item]
        cell.configure(name: menuItem.imageName, title: menuItem.title)

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MenuHeaderView.identifier, for: indexPath) as! MenuHeaderView
        
        headerView.titleLabel.text = menu[indexPath.section].title
        return headerView
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailInfoVC = DetailInfoViewController(menuItem: menu[indexPath.section].menuItem[indexPath.item], coordinator: coordinator)
        
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
}


//MARK: - Layout

extension MenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 50, right: 20)
        layout.minimumLineSpacing = 50
        
        return layout
    }
    
}
