//
//  TableViewCell.swift
//  Practice Workspace
//
//  Created by Powerplay on 29/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let id = "TableViewCellId"
    
    private var title: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    private var subTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .black
        lbl.font = .systemFont(ofSize: 14)
        return lbl
    }()
    
    private lazy var stack: UIStackView = {
        let stk = UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis = .vertical
        stk.spacing = 20
        stk.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stk.isLayoutMarginsRelativeArrangement = true
        return stk
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        addLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        stack.addArrangedSubview(title)
        stack.addArrangedSubview(subTitle)
        contentView.addSubview(stack)
    }
    
    private func addLayouts() {
        stack.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        title.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
        
        subTitle.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
}
