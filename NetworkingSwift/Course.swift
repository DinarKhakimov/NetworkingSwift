//
//  model.swift
//  NetworkingSwift
//
//  Created by Johnny Boshechka on 1/23/22.
//

import Foundation

struct Course: Codable {
    let id: Int?
    let name: String?
    let link: String?
    let imageUrl: String?
    let number_of_lessons: Int?
    let number_of_tests: Int?
}

struct CourseWeb: Codable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}


