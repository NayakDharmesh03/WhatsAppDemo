//
//  SplashViewController.swift
//  NewAppProject
//
//  Created by MacbookAir_32 on 24/05/23.
//

import UIKit

class SplashViewController: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
extension SplashViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = myTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SelectedContactsTableViewCell
     
        return cell
    }
    
    
}
