//
//  ProfileTableViewCell.swift
//  BlackcofferAssignment
//
//  Created by Powerplay on 23/06/23.
//

import UIKit
import SnapKit

class ProfileTableViewCell: UITableViewCell {
    
    static let identifier = "ProfileTableViewCellIdentifier"
    
    private lazy var avatarAndTextStack: UIStackView = {
        let stk = UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis = .horizontal
        stk.layer.borderColor = UIColor.black.cgColor
        stk.layer.borderWidth = 1
        stk.layer.cornerRadius = 15
        return stk
    }()
    
    lazy var image: UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.tintColor = .blue
        return img
    }()
    
    private lazy var titleAndDescStack: UIStackView = {
        let stk = UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis = .vertical
        return stk
    }()
    
    lazy var tileLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .blue
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 16)
        return lbl
    }()
    
    lazy var descLabel: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textColor = .blue
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 10)
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        self.backgroundColor = .clear
        addViews()
        addLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        contentView.addSubview(avatarAndTextStack)
        contentView.addSubview(titleAndDescStack)
        avatarAndTextStack.addArrangedSubview(image)
        avatarAndTextStack.addArrangedSubview(titleAndDescStack)
        titleAndDescStack.addArrangedSubview(tileLabel)
        titleAndDescStack.addArrangedSubview(descLabel)
        
        avatarAndTextStack.setCustomSpacing(10, after: image)
    }
    
    private func addLayouts() {
        avatarAndTextStack.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalToSuperview()
        }
        
        image.snp.makeConstraints { make in
            make.height.width.equalTo(40)
        }
        
        tileLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        descLabel.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
    }
}
