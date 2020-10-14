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
    
    func setCellData(_ catsData: CatData) {
        let catImage: UIImage = UIImage(named: "catvaider.jpeg")!
        catImageLabel.image = catImage
        firstNameLabel.text = catsData.user.name.first
        lastNameLabel.text = catsData.user.name.last
        catDescriptionLabel.text = catsData.text
    }
}

class CatsDataTableViewController: UITableViewController {
    @IBAction func logoutActionButton(_ sender: Any) {
            do {
                try Auth.auth().signOut()
            }
            catch let signOutError as NSError {
                print ("Error!")
        }
            self.performSegue(withIdentifier: "logoutID", sender: self)
    }

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
    
    private func getJsonData() {
        NetworkingService.shared.fetchData(with: .facts) { [weak self] (catsData, responce, error) in
            self?.tableViewObject = catsData
        }
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
        cell.setCellData((tableViewObject?.catsArray[indexPath.row])!)
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
   
    





