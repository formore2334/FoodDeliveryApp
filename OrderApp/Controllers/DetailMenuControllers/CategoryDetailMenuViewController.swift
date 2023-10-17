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
        
        layoutCollection()
        collectionView?.delegate = self
        collectionView?.dataSource = self
        configureCollectionView()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height).integral
    }
    
    
    func layoutCollection() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    func configureCollectionView() {
        
        collectionView?.register(DetailMenuCollectionViewCell.self, forCellWithReuseIdentifier: DetailMenuCollectionViewCell.identifier)
        collectionView?.backgroundColor = .white
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
    }

}


extension CategoryDetailMenuViewController: UICollectionViewDelegate {
    
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
