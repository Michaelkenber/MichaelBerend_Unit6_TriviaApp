//
//  QuestionController.swift
//  triviaApp
//
//  Created by Michael Berend on 12/03/2018.
//  Copyright © 2018 Michael Berend. All rights reserved.
//

import UIKit

class QuestionController {
    
    
    // define variable to share question controller across views
    static let shared = QuestionController()
    
    // create variable that holds an URL to retrieve the data frmom
    let categoryURL = URL(string: "http://jservice.io/api/clues?category=21")!
    
    // fetch question data from URL
    func fetchQuestionData(completion: @escaping ([Question]?) -> Void) {
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, response, error) in
            let jsonDecoder = JSONDecoder()
            if let error = error {
                print(error)
            }
            
            if let data = data,
                let questions = try? jsonDecoder.decode([Question].self, from: data) {
                completion(questions)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
