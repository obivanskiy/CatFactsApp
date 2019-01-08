//
//  CatFactsDataControllerViewController.swift
//  catFactsApp
//
//  Created by Ivan Obodovskyi on 1/5/19.
//  Copyright © 2019 Ivan Obodovskyi. All rights reserved.
//

import UIKit
import Firebase


class CatsDataTableViewCell: UITableViewCell {
    
    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    @IBOutlet var catDescriptionLabel: UILabel!
    @IBOutlet var catImageLabel: UIImageView!
    
    
    
}

class CatsDataTableViewController: UITableViewController {
    
    @IBAction func logoutActionButton(_ sender: Any) {
            do {
                try Auth.auth().signOut()
            }
            catch let signOutError as NSError {
                print ("Error!")
        }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let initial = storyboard.instantiateInitialViewController()
                UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    

    

    private let urlToParse =  URL(string: "https://cat-fact.herokuapp.com/facts")
    //JSON Data object
    
    private(set) var tableViewObject: CatsResponse? {
        didSet {
            guard let _ = tableViewObject else { return }
            //load Data of the TableView simultaniously
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getJsonData()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
     
    }
    //JSON request session
    private func getJsonData() {
        guard let url = urlToParse else { return }
        URLSession.shared.dataTask(with: url) {data, urlResponse, error in
            guard let data = data, error == nil, urlResponse != nil else {
                print("something gone wrong")
                return
            }
            print("data is downloaded")
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(CatsResponse.self, from: data)
                self.tableViewObject =  response
                print(self.tableViewObject!.catsArray)
            } catch {
                print("one more error")
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard tableViewObject != nil else {return 0}
             return (tableViewObject?.catsArray.count)!
        
        }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CatCell") as? CatsDataTableViewCell else {return UITableViewCell() }
        
        cell.selectionStyle = .default
        let catImage: UIImage = UIImage(named: "catvaider.jpeg")!
        cell.catImageLabel.image = catImage
        cell.firstNameLabel.text = tableViewObject?.catsArray[indexPath.row].user.name.first
        cell.lastNameLabel.text = tableViewObject?.catsArray[indexPath.row].user.name.last
        cell.catDescriptionLabel.text = tableViewObject?.catsArray[indexPath.row].text
        
        

        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
   
    





