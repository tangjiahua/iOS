//
//  ViewController.swift
//  Graphical_Set
//
//  Created by 汤佳桦 on 2019/7/30.
//  Copyright © 2019 Beijing Institute of Technology. All rights reserved.
//

import UIKit

class SetViewController: UIViewController {

    var engine = SetEngine()
    var selectedcard = [CardView]()
    var hintedCard = [CardView]()
    var cardsOnScreen = [CardView]()
    
    @IBOutlet weak var moreThreeButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewFromModel()
        
    }
    
    //改变rotation的时候调用了此方法
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cardsOnScreen.forEach { card in
            card.removeFromSuperview() }
        cardsOnScreen.removeAll()
        updateViewFromModel()
    }
    
    //这是左右划动操作，导致加三张牌进来的action，具体的recognizer在下面添加的
    @objc private func draw(_ recognizer: UISwipeGestureRecognizer) {
        
        engine.drawThreeToDeck()
        //从superView中删除所有card的view
        cardsOnScreen.forEach {
            $0.removeFromSuperview()
        }
        //将cardsOnScreen也全部清空
        cardsOnScreen.removeAll()
        updateViewFromModel()
        hiddenButtonIfNeed()
        
    }
    //旋转的操作，recognizer在下面添加的
    @objc private func shuffle(_ recognizer: UIRotationGestureRecognizer){
        cardsOnScreen.forEach{$0.removeFromSuperview()}
        cardsOnScreen.removeAll()
        engine.shuffle()
        updateFromModel()
    }
    
    //给setView添加旋转、左右滑动两个操作的gestureRecognizer
    @IBOutlet weak var setView: SetView!{
        didSet {
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(draw(_:)))
            swipe.direction = [.left, .right]
            setView.addGestureRecognizer(swipe)
            setView.addGestureRecognizer(UIRotationGestureRecognizer(target: self, action: #selector(shuffle(_:))))
        }
    }
    
    //如果没有多余卡片可以添加，那么就隐藏3more按钮
    private func hiddenButtonIfNeed() {
        if engine.numberOfCard == 0 {
            moreThreeButton.isHidden = true
        } else {
            moreThreeButton.isHidden = false
        }
    }
    
   
    //再来三张卡片按钮
    @IBAction func moreThreeButtonPressed(_ sender: UIButton) {
        engine.drawThreeToDeck()
        cardsOnScreen.forEach {
            $0.removeFromSuperview()
        }
        cardsOnScreen.removeAll()
        updateViewFromModel()
        hiddenButtonIfNeed()
    }
    //hintw按钮
    @IBAction func hintButtonPressed(_ sender: UIButton) {
        engine.hint()
        if engine.hintCard.count < 3 { return }
        for index in 0...2 {
            hintedCard.append(cardsOnScreen[engine.hintCard[index]])
            cardsOnScreen[engine.hintCard[index]].state = State.stateOfSelection.hinted
            cardsOnScreen[engine.hintCard[index]].setNeedsDisplay()
/*setNeedsDisplay，每次改变属性的时候m，调用一次该方法就可以将更改的内容显示出来（由于一般更改后都是会缓存下来，并不会显示结果，所以我们需要调用一次。ps：也可以到被改变的属性的定义处使用didSet，里面调用setneedsdisplay这个方法，也可以达到这个效果。）*/
        }
        hintedCard.removeAll()
    }
    
    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        engine = SetEngine()
        cardsOnScreen.forEach {
            $0.removeFromSuperview()
        }
        cardsOnScreen.removeAll()
        updateViewFromModel()
        hiddenButtonIfNeed()
        updateScore()
        selectedcard.removeAll()
        hintedCard.removeAll()
    }
    
    
    
    
    @objc private func updateFromModel(){
        //grid是一个数组，数组每个元素都含着m对应的每一张卡片的位置、大小信息
        let grid = SetGrid(for: setView.bounds, withNoOfFrames: engine.cardOnTable.count)
        //提取grid中的信息把卡片绘制在屏幕上，并j对每一张卡片都添加tapgesture
        for index in engine.cardOnTable.indices{
            cardsOnScreen.append(CardView(frame: grid[index]!, card: engine.cardOnTable[index]))
            setView.addSubview(cardsOnScreen[index])
            cardsOnScreen[index].contentMode = .redraw
            cardsOnScreen[index].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector((tapCard(_:)))))
        }
    }
    
    //tap action
    @objc private func tapCard(_ recognizer: UITapGestureRecognizer) {
        
        guard let tappedCard = recognizer.view as? CardView else { return }
        print(tappedCard.card!)
        engine.chooseCard(at: cardsOnScreen.index(of: tappedCard)!)
        
        if let state = tappedCard.state {
            switch state {
            case .selected:
                tappedCard.state = State.stateOfSelection.unselected
                selectedcard.remove(at: selectedcard.index(of: tappedCard)!)
            case .unselected:
                tappedCard.state = State.stateOfSelection.selected
                selectedcard.append(tappedCard)
            case .hinted:
                tappedCard.state = State.stateOfSelection.selected
                selectedcard.append(tappedCard)
            }
        }
        tappedCard.setNeedsDisplay()
        
        if selectedcard.count == 3  {
            
            if isSet {
                selectedcard.removeAll()
                cardsOnScreen.forEach {
                    $0.removeFromSuperview()
                }
                cardsOnScreen.removeAll()
                updateViewFromModel()
                
            } else {
                cardsOnScreen.forEach() {
                    $0.state = State.stateOfSelection.unselected
                    $0.setNeedsDisplay()
                }
                selectedcard.removeAll()
            }
            updateScore()
        }
    }
    
    //每一次操作都要掉用这个方法
    //执行操作：重新设置一次grid，cardsOnScreen中添加cardView，setView中添加cardView，给每一个cardView都添加一个TapGesture
    private func updateViewFromModel() {
        let grid = SetGrid(for: setView.bounds, withNoOfFrames: engine.cardOnTable.count)
        for index in engine.cardOnTable.indices {
            // print(index, ": ", grid[index]!)
            cardsOnScreen.append(CardView(frame: grid[index]!, card: engine.cardOnTable[index]))
            setView.addSubview(cardsOnScreen[index])
            cardsOnScreen[index].contentMode = .redraw
            cardsOnScreen[index].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCard(_:))))
        }
    }
    
    private func updateScore() {
        scoreLabel.text = "\(engine.score)"
    }
    
    private var isSet: Bool {
        if selectedcard.count == 3 {
            return engine.isSet(on: engine.selectedCard)
        }
        return false
    }
    
    
}

