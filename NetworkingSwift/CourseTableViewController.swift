//
//  CourseTableViewController.swift
//  NetworkingSwift
//
//  Created by Johnny Boshechka on 1/23/22.
//

import UIKit

class CourseTableViewController: UITableViewController {
    
    var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let course = courses[indexPath.row]
        cell.configure(for: course)

        return cell
    }
 
}

extension CourseTableViewController {
    func fetchData() {
        guard let url = URL(string: Link.exampleTwo.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "No error description")
                return
            }
            do {
                self.courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
            print(error)
            }
        }.resume()
    }
}
