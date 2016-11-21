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
    
    var currentWord : ChineseWord!
    
    var touchCount : Int = 0
    var wordIndex : Int = 0
    var maxWordCount : Int = 0
    
    // override section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setButtonDefault()
        resetView()
        getWordData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateUIonView();
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.becomeFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            wordIndex = Int(arc4random_uniform(UInt32(wordList.count)))
            updateUIonView()
        }
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    // action section
    @IBAction func nextClicked(_ sender: AnyObject) {
        self.goToNext(true)
    }
    @IBAction func prevClicked(_ sender: AnyObject) {
        self.goToNext(false)
    }
    @IBAction func valueChanged(_ sender: AnyObject) {
        resetView()
        self.wordIndex = Int(self.sliderBar.value * Float(wordList.count))
        if wordIndex <= 0 {
            wordIndex = 0
        } else if wordIndex > wordList.count-1 {
            wordIndex = wordList.count-1
        }
        self.updateUIonView()
    }
    
    @IBAction func handleSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        if isTouched(sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) && sender.state == .ended {
            self.goToNext(true)
        }
    }
    
    @IBAction func handleSwipeRight(_ sender: UISwipeGestureRecognizer) {
        if isTouched(sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) && sender.state == .ended {
            self.goToNext(false)
        }
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if isTouched(sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) && sender.state == .ended {
            touchCount += 1
            setLabelHiddenByCount(touchCount)
        }
    }
    
    @IBAction func starButtonPressed(_ sender: AnyObject) {
        if AppInfo.sharedInstance.sortInfo.sortValue.rawValue == SortIndex.sortIndexStar.rawValue {
            return
        }
        let realm = try! Realm()
        try! realm.write {
            self.currentWord.likeIt = !self.currentWord.likeIt
        }
        setButton(self.starButton, withSize: 30, withType: (currentWord.likeIt == true) ? .star:.starO)
    }
    
    @IBAction func unwindToSegue(_ segue: UIStoryboardSegue) {
        log("unwindToSegue : \(segue)")
        getWordData()
    }
}

extension ViewController {
    
    func wordIndexIncrease(_ increase : Bool) -> Int {
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
    
    func goToNext(_ isNext : Bool) {
        resetView()
        wordIndex = self.wordIndexIncrease(isNext);
        self.updateUIonView()
    }
    
    func getDataFromSort(_ index : InfoProtocol) -> Results<ChineseWord>{
        log("sort index : \(index)")
        let realm = try! Realm()
        switch index {
        case SortIndex.sortIndexStar:
            return (realm.objects(ChineseWord.self).filter("likeIt == true").count > 0) ? realm.objects(ChineseWord.self).filter("likeIt == true") : realm.objects(ChineseWord.self)
        case SortIndex.sortIndexAlphabet :
            return realm.objects(ChineseWord.self).sorted(byProperty: "pinyin")
        default:
            return realm.objects(ChineseWord.self)
        }
    }
    
    func setButton(_ button:UIButton, withSize size : CGFloat, withType type:FontAwesome) {
        let sizeFromTrait : CGFloat = (self.view.traitCollection.horizontalSizeClass == .regular && self.view.traitCollection.verticalSizeClass == .regular) ? size * 1.5 : size
        button.titleLabel?.font = UIFont.fontAwesome(ofSize: sizeFromTrait)
        button.setTitle(String.fontAwesomeIcon(name: type), for: UIControlState())
    }
    
    func updateUIonView() {
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        self.prevButton.isEnabled = (wordIndex > 0) ? true : false
        self.nextButton.isEnabled = (wordIndex < wordList.count-1) ? true : false
        self.starButton.isHidden = (AppInfo.sharedInstance.sortInfo.sortValue.rawValue == SortIndex.sortIndexStar.rawValue)
        self.currentWord = wordList[wordIndex]
        log("currentWord : \(self.currentWord)")
        self.hanyuLabel.text = currentWord.hanyu
        self.pinyinLabel.text = currentWord.pinyin
        self.descriptionLabel.text = getDescWithLanguageIndex(AppInfo.sharedInstance.languageInfo.languageValue)
        self.sliderBar.value =  Float(wordIndex)/Float(wordList.count)
        setButton(self.starButton, withSize: 30, withType: (currentWord.likeIt == true) ? .star:.starO)
    }
    
    func getDescWithLanguageIndex(_ index : InfoProtocol) -> String {
        // TODO : return string using parameter
        return currentWord.desc_kr
    }
    
    func setButtonDefault() {
        setButton(self.prevButton, withSize: 30, withType: .angleLeft)
        setButton(self.nextButton, withSize: 30, withType: .angleRight)
        setButton(self.starButton, withSize: 30, withType: .starO)
        setButton(self.settingButton, withSize: 30, withType: .cog)
    }
    
    func resetView() {
        touchCount = 0
        setLabelHiddenByCount(touchCount)
    }
    
    func getWordData() {
        self.wordList = self.getDataFromSort(AppInfo.sharedInstance.sortInfo.sortValue)
        self.maxWordCount = self.wordList.count
        self.wordIndex = AppInfo.sharedInstance.getWordIndex()
        if self.wordIndex > self.maxWordCount {
            AppInfo.sharedInstance.setWordIndex(0)
            self.wordIndex = AppInfo.sharedInstance.getWordIndex()
        }
    }
    
    func setLabelHiddenByCount(_ count : Int) {
        switch count%3 {
        case 1:
            UIView.animate(withDuration: 0.3, animations: {
                self.pinyinLabel.alpha = 1.0
            }, completion: { (success) in
                if success == true {
                    self.speakWord()
                } else {
                    log("animation fails at complete : \(count)")
                }
            })
        case 2:
            UIView.animate(withDuration: 0.3, animations: {
                self.descriptionLabel.alpha = 1.0
            }, completion: { (success) in
                if success == true {
                } else {
                    log("animation fails at complete : \(count)")
                }
            })
        default:
            pinyinLabel.alpha = 0.0
            descriptionLabel.alpha = 0.0
        }
    }
    
    func speakWord() {
        let synthesize : AVSpeechSynthesizer = AVSpeechSynthesizer()
        let utterance : AVSpeechUtterance = AVSpeechUtterance(string: hanyuLabel.text!)
        utterance.rate = getSpeechSpeed(AppInfo.sharedInstance.speechInfo.speechSpeedValue)
        utterance.voice = AVSpeechSynthesisVoice(language: "zh-CN")
        synthesize.speak(utterance)
    }
    
    func getSpeechSpeed(_ index : InfoProtocol) -> Float {
        switch index.rawValue {
        case SpeechSpeedIndex.speechSpeedSlow.rawValue:
            return AVSpeechUtteranceDefaultSpeechRate * 0.35
        case SpeechSpeedIndex.speechSpeedFast.rawValue:
            return AVSpeechUtteranceDefaultSpeechRate
        default:
            return AVSpeechUtteranceDefaultSpeechRate * 0.65
        }
    }
    
    func isTouched(_ location : CGPoint, onRect: CGRect) -> Bool{
        if location.x > 0.0 && location.x < onRect.width && location.y > 0.0 && location.y < onRect.height {
            return true
        }
        return false
    }
}

