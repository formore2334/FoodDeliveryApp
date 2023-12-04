//
//  DividerView.swift
//  OrderApp
//
//  Created by ForMore on 01/12/2023.
//

import UIKit


class DividerView: UIView {
    
    private lazy var dividerView: UIView = {
        let dividerView = UIView()
        dividerView.backgroundColor = UIColor.gray
        return dividerView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(dividerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
        dividerView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: 0.25)
    }
    
}
