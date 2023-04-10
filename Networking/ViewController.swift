//
//  ViewController.swift
//  Networking
//
//  Created by Степан Фоминцев on 10.04.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func getRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        let session = URLSession.shared
        session.dataTask(with: url) { data, response, error in
            guard let data, let response, error == nil else { return }
            print(response)
        }.resume()
    }
    
    @IBAction func postRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        let userData = ["Course": "Networking", "Lesson": "GETPOST"]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: userData) else {
            return
        }
        request.httpBody = httpBody
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        session.dataTask(with: request) { data, response, error in
            guard let data, let response, error == nil else {
                return
            }
            print(response)
            
            do {
                let json = try JSONSerialization.jsonObject(with: data)
                print(json)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}

