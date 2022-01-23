//
//  CoursesCollectionViewController.swift
//  NetworkingSwift
//
//  Created by Johnny Boshechka on 1/23/22.
//

import UIKit

enum Link: String {
    case imageURL = "https://applelives.com/wp-content/uploads/2016/03/iPhone-SE-11.jpeg"
    case exampleOne = "https://swiftbook.ru//wp-content/uploads/api/api_course"
    case exampleTwo = "https://swiftbook.ru//wp-content/uploads/api/api_courses"
    case exampleThree = "https://swiftbook.ru//wp-content/uploads/api/api_website_description"
    case exampleFour = "https://swiftbook.ru//wp-content/uploads/api/api_missing_or_wrong_fields"
}

enum UserAction: String, CaseIterable {
    case downloadImage = "Download Image"
    case exampleOne = "Example One"
    case exampleTwo = "Example Two"
    case exampleThree = "Example Three"
    case exampleFour = "Example Four"
    case ourCourses = "Our Courses"
}


class CoursesCollectionViewController: UICollectionViewController {
    
    let userActions = UserAction.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
     // MARK: - Navigation
     
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "showDetail" {
             guard let showCoursesTableVc = segue.destination as? CourseTableViewController else { return }
             showCoursesTableVc.fetchData()
         }
     }
     
    
    // MARK: UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        userActions.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.courseLabel.text = userActions[indexPath.item].rawValue
        return cell
    }
    
    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let userAction = userActions[indexPath.item]
        
        switch userAction {
            
        case .downloadImage:
            performSegue(withIdentifier: "showImage", sender: nil)
        case .exampleOne:
            exampleOneButtonPressed()
        case .exampleTwo:
            exampleTwoButtonPressed()
        case .exampleThree:
            exampleThreeButtonPressed()
        case .exampleFour:
            exampleFourButtonPressed()
        case .ourCourses:
            performSegue(withIdentifier: "showDetail", sender: nil)
        }
    }
    
    //MARK: Private methods
    
    private func succseeAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Succses",
                                          message: "You can see the result in the Debug area",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Ok",
                                         style: .default,
                                         handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    private func failedAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Failed",
                                          message: "You can see the error in the Debug area",
                                          preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK",
                                         style: .default,
                                         handler: nil)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
}

extension CourseTableViewController: UICollectionViewDelegateFlowLayout {
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width - 48, height: 100)
    }
}

extension CoursesCollectionViewController {
    
    private func exampleOneButtonPressed() {
        guard let url = URL(string: Link.exampleOne.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "No error description")
                return
            }
            do {
                let course = try JSONDecoder().decode(Course.self, from: data)
                self.succseeAlert()
                print(course)
            } catch {
                self.failedAlert()
                print(error)
            }
        }.resume()
    }
    
    private func exampleTwoButtonPressed() {
        guard let url = URL(string: Link.exampleTwo.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "No error description")
                return
            }
            do {
                let course = try JSONDecoder().decode([Course].self, from: data)
                self.succseeAlert()
                print(course)
            } catch {
                self.failedAlert()
                print(error)
            }
        }.resume()
    }
    
    private func exampleThreeButtonPressed() {
        guard let url = URL(string: Link.exampleThree.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "No error description")
                return
            }
            do {
                let course = try JSONDecoder().decode(CourseWeb.self, from: data)
                self.succseeAlert()
                print(course)
            } catch {
                self.failedAlert()
                print(error)
            }
        }.resume()
    }
    
    private func exampleFourButtonPressed() {
        guard let url = URL(string: Link.exampleFour.rawValue) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error ?? "No error description")
                return
            }
            do {
                let course = try JSONDecoder().decode(CourseWeb.self, from: data)
                self.succseeAlert()
                print(course)
            } catch {
                self.failedAlert()
                print(error)
            }
        }.resume()
    }
}

