//
//  ViewController.swift
//  ChineseWordCard
//
//  Created by SangChan on 2015. 9. 15..
//  Copyright (c) 2015년 VerandaStudio. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift
import FontAwesome_swift

class ViewController: UIViewController {

    @IBOutlet var pinyinLabel: UILabel!
    @IBOutlet var hanyuLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var sliderBar: UISlider!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var settingButton: UIButton!
    
    var wordList : Results<ChineseWord>!
    
    var nowWord : ChineseWord!
    
    var touchCount : Int = 0
    var wordIndex : Int = 0
    var maxWordCount : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func goToNext() {
        resetView()
        wordIndex += 1
        if wordIndex > wordList.count-1 {
            wordIndex = wordList.count-1
        }
        self.updateUIonView()
    }
    
    func goToPrev() {
        resetView()
        wordIndex -= 1
        if wordIndex <= 0 {
            wordIndex = 0
        }
        self.updateUIonView()
    }
    @IBAction func nextClicked(sender: AnyObject) {
        self.goToNext()
    }
    @IBAction func prevClicked(sender: AnyObject) {
        self.goToPrev()
    }
    @IBAction func valueChanged(sender: AnyObject) {
        resetView()
        self.wordIndex = Int.init(self.sliderBar.value * Float.init(wordList.count))
        if wordIndex <= 0 {
            wordIndex = 0
        } else if wordIndex > wordList.count-1 {
            wordIndex = wordList.count-1
        }
        self.updateUIonView()
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        setButton(self.prevButton, withSize: 30, withType: .AngleLeft)
        setButton(self.nextButton, withSize: 30, withType: .AngleRight)
        setButton(self.starButton, withSize: 30, withType: .StarO)
        setButton(self.settingButton, withSize: 30, withType: .Cog)
        resetView()
        
        let realm = try! Realm()
        
        if AppInfo.sharedInstance.sortInfo == SortIndex.SortIndexStar {
            self.wordList = realm.objects(ChineseWord).filter("likeIt == true")
        } else if AppInfo.sharedInstance.sortInfo == SortIndex.SortIndexAlphabet {
            self.wordList = realm.objects(ChineseWord).sorted("pinyin")
        } else {
            self.wordList = realm.objects(ChineseWord)
        }
        
        
        self.maxWordCount = self.wordList.count
        self.wordIndex = AppInfo.sharedInstance.getWordIndex()
        self.updateUIonView();
    }
    
    func setButton(button:UIButton, withSize size : CGFloat, withType type:FontAwesome) {
        button.titleLabel?.font = UIFont.fontAwesomeOfSize(size)
        button.setTitle(String.fontAwesomeIconWithName(type), forState: .Normal)
    }
    
    func updateUIonView() {
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        self.prevButton.enabled = (wordIndex > 0) ? true : false
        self.nextButton.enabled = (wordIndex < wordList.count-1) ? true : false
        self.nowWord = wordList[wordIndex]
        self.hanyuLabel.text = nowWord.hanyu
        self.pinyinLabel.text = nowWord.pinyin
        self.descriptionLabel.text = getDescWithLanguageIndex(AppInfo.sharedInstance.languageInfo)
        self.sliderBar.value =  Float.init(wordIndex)/Float.init(wordList.count)
        setButton(self.starButton, withSize: 30, withType: (nowWord.likeIt == true) ? .Star:.StarO)
    }
    
    func getDescWithLanguageIndex(index : LanguageIndex) -> String {
        switch index {
        case .LanguageIndexEN : return nowWord.desc_en
        case .LangyageIndexES : return nowWord.desc_es
        default : return nowWord.desc_kr
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func resetView() {
        touchCount = 0
        setLabelHiddenByCount(touchCount)
    }
    
    func setLabelHiddenByCount(count : Int) {
        pinyinLabel.hidden = (count == 0) ? true : false
        descriptionLabel.hidden = (count == 0 || count%2 == 1) ? true : false
        if count > 0 {
            speakWord()
        }
    }
    
    func speakWord() {
        let synthesize : AVSpeechSynthesizer = AVSpeechSynthesizer.init()
        let utterance : AVSpeechUtterance = AVSpeechUtterance.init(string: hanyuLabel.text!)
        utterance.rate = getSpeechSpeed(AppInfo.sharedInstance.speechSpeed)
        utterance.voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        synthesize.speakUtterance(utterance)
    }
    
    func getSpeechSpeed(index : SpeechSpeedIndex) -> Float {
        if index ==  .SpeechSpeedNormal {
            return AVSpeechUtteranceDefaultSpeechRate
        }
        let standardSpeed:Float = (index == .SpeechSpeedSlow) ? AVSpeechUtteranceMinimumSpeechRate : AVSpeechUtteranceMaximumSpeechRate
        
        return (standardSpeed + AVSpeechUtteranceDefaultSpeechRate + AVSpeechUtteranceDefaultSpeechRate + AVSpeechUtteranceDefaultSpeechRate) / 4.0
    }
        
    @IBAction func handleSwipeLeft(sender: UISwipeGestureRecognizer) {
        if wordIndex < wordList.count - 1 {
            self.goToNext()
        }
    }
    
    
    @IBAction func handleSwipeRight(sender: UISwipeGestureRecognizer) {
        if wordIndex > 0 {
            self.goToPrev()
        }
    }
    
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            touchCount += 1
            setLabelHiddenByCount(touchCount)
        }
    }
    @IBAction func starButtonPressed(sender: AnyObject) {
        let realm = try! Realm()
        try! realm.write() {
            self.nowWord.setValue(!self.nowWord.likeIt, forKey: "likeIt")
        }
        setButton(self.starButton, withSize: 30, withType: (nowWord.likeIt == true) ? .Star:.StarO)
    }
}

