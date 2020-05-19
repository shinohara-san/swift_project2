//
//  ViewController.swift
//  Project2
//
//  Created by Yuki Shinohara on 2020/05/18.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
    var leftquestions = 10
    override func viewDidLoad() {
        super.viewDidLoad()
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        //CAlayerに属するborderColorは
        //UIColorを認知できないのでcgColorを入れる(違う技術階層にある)
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
//        UIColor(red: 1.0, green: 0.6, blue: 0.2, alpha: 1.0).cgColorと色指定することもできる
        askQuestion(action: nil)
        
    }
    
    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        correctAnswer = Int.random(in: 0...2)
        title = "\(countries[correctAnswer].uppercased())  Your Score: \(score)"
    }
    
    func showResult(){
        let ac = UIAlertController(title: "終了", message: "あなたの成績は\(score)点でした。", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "もう一度する", style: .default, handler: askQuestion))
        present(ac, animated: true)
        score = 0
        leftquestions = 10
    }
    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        leftquestions -= 1
        
        if sender.tag == correctAnswer {
            score += 1
            title = "Correct!"
        } else {
            score -= 1
            title = "Wrong..."
        }
//        アラート 不正解, 10問終了, その他
        if title == "Wrong..."{
            let ac = UIAlertController(title: title, message: "Wrong! That’s the flag of \(countries[sender.tag].uppercased())", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        } else if leftquestions == 0{
            showResult()
        } else {
            let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            present(ac, animated: true)
        }
        
    }
    
}

