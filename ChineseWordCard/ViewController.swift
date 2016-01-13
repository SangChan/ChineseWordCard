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
        resetAll()
        ++wordIndex
        if wordIndex > wordList.count-1 {
            wordIndex = wordList.count-1
        }
        self.updateUIonView()
    }
    
    func goToPrev() {
        resetAll()
        --wordIndex
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
        resetAll()
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
        self.prevButton.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        self.prevButton.setTitle(String.fontAwesomeIconWithName(.AngleLeft), forState: .Normal)
        self.nextButton.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        self.nextButton.setTitle(String.fontAwesomeIconWithName(.AngleRight), forState: .Normal)
        self.starButton.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        self.starButton.setTitle(String.fontAwesomeIconWithName(.StarO), forState: .Normal)
        self.settingButton.titleLabel?.font = UIFont.fontAwesomeOfSize(30)
        self.settingButton.setTitle(String.fontAwesomeIconWithName(.Cog), forState: .Normal)
        resetAll()
        
        let realm = try! Realm()
        self.wordList = realm.objects(ChineseWord)
        
        self.maxWordCount = self.wordList.count
        self.wordIndex = NSUserDefaults.standardUserDefaults().integerForKey("wordIndex")
        self.updateUIonView();
    }
    
    func updateUIonView() {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(wordIndex, forKey: "wordIndex")
        defaults.synchronize()
        
        self.prevButton.enabled = (wordIndex > 0) ? true : false
        self.nextButton.enabled = (wordIndex < wordList.count-1) ? true : false
        self.nowWord = wordList[wordIndex]
        self.hanyuLabel.text = nowWord.hanyu
        self.pinyinLabel.text = nowWord.pinyin
        self.descriptionLabel.text = nowWord.desc
        self.sliderBar.value =  Float.init(wordIndex)/Float.init(wordList.count)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func resetAll() {
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
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate
        utterance.voice = AVSpeechSynthesisVoice.init(language: "zh-CN")
        synthesize.speakUtterance(utterance)
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
            // handling code
            setLabelHiddenByCount(++touchCount)
        }
    }
}

