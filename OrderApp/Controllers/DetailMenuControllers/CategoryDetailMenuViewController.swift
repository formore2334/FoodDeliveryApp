//
//  SecondViewController.swift
//  OrderApp
//
//  Created by ForMore on 16/10/2023.
//

import UIKit

// MARK: - Detail menu for each category from menu

class CategoryDetailMenuViewController: UIViewController {

    var menuItem: [MenuItem]
    
    private var collectionView: UICollectionView?
    
    init(menuItem: [MenuItem]) {
        self.menuItem = menuItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        title = "Second VC"
        
        configureCollectionView()
    }

   //MARK: - Configure CollectionView
    
    func configureCollectionView() {
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layoutCollection())
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        
        setCollectionViewConstraints()
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(DetailMenuCollectionViewCell.self, forCellWithReuseIdentifier: DetailMenuCollectionViewCell.identifier)
    }
    
    
    func layoutCollection() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 20
        
        return layout
        
    }
    
    //MARK: - Constraints
    func setCollectionViewConstraints() {
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
        let detailInfoVC = DetailInfoViewController(menuItem: menuItem[indexPath.row])
        
        navigationController?.pushViewController(detailInfoVC, animated: true)
    }
    
}

extension CategoryDetailMenuViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuItem.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailMenuCollectionViewCell.identifier, for: indexPath) as! DetailMenuCollectionViewCell
        
        cell.configure(name: menuItem[indexPath.row].imageName, title: menuItem[indexPath.row].title)
        
        return cell
    }
    
}


extension CategoryDetailMenuViewController: UICollectionViewDelegateFlowLayout {
    
}
