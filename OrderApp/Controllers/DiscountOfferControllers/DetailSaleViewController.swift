//
//  DetailSaleViewController.swift
//  OrderApp
//
//  Created by ForMore on 18/10/2023.
//

import UIKit

class DetailSaleViewController: UIViewController {
    
    var sale: Sale
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.frame = CGRect(x: 0, y: 350, width: 200, height: 60)
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.frame = CGRect(x: 0, y: 450, width: 200, height: 40)
        return label
    }()
    
    init(sale: Sale) {
        self.sale = sale
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Sales"

       configureDetailSaleView()
        
    }
    
    
    func configureDetailSaleView() {
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        imageView.image = UIImage(named: sale.imageName)
        titleLabel.text = sale.title
        descriptionLabel.text = sale.description
    }


}
