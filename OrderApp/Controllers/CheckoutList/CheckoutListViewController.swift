//
//  CheckoutListViewController.swift
//  OrderApp
//
//  Created by ForMore on 15/11/2023.
//

import UIKit


class CheckoutListViewController: UIViewController {
    
    var basket: Basket
    
    var tableView: UITableView!
    var checkoutListInfo: [CheckoutListInfo] = [.name, .phone, .address, .comment, .coupon]
    var checkoutList = CheckoutList(name: "", phone: "", address: "", comment: "", coupon: "")
    
    let totalTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Total:"
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
        return label
    }()
    
    let totalSumLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return label
    }()
    
    let payButton = PayButton()
    
    
    init(basket: Basket) {
        self.basket = basket
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureVC()
        configureTotalInfo()
        setPayButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .black
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .normal)
    }
    
    private func configureVC() {
        // Create and configure the table view
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        tableView.isScrollEnabled = false
        tableView.register(CheckoutListCell.self, forCellReuseIdentifier: CheckoutListCell.identifier)
        view.addSubview(tableView)
        
        setConstraints()
    }
    
    private func configureTotalInfo() {
        view.addSubview(totalTitleLabel)
        view.addSubview(totalSumLabel)
        
        totalSumLabel.text = "\(basket.totalSum)$"
        
        setTotalInfoConstraints()
    }
    
    private func setPayButton() {
        view.addSubview(payButton)
        
        payButton.basket = basket
        
        setPayButtonConstraints()
    }
    
    // MARK: - Constraints
    
    
    //Table view constraints
    func setConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalToConstant: 300),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    //Total info constraints
    func setTotalInfoConstraints() {
        totalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        totalSumLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            totalTitleLabel.heightAnchor.constraint(equalToConstant: 50),
            totalTitleLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            totalTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            
            totalSumLabel.heightAnchor.constraint(equalToConstant: 50),
            totalSumLabel.topAnchor.constraint(equalTo: tableView.bottomAnchor),
            totalSumLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    // Pay button constraints
    private func setPayButtonConstraints() {
        payButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            payButton.heightAnchor.constraint(equalToConstant: 40),
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 60),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        ])
    }
   
}

extension CheckoutListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension CheckoutListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return checkoutListInfo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CheckoutListCell.identifier, for: indexPath) as! CheckoutListCell
        
        let info = checkoutListInfo[indexPath.row]
        cell.configure(with: info)
        cell.didEnterText = { [weak self] text in
            switch info {
            case .name:
                self?.checkoutList.name = text
            case .phone:
                self?.checkoutList.phone = text
            case .address:
                self?.checkoutList.address = text
            case .comment:
                self?.checkoutList.comment = text
            case .coupon:
                self?.checkoutList.coupon = text
            }
            print("DEBUG checkoutList: ", self?.checkoutList ?? "checkoutList - nil")
        }
        
        return cell
    }
    
}





