//
//  ViewController.swift
//  NetworkingSwift
//
//  Created by Johnny Boshechka on 1/23/22.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var activityIdicator: UIActivityIndicatorView!
    @IBOutlet weak var courseImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIdicator.startAnimating()
        activityIdicator.hidesWhenStopped = true
        fetchData()
    }

    private func fetchData() {
        guard let url = URL(string: Link.imageURL.rawValue) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            print(data)
            
            guard let image = UIImage(data: data) else {
                return
            }
            DispatchQueue.main.async {
                self.courseImageView.image = image
                self.activityIdicator.stopAnimating()
            }
            
            
            
 
        }.resume()
    }

}

