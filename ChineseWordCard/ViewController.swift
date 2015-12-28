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

class ViewController: UIViewController {

    @IBOutlet var pinyinLabel: UILabel!
    @IBOutlet var hanyuLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    
    var wordList : Results<ChineseWord>!;
    
    var nowWord : ChineseWord!
    
    var touchCount : Int = 0;
    var wordIndex : Int = 0;
    var maxWordCount : Int = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func goToNext() {
        resetAll();
        ++wordIndex;
        if (wordIndex > wordList.count-1) {
            wordIndex = wordList.count-1;
        }
        self.updateUIonView();
    }
    
    func goToPrev() {
        resetAll();
        --wordIndex;
        if (wordIndex <= 0) {
            wordIndex = 0;
        }
        self.updateUIonView();
    }
    @IBAction func nextClicked(sender: AnyObject) {
        self.goToNext();
    }
    @IBAction func prevClicked(sender: AnyObject) {
        self.goToPrev();
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        resetAll();
        
        let realm = try! Realm();
        self.wordList = realm.objects(ChineseWord);
        
        self.maxWordCount = self.wordList.count;
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        self.wordIndex = defaults.integerForKey("wordIndex")
        self.updateUIonView();
    }
    
    func updateUIonView() {
        let defaults: NSUserDefaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(wordIndex, forKey: "wordIndex")
        defaults.synchronize()
        
        self.prevButton.enabled = true;
        if (wordIndex <= 0) {
            self.prevButton.enabled = false;
        }
        self.nextButton.enabled = true;
        if (wordIndex >= wordList.count-1) {
            self.nextButton.enabled = false;
        }
        
        self.nowWord = wordList[wordIndex]
        
        self.hanyuLabel.text = nowWord.hanyu;
        self.pinyinLabel.text = nowWord.pinyin;
        self.descriptionLabel.text = nowWord.desc;
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func resetAll() {
        touchCount = 0;
        setLabelHiddenByCount(touchCount);
    }
    
    func setLabelHiddenByCount(count : Int) {
        descriptionLabel.hidden = true;
        pinyinLabel.hidden = true;
        if(count == 0) {
            return
        }
        speakWord()
        pinyinLabel.hidden = false;
        if (count%2 == 0) {
            descriptionLabel.hidden = false;
        }
        
    }
    
    func speakWord() {
        let synthesize : AVSpeechSynthesizer = AVSpeechSynthesizer.init();
        let utterance : AVSpeechUtterance = AVSpeechUtterance.init(string: hanyuLabel.text!);
        utterance.voice = AVSpeechSynthesisVoice.init(language: "zh-CN");
        synthesize.speakUtterance(utterance);
    }
        
    @IBAction func handleSwipeLeft(sender: UISwipeGestureRecognizer) {
        if (wordIndex >= wordList.count - 1) {
            return ;
        }
        self.goToNext();
    }
    
    
    @IBAction func handleSwipeRight(sender: UISwipeGestureRecognizer) {
        if (wordIndex <= 0) {
            return ;
        }
        self.goToPrev();
    }
    
    
    @IBAction func handleTap(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            // handling code
            setLabelHiddenByCount(++touchCount)
            
        }
    }
}

