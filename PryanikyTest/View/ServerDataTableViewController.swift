//
//  ServerDataTableViewController.swift
//  PryanikyTest
//
//  Created by Egor on 12.03.2021.
//

import UIKit

class ServerDataTableViewController: UITableViewController {

    @IBOutlet weak var downloadDataButton: UIBarButtonItem!
    
    var views: [String] = []
    var dataDict: [ServerDataItemType:ServerDataItem] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Наверное для этого класса надо было тоже сделать вью модель, но я не очень давно практикую mvvm, пока еще не все понял
    @IBAction func downloadDataButtonTapped(_ sender: Any) {
        // create session
        let session = URLSession.shared
        guard let url = URL(string: "https://pryaniky.com/static/json/sample.json") else { return }

        session.dataTask(with: url) { [weak self] (data, response, error) in
            do {
                guard let data = data else { return }
                let responseData = try JSONDecoder().decode(ServerResponseData.self, from: data)
                
                self?.views = responseData.view
                for dataItem in responseData.data {
                    self?.dataDict[dataItem.name] = dataItem
                }
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return views.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch views[indexPath.row] {
        case "hz":
            let cell = tableView.dequeueReusableCell(withIdentifier: "Hz", for: indexPath) as! HzTableViewCell
            guard let model = dataDict[.hz] else { return cell }
            cell.viewModel = HzCellViewModel(model: model)
            return cell
            
        case "picture":
            let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath) as! PictureTableViewCell
            guard let model = dataDict[.picture] else { return cell }
            cell.viewModel = PictureCellViewModel(model: model)
            return cell
            
        case "selector":
            let cell = tableView.dequeueReusableCell(withIdentifier: "Selector", for: indexPath) as! SelectorTableViewCell
            guard let model = dataDict[.selector] else { return cell }
            cell.viewModel = SelectorCellViewModel(model: model)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let type: ServerDataItemType = ServerDataItemType(rawValue: views[indexPath.row]) else { return }
        
        let cell = tableView.cellForRow(at: indexPath)
        var message = ""
        
        switch type {
        
        case .hz:
            message = (cell as! HzTableViewCell).viewModel?.uniqueValue ?? ""
        case .picture:
            message = (cell as! PictureTableViewCell).viewModel?.uniqueValue ?? ""
        case .selector:
            message = (cell as! SelectorTableViewCell).viewModel?.uniqueValue ?? ""
        }
        
        self.showNotificationAlert(title: "Info", message: message, buttonTitle: "Ok")
    }
   

}
