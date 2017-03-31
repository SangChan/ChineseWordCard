//
//  LobbyViewController.swift
//  ChineseWordCard
//
//  Created by SangChan Lee on 3/16/17.
//  Copyright © 2017 VerandaStudio. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    @IBOutlet weak var varticalStackView : UIStackView!
    @IBOutlet weak var horizontalStackView : UIStackView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class GoToWord : UIView {
    var chineseWord : ChineseWord?
}

class StudyProgress : UIView {
    var circleView : CircleView!
}

class PreviewForWord : UIView {
    var chineseWord : ChineseWord?
}

class SearchWord : UIView {
    var searchKeyword : String?
    var chineseWord : ChineseWord?
}

class LikeItWord : UIView {
    var chineseWord : ChineseWord?
}

class TodaysWord : UIView {
    var chineseWord : ChineseWord?
}

class CircleView : UIView {
    var maxValue : UInt!
    var currentValue : UInt!
    
    func animate() {
        
    }
}

class ProgressView : UIView {
    var maxValue : UInt!
    var currentValue : UInt!
    
    func animate() {

    }
}
