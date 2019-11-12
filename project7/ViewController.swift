//
//  ViewController.swift
//  project7
//
//  Created by Ajay Kumar on 06/11/19.
//  Copyright © 2019 GameNexas. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    var myPetitions = [Petition]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // let urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
        let urlString : String
        if navigationController?.tabBarItem.tag == 0 {
        urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        }else{
                 urlString = "https://api.whitehouse.gov/v1/petitions.json?limit=100"
            }
        if let url = URL(string: urlString){
            if let data = try? Data (contentsOf: url){
                parse(jsonData: data)
            }else{
                errorMsg()
            }
        }else{
            errorMsg()
        }
    }
    func errorMsg()  {
        let vc = UIAlertController(title:"Alert", message: "there may be some problem", preferredStyle: .alert)
        vc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(vc, animated: true, completion: nil)
    }
    func parse(jsonData : Data)  {
        let decoder = JSONDecoder()
        if let jsonPetitions = try? decoder.decode(petitions.self, from: jsonData){
            myPetitions = jsonPetitions.results
            tableView.reloadData()
        }else{
            errorMsg()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myPetitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let mypetition = myPetitions[indexPath.row]
        cell.textLabel?.text = mypetition.title
        cell.detailTextLabel?.text = mypetition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let vc = detailViewController()
        vc.detailItem = myPetitions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }

}

