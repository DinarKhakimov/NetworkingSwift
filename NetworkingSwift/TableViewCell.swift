//
//  TableViewCell.swift
//  NetworkingSwift
//
//  Created by Johnny Boshechka on 1/23/22.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var oneLabel: UILabel!
    @IBOutlet weak var twoLabel: UILabel!
    @IBOutlet weak var treeLabel: UILabel!
    
    func configure(for cource: Course) {
        oneLabel.text = cource.name
        twoLabel.text = "Number of lesson: \(cource.number_of_lessons ?? 0)"
        treeLabel.text = "Number of tests : \(cource.number_of_tests ?? 0)"
        DispatchQueue.global().async {
        
            guard let url = URL(string: cource.imageUrl ?? "") else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.courseImageView.image = UIImage(data: imageData)
            }
        }
    }

}
