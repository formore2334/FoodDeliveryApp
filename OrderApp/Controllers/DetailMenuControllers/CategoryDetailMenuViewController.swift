//
//  SecondViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

// MARK: - Detail menu for each category from menu

class CategoryDetailMenuViewController: UIViewController {

    var menu: Menu
    
    private var titleLabel = UILabel()
    
    private var collectionView: UICollectionView?
    
    init(menu: Menu) {
        self.menu = menu
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTitleLabel()
        configureVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .white
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }

   //MARK: - Configure CollectionView
    
    func configureVC() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection())
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        
        setConstraints()
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(DetailMenuCollectionViewCell.self, forCellWithReuseIdentifier: DetailMenuCollectionViewCell.identifier)
        collectionView.register(DetailMenuReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailMenuReusableView.idintifier)
    }
    
    
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 20
        layout.sectionHeadersPinToVisibleBounds = true
        
        return layout
    }
    
    //MARK: - App Logo
    
    func configureTitleLabel() {
        
        view.addSubview(titleLabel)
        titleLabel.text = "Welm's"
        titleLabel.textColor = .white
        titleLabel.frame = CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 90)
        titleLabel.backgroundColor = UIColor(named: "redOrange")
        titleLabel.font = UIFont.boldSystemFont(ofSize: 25)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
    
    }
    
    //MARK: - Constraints
    func setConstraints() {
        guard let collectionView = collectionView else { return }
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

}

//MARK: - Delegat's

extension CategoryDetailMenuViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailInfoVC = DetailInfoViewController(menuItem: menu.menuItem[indexPath.row])
        
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
}

extension CategoryDetailMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu.menuItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMenuCollectionViewCell.identifier, for: indexPath) as! DetailMenuCollectionViewCell
        
        cell.configure(name: menu.menuItem[indexPath.row].imageName, title: menu.menuItem[indexPath.row].title)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailMenuReusableView.idintifier, for: indexPath) as! DetailMenuReusableView

        header.configure(title: menu.title)
        return header
    }
}

extension CategoryDetailMenuViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.bounds.size.width, height: 50)
    }
    
}
