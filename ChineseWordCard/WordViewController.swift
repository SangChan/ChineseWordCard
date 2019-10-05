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
import GoogleMobileAds
import RxSwift
import RxCocoa

enum Direction {
    case previous
    case next
    case draw
}

class WordViewController: UIViewController {

    @IBOutlet fileprivate weak var pinyinLabel : UILabel!
    @IBOutlet fileprivate weak var hanyuLabel : UILabel!
    @IBOutlet fileprivate weak var descriptionLabel : UILabel!
    @IBOutlet fileprivate weak var nextButton : UIButton!
    @IBOutlet fileprivate weak var prevButton : UIButton!
    @IBOutlet fileprivate weak var sliderBar : UISlider!
    @IBOutlet fileprivate weak var starButton : UIButton!
    @IBOutlet fileprivate weak var settingButton : UIButton!
    
    // legacy part
    var wordList     : Results<ChineseWord>!
    var copiedString : String?
    
    // Ad banner
    var bannerView   : GADBannerView!
    
    // RX part
    let disposeBag  = DisposeBag()
    var model       = WordViewModel()
    
    lazy var buttonSize : CGFloat = {
        let size : CGFloat = 30.0
        return (self.view.traitCollection.horizontalSizeClass == .regular && self.view.traitCollection.verticalSizeClass == .regular) ? size * 1.5 : size
    }()
    
    lazy var lazyRealm : Realm? = {
        do {
            return try Realm()
        } catch let error {
            print("error : \(error)")
            return nil
        }
    }()
    
    // override section
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupRx()
        setButtonDefault()
        resetView()
        getWordData()
        addBanner()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateWordIndex()
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
    }
    
    // TODO : what's this come frome?
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    deinit {
        self.lazyRealm = nil
    }
}

// MARK: - actions

extension WordViewController {
    @IBAction func handleSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) {
            if sender.state == .ended {
                self.goTo(direction:.next)
            }
        }
    }
    
    @IBAction func handleSwipeRight(_ sender: UISwipeGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) {
            if sender.state == .ended {
                self.goTo(direction:.previous)
            }
        }
    }
    
    @IBAction func handleTap(_ sender: UITapGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) && sender.state == .ended, let touchCount = try? model.touchCount.value() {
            model.touchCount.onNext(touchCount + 1)
        }
    }
    
    @IBAction func handleLongPress(_ sender: UILongPressGestureRecognizer) {
        if isTouched(onLocation:sender.location(in: hanyuLabel), onRect: hanyuLabel.frame) && sender.state == .began {
            hanyuLabel.becomeFirstResponder()
            
            copiedString = hanyuLabel.text
            let localizedCopyString = NSLocalizedString("popup.copy", comment: "Copy")
            let copyMenuItemString = localizedCopyString
            let copyMenuItem = UIMenuItem(title: copyMenuItemString, action: #selector(copyText(_:)))
            let copyMenu = UIMenuController.shared
            copyMenu.setTargetRect(hanyuLabel.frame, in: self.view)
            copyMenu.arrowDirection = .default
            copyMenu.setMenuVisible(true, animated: true)
            copyMenu.menuItems = [copyMenuItem]
        }
    }
    
    @IBAction func unwindToSegue(_ segue: UIStoryboardSegue) {
        getWordData()
    }
}

// MARK: - control

extension WordViewController {
    
    func wordIndex(toIncrease : Bool) -> Int {
        guard var index = try? model.wordIndex.value() else { return 0}
        if toIncrease {
            index += 1
        } else {
            index -= 1
        }
        
        if index >= 0 && index < wordList.count {
            return index
        }
        return index
    }
    
    func goTo(direction : Direction) {
        switch direction {
        case .next, .previous :
            resetView()
            model.wordIndex.onNext(self.wordIndex(toIncrease:(direction == .next) ? true : false))
            self.updateWordIndex()
        default :
            resetView()
        }
    }
    
    func updateWordIndex() {
        guard let wordIndex = try? model.wordIndex.value() else { return  }
        // legacy part
        AppInfo.sharedInstance.setWordIndex(wordIndex)
        self.writeRealm(isShown: true)
    }
    
    func setButtonDefault() {
        self.prevButton.prevButton(size: buttonSize)
        self.nextButton.nextButton(size: buttonSize)
        self.starButton.starButton(size: buttonSize, style: .regular)
        self.settingButton.settingButton(size: buttonSize)
    }
    
    func resetView() {
        model.touchCount.onNext(0)
    }
    
    func isTouched(onLocation : CGPoint, onRect: CGRect) -> Bool {
        if onLocation.x > 0.0 && onLocation.x < onRect.width && onLocation.y > 0.0 && onLocation.y < onRect.height {
            return true
        }
        return false
    }
    
    @objc func copyText(_ sender : UIMenuController) {
        guard let copiedString = self.copiedString else { return }
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = copiedString
    }
}

// MARK: - realm

extension WordViewController {
    func getData(sortIndex : InfoProtocol) -> Results<ChineseWord>? {
        guard let realm = self.lazyRealm else { return .none }
        switch sortIndex {
        case SortIndex.sortIndexStar :
            return (realm.objects(ChineseWord.self).filter("likeIt == true").count > 0) ? realm.objects(ChineseWord.self).filter("likeIt == true") : realm.objects(ChineseWord.self)
        case SortIndex.sortIndexAlphabet :
            return realm.objects(ChineseWord.self).sorted(byKeyPath: "pinyin")
        default :
            return realm.objects(ChineseWord.self)
        }
    }
    
    func writeRealm(likeIt : Bool) {
        guard let realm = try? Realm(), let currentWord = try? model.currentWord.value() else { return }
        model.likeIt.onNext(likeIt)
        try? realm.write {
            currentWord.likeIt = likeIt
        }
    }

    func writeRealm(isShown : Bool) {
        guard let realm = try? Realm(), let currentWord = try? model.currentWord.value() else { return }
        try? realm.write {
            currentWord.isShown = isShown
            currentWord.play += 1
        }
    }
    
    func getWordData() {
        guard let wordList = self.getData(sortIndex: AppInfo.sharedInstance.sortInfo.sortValue) else { return }
        self.wordList = wordList
        let maxWordCount = self.wordList.count
        var wordIndex = AppInfo.sharedInstance.getWordIndex()
        if wordIndex > maxWordCount {
            AppInfo.sharedInstance.setWordIndex(0)
            wordIndex = AppInfo.sharedInstance.getWordIndex()
        }
        self.model.wordIndex.onNext(wordIndex)
    }
}

// MARK: - about banner

extension WordViewController {
    static let adId = "ca-app-pub-7672230516236261/8258045034"
    func addBanner() {
        self.bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        addBannerViewToView(self.bannerView)
        self.bannerView.adUnitID = WordViewController.adId
        self.bannerView.rootViewController = self
        self.bannerView.load(GADRequest())
        self.bannerView.delegate = self
    }
    
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        positionBannerViewFullWidthAtBottomOfSafeArea(bannerView)
    }
    
    func positionBannerViewFullWidthAtBottomOfSafeArea(_ bannerView: UIView) {
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([guide.leftAnchor.constraint(equalTo: bannerView.leftAnchor),
                                     guide.rightAnchor.constraint(equalTo: bannerView.rightAnchor),
                                     guide.bottomAnchor.constraint(equalTo: bannerView.bottomAnchor)])
    }
}

// MARK: - about RX

extension WordViewController {
    /// setup ReactiveX codes
    func setupRx() {
        nextButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.goTo(direction:.next)
            })
            .disposed(by: disposeBag)
        
        prevButton.rx.tap
            .subscribe(onNext: { [weak self] in
                self?.goTo(direction:.previous)
            })
            .disposed(by: disposeBag)
        
        starButton.rx.tap
            .subscribe(onNext: { [weak self] in
                guard AppInfo.sharedInstance.sortInfo.sortValue.rawValue != SortIndex.sortIndexStar.rawValue, let currentLikeIt = try? self?.model.currentWord.value().likeIt else { return }
                self?.writeRealm(likeIt: !currentLikeIt)
            })
            .disposed(by: disposeBag)
        
        sliderBar.rx.value
            .map({ [weak self] (value) -> Int in
                guard let self = self, let wordList = self.wordList else { return 0 }
                var newIndex = Int(value * Float(wordList.count))
                if newIndex <= 0 {
                    newIndex = 0
                } else if newIndex >= wordList.count-1 {
                    newIndex = wordList.count-1
                }
                return newIndex
            })
            .subscribe { [weak self] (value) in
                guard let self = self else { return }
                self.model.wordIndex.onNext(value.element ?? 0)
                self.resetView()
                self.updateWordIndex()
            }
            .disposed(by: disposeBag)
        
        model.wordIndex.asObservable()
            .map({ [weak self] (value) -> Float in
                guard let self = self, let wordList = self.wordList else { return 0.0 }
                return Float(value)/Float(wordList.count)
            })
            .bind(to: sliderBar.rx.value)
            .disposed(by: disposeBag)
        
        model.wordIndex.asObservable()
            .subscribe { [weak self] (value) in
                guard let self = self, let wordList = self.wordList, let wordIndex = value.element else { return }
                let currentWord = wordList[wordIndex]
                self.model.currentWord.onNext(currentWord)
                self.model.hanyuAlpha.onNext(1.0)
                self.model.starButtonHidden.onNext((AppInfo.sharedInstance.sortInfo.sortValue.rawValue == SortIndex.sortIndexStar.rawValue))
                self.model.prevEnable.onNext(wordIndex > 0)
                self.model.nextEnable.onNext(wordIndex < wordList.count-1)
            }
            .disposed(by: disposeBag)
        
        model.currentWord.asObservable()
            .subscribe { [weak self] (value) in
                guard let self = self, let currentWord = value.element else { return }
                self.model.likeIt.onNext(currentWord.likeIt)
                self.model.hanyu.onNext(currentWord.hanyu)
                self.model.pinyin.onNext(currentWord.pinyin)
                let firstLang = Bundle.main.preferredLocalizations.first ?? "en"
                if firstLang == "ko" {
                    self.model.desc.onNext(currentWord.desc_kr)
                }
                self.model.desc.onNext(currentWord.desc_en)
            }
            .disposed(by: disposeBag)
        
        model.hanyu.asObservable()
            .map({ $0 })
            .bind(to: hanyuLabel.rx.text)
            .disposed(by: disposeBag)
        
        model.pinyin.asObservable()
            .map({ $0 })
            .bind(to: pinyinLabel.rx.text)
            .disposed(by: disposeBag)
        
        model.desc.asObservable()
            .map({ $0 })
            .bind(to: descriptionLabel.rx.text)
            .disposed(by: disposeBag)
        
        model.hanyuAlpha.asObservable()
            .map({ CGFloat($0) })
            .bind(to: hanyuLabel.rx.alpha)
            .disposed(by: disposeBag)
        
        model.descAlpha.asObservable()
            .map({ CGFloat($0) })
            .bind(to: descriptionLabel.rx.alpha)
            .disposed(by: disposeBag)
        
        model.pinyinAlpha.asObservable()
            .map({ CGFloat($0) })
            .bind(to: pinyinLabel.rx.alpha)
            .disposed(by: disposeBag)
        
        model.prevEnable.asObservable()
            .map({ $0 })
            .bind(to: prevButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        model.nextEnable.asObservable()
            .map({ $0 })
            .bind(to: nextButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        model.starButtonHidden.asObservable()
            .map({ $0 })
            .bind(to: starButton.rx.isHidden)
            .disposed(by: disposeBag)
        
        model.likeIt.asObservable()
            .subscribe { [weak self] (value) in
                guard let self = self, self.wordList != nil, let likeIt = value.element else { return }
                self.starButton.starButton(size: self.buttonSize, style: (likeIt == true) ? .solid : .regular )
            }
            .disposed(by: disposeBag)
        
        model.touchCount.asObservable()
            .subscribe { [weak self] (value) in
                guard let self = self, let touchCount = value.element else { return }
                switch touchCount % 3 {
                case 1 :
                    UIView.animate(withDuration: 0.3, animations: {
                        self.model.pinyinAlpha.onNext(1.0)
                    }, completion: { _ in
                        try? self.model.currentWord.value().speakWord()
                    })
                case 2 :
                    UIView.animate(withDuration: 0.3, animations: {
                        self.model.descAlpha.onNext(1.0)
                    }, completion: nil)
                default :
                    self.model.pinyinAlpha.onNext(0.0)
                    self.model.descAlpha.onNext(0.0)
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - about Google Ads SDK

extension WordViewController : GADBannerViewDelegate {
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
      print("adViewDidReceiveAd")
    }

    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
        didFailToReceiveAdWithError error: GADRequestError) {
      print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
      print("adViewWillPresentScreen")
    }

    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
      print("adViewWillDismissScreen")
    }

    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
      print("adViewDidDismissScreen")
    }

    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
      print("adViewWillLeaveApplication")
    }
}
