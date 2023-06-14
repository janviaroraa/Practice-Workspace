//
//  Practice2.swift
//  Practice Workspace
//
//  Created by Powerplay on 07/06/23.
//

import UIKit

class Practice2: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tbl = UITableView()
        tbl.translatesAutoresizingMaskIntoConstraints = false
        
        return tbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}



public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}


