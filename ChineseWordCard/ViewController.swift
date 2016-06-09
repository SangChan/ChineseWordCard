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
    
    // override section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        preferredStatusBarStyle()
        super.viewWillAppear(animated)
        setButtonDefault()
        resetView()
        
        self.wordList = self.getDataFromSort(AppInfo.sharedInstance.sortInfo.sortInfo)
        self.maxWordCount = self.wordList.count
        self.wordIndex = AppInfo.sharedInstance.getWordIndex()
        self.updateUIonView();
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            wordIndex = Int(arc4random_uniform(UInt32(wordList.count)))
            updateUIonView()
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // action section
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

    // private method section
    
    func wordIndexIncrease(increase : Bool) -> Int {
        var index : Int = wordIndex
        if increase {
            index += 1
        } else {
            index -= 1
        }
        if index >= 0 && index < wordList.count {
            return index
        }
        return wordIndex
    }
    
    func goToNext() {
        resetView()
        wordIndex = self.wordIndexIncrease(true);
        self.updateUIonView()
    }
    
    func goToPrev() {
        resetView()
        wordIndex = self.wordIndexIncrease(false);
        self.updateUIonView()
    }

    
    func getDataFromSort(index : SortIndex) -> Results<ChineseWord>{
        let realm = try! Realm()
        switch index {
        case .SortIndexStar:
            return realm.objects(ChineseWord).filter("likeIt == true")
        case .SortIndexAlphabet :
            return realm.objects(ChineseWord).sorted("pinyin")
        default:
            return realm.objects(ChineseWord)
        }
    }
    
    func setButton(button:UIButton, withSize size : CGFloat, withType type:FontAwesome) {
        let sizeFromTrait : CGFloat = (self.view.traitCollection.horizontalSizeClass == .Regular && self.view.traitCollection.verticalSizeClass == .Regular) ? size * 1.5 : size
        button.titleLabel?.font = UIFont.fontAwesomeOfSize(sizeFromTrait)
        button.setTitle(String.fontAwesomeIconWithName(type), forState: .Normal)
    }
    
    func updateUIonView() {
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        self.prevButton.enabled = (wordIndex > 0) ? true : false
        self.nextButton.enabled = (wordIndex < wordList.count-1) ? true : false
        self.nowWord = wordList[wordIndex]
        self.hanyuLabel.text = nowWord.hanyu
        self.pinyinLabel.text = nowWord.pinyin
        self.descriptionLabel.text = getDescWithLanguageIndex(AppInfo.sharedInstance.languageInfo.languageInfo)
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
    
    func setButtonDefault() {
        setButton(self.prevButton, withSize: 30, withType: .AngleLeft)
        setButton(self.nextButton, withSize: 30, withType: .AngleRight)
        setButton(self.starButton, withSize: 30, withType: .StarO)
        setButton(self.settingButton, withSize: 30, withType: .Cog)
    }
    
    func resetView() {
        touchCount = 0
        setLabelHiddenByCount(touchCount)
    }
    
    func setLabelHiddenByCount(count : Int) {
        switch count%3 {
        case 1:
            UIView .animateWithDuration(0.5, animations: {
                self.pinyinLabel.alpha = 1.0
                }, completion: { (true) in
                    self.speakWord()
            })
        case 2:
            UIView .animateWithDuration(0.5, animations: {
                self.descriptionLabel.alpha = 1.0
            })
        default:
            pinyinLabel.alpha = 0.0
            descriptionLabel.alpha = 0.0
        }
    }
    
    func speakWord() {
        let synthesize : AVSpeechSynthesizer = AVSpeechSynthesizer.init()
        let utterance : AVSpeechUtterance = AVSpeechUtterance.init(string: hanyuLabel.text!)
        utterance.rate = getSpeechSpeed(AppInfo.sharedInstance.speechSpeedInfo.speechSpeed)
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
}

