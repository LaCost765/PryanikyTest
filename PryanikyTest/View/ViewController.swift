//
//  ViewController.swift
//  PryanikyTest
//
//  Created by Egor on 11.03.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var loadDataButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func loadDataButtonTapped(_ sender: Any) {
        
        // create session
        let session = URLSession.shared
        guard let url = URL(string: "https://pryaniky.com/static/json/sample.json") else { return }

        session.dataTask(with: url) { (data, response, error) in
            do {
                guard let data = data else { return }
                let responseData = try JSONDecoder().decode(ServerResponseData.self, from: data)
                print(responseData.data)
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
        
//        let view = ["hz", "selector", "picture", "hz"]
//        let data: [ServerDataItem] = [
//            ServerDataItem(name: "hz", data: .hz(text: "Some text for hz1")),
//            ServerDataItem(name: "picture", data: .picture(url: "https://pryaniky.com/static/img/logo-a-512.png", text: "Some text for image")),
//            ServerDataItem(name: "selector", data: .selector(selectedId: 1, variants: [
//                SelectorItemData(id: 1, text: "item 1"),
//                SelectorItemData(id: 2, text: "item 2"),
//                SelectorItemData(id: 3, text: "item 3")
//            ]))
//        ]
//
//        let serverData = ServerResponseData(data: data, view: view)
//
//        let encoder = JSONEncoder()
//        encoder.outputFormatting = .prettyPrinted
//
//        let json = (try? encoder.encode(serverData)) ?? Data()
//        let jsonString = String(data: json, encoding: .utf8)!
//
//        do {
//            let responseData = try JSONDecoder().decode(ServerResponseData.self, from: json)
//            print(responseData.data)
//        } catch {
//            print(error.localizedDescription)
//        }
    }
    
}

