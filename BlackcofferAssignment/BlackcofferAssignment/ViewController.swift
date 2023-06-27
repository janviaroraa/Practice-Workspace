//
//  ViewController.swift
//  BlackcofferAssignment
//
//  Created by Powerplay on 23/06/23.
//

import UIKit
import SnapKit

class JoinAsViewController: UIViewController {
    
    private let titles = [
        "Individual",
        "Professional",
        "Merchant"
    ]
    
    private let descriptions = [
        "Join and build real-time community",
        "World's largest real-time service's community",
        "World's largest real-time merchant's community"
    ]
    
    private let images = [
        "person.2.fill",
        "handbag",
        "archivebox"
    ]
    
    private lazy var stack: UIStackView = {
        let stk = UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis = .vertical
        return stk
    }()
    
    private lazy var joinAsLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "Join As"
        lbl.textColor = .blue
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 30)
        return lbl
    }()
    
    private lazy var table: UITableView = {
        let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        tbl.delegate = self
        tbl.dataSource = self
        tbl.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        tbl.backgroundColor = .clear
        return tbl
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addViews()
        addTargets()
        addLayouts()
    }
    
    private func addViews() {
        view.addSubview(stack)
        stack.addArrangedSubview(joinAsLabel)
        stack.addArrangedSubview(table)
        stack.setCustomSpacing(60, after: joinAsLabel)
    }
    
    private func addTargets() {
        
    }
    
    private func addLayouts() {
        stack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(150)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        joinAsLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        table.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
    }
}

extension JoinAsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier, for: indexPath) as? ProfileTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        let description = descriptions[indexPath.row]
        let imageName = images[indexPath.row]
        
        cell.tileLabel.text = title
        cell.descLabel.text = description
        cell.image.image = UIImage(systemName: imageName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

class Solution {
    func totalCost(_ costs: [Int], _ k: Int, _ candidates: Int) -> Int {
        if candidates == 0 || costs.count == 0 || k == 0 {
            return 0
        }
        
        var ans: Int = 0
        var newArray = costs.sorted()
        for i in 0...candidates-1 {
            ans += newArray[i]
        }
        return ans
    }
}
