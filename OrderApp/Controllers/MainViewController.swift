//
//  ViewController.swift
//  OrderApp
//
//  Created by ForMore on 13/10/2023.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    private var menus = [Menu]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        menus.append(Menu(imageName: "cube", title: "First", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Second", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Third", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Fours", description: "", menuItem: []))
        
        menus.append(Menu(imageName: "cube", title: "First", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Second", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Third", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Fours", description: "", menuItem: []))
        
        menus.append(Menu(imageName: "cube", title: "First", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Second", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Third", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Fours", description: "", menuItem: []))
        
        menus.append(Menu(imageName: "cube", title: "First", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Second", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Third", description: "", menuItem: []))
        menus.append(Menu(imageName: "cube", title: "Fours", description: "", menuItem: []))
        
        table.register(TableViewCell.nib(), forCellReuseIdentifier: TableViewCell.identifier)
        
        table.delegate = self
        table.dataSource = self
    }


}

extension MainViewController: UITableViewDelegate {
    
}


extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: TableViewCell.identifier, for: indexPath) as! TableViewCell
        
        cell.configure(with: menus)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
    
    
}
