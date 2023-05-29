//
//  TabeViewController.swift
//  Practice Workspace
//
//  Created by Powerplay on 29/05/23.
//

import UIKit

class TableViewController: UIViewController {
    
    private var arrData = [Results]()
    private var arrResults = [Commodities]()
    
    private var viewModel: TableViewModel?
    
    private var tableView: UITableView = {
        let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.separatorStyle = .singleLine
        tbl.backgroundColor = .systemBackground
        tbl.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.id)
        return tbl
    }()
    
    override func viewDidLoad() {
         super.viewDidLoad()
        addViews()
        addLayouts()
        configureData()
    }
    
    private func addViews() {
        view.addSubview(tableView)
    }
    
    private func addLayouts() {
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    private func configureData() {
        let url = "http://abuseedotrading.com/apps/api/acp/?key=4ea1e08dd9ab329bbdaa9e5b42939c04&query=list_containers"
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            guard error == nil else { return }
            do {
                let APIResponse = try JSONDecoder().decode(RootResults.self, from: data)
                self.arrData = APIResponse.results
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                }
                
            } catch let error {
                print("Failed to decode JSON:", error)
            }
        }.resume()
    }
    
}

extension TableViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.id, for: indexPath) as! TableViewCell
        
        let dataa = arrData[indexPath.row]
        
//        cell.conLabel.text = dataa.container_number
//        cell.comLabel.text = dataa.commodities[0].commodity_name_en
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
