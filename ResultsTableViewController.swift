//
//  ResultsTableViewController.swift
//  triviaApp
//
//  Created by Michael Berend on 15/03/2018.
//  Copyright © 2018 Michael Berend. All rights reserved.
//

import UIKit


class ResultsTableViewController: UITableViewController {
    

    // number of correct answers
    var answers: Int!


    
    /// add score to highscores and delete lowest if there are more than 10
    override func viewDidLoad() {
        super.viewDidLoad()
        NameScore.shared.score = answers
        NameScore.sharedArray.append(NameScore.shared)
        NameScore.sharedArray = NameScore.sharedArray.sorted(by: >)
        if NameScore.sharedArray.count > 10 {
            NameScore.sharedArray.removeLast()
        }
    }


    // define number of rows as number of scores
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NameScore.sharedArray.count
    }
    
    //// deque cells and define each cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath)
        configure(cell: cell, forItemAt: indexPath)
        return cell
    }
    
    /// set label text for each score
    func configure(cell: UITableViewCell, forItemAt indexpath: IndexPath) {
        let nameAndScore = NameScore.sharedArray[indexpath.row]
        cell.textLabel?.text = nameAndScore.name
        cell.detailTextLabel?.text = "\(nameAndScore.score)"
    }

}
