//
//  PostRequestViewController.swift
//  Practice Workspace
//
//  Created by Powerplay on 23/05/23.
//

import UIKit
import SnapKit

class PostRequestViewController: UIViewController {
    
    private lazy var id: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Enter id"
        txt.layer.cornerRadius = 4
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return txt
    }()
    
    private lazy var mainTitle: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Enter title"
        txt.layer.cornerRadius = 4
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return txt
    }()
    
    private lazy var body: UITextField = {
        let txt = UITextField()
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.placeholder = "Enter body"
        txt.layer.cornerRadius = 4
        txt.layer.borderWidth = 1
        txt.layer.borderColor = UIColor.black.cgColor
        txt.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return txt
    }()
    
    private lazy var button: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Post Data", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 4
        btn.layer.borderWidth = 1
        return btn
    }()
    
    private lazy var stack: UIStackView = {
        let stk = UIStackView()
        stk.translatesAutoresizingMaskIntoConstraints = false
        stk.axis = .vertical
        stk.spacing = 20
        stk.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        stk.isLayoutMarginsRelativeArrangement = true
        return stk
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        addViews()
        addTargets()
        configureLayouts()
    }
    
    private func addViews() {
        view.addSubview(stack)
        stack.addArrangedSubview(id)
        stack.addArrangedSubview(mainTitle)
        stack.addArrangedSubview(body)
        stack.addArrangedSubview(button)
    }
    
    private func addTargets() {
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
    }
    
    private func configureLayouts() {
        stack.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview().inset(20)
        }
        
        id.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        body.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
    }
    
    @objc private func postButtonTapped() {
        setupPostMethod()
    }
    
    private func setupPostMethod() {
        guard let id = self.id.text else { return }
        guard let mainTitle = self.mainTitle.text else { return }
        guard let body = self.body.text else { return }
        
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts/") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters: [String : Any] = [
                "userId": id,
                "title": mainTitle,
                "body": body
            ]
            
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    if error == nil {
                        print(error?.localizedDescription ?? "Unknown Error")
                    }
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    guard (200...299) ~= response.statusCode else {
                        print("Status code :- \(response.statusCode)")
                        print(response)
                        return
                    }
                }
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                }catch let error{
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
}

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="
        
        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
