//
//  PostRequest.swift
//  Practice Workspace
//
//  Created by Powerplay on 02/06/23.
//

import UIKit

class PostRequestPractice: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func GETRequest() {
        if let url = URL(string: "") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error != nil else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    guard (200...299) ~= response.statusCode else {
                        print(response.statusCode)
                        print(response)
                        return
                    }
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch let error {
                    print(error.localizedDescription)
                }
            }.resume()
        }
    }
    
    private func POSTRequest() {
//        guard let id = self.idLabel.text else { return }
        
        let id = "The text that will be entered by user in lable feild"
        
        if let url = URL(string: "") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            var parameters: [String: Any] = [
                "userId": id
            ]
            
            request.httpBody = parameters.percentEscapedPractice().data(using: .utf8)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error != nil else {
                    print(error?.localizedDescription ?? "Unknown error")
                    return
                }
                
                if let response = response as? HTTPURLResponse {
                    guard (200...299) ~= response.statusCode else {
                        print(response.statusCode)
                        print(response)
                        return
                    }
                }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch let error {
                    print(error.localizedDescription)
                }
            }.resume()
        }
        
    }
    
}

extension Dictionary {
    func percentEscapedPractice() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }.joined(separator: "&")
    }
}
