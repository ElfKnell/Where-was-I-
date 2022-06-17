//
//  QuickShareViewController.swift
//  Where was I?
//
//  Created by Andrii Kyrychenko on 15/06/2022.
//

import UIKit

class QuickShareViewController: UIViewController, UITableViewDataSource {
    
    let reuseIdetifier = "tableViewCell"
    var dummyObjects = ["hi", "hello", "fine", "greate"]

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdetifier, for: indexPath)
        cell.textLabel?.text = dummyObjects[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dummyObjects.count
    }
}
