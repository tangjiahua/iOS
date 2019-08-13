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
    var cardsNeedAnimated = [CardView]()
    
    @IBOutlet weak var moreThreeButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hintButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        updateViewFromModelFirstTime()
    }
    
    //
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let grid = SetGrid(for: setView.bounds, withNoOfFrames: engine.cardOnTable.count)
        for index in cardsOnScreen.indices {
            cardsOnScreen[index].frame = grid[index]!
            cardsOnScreen[index].setNeedsDisplay()
        }
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
        updateViewFromModel()
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
        updateViewFromModelByThreeMoreCards()
        
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
        updateViewFromModelFirstTime()
        hiddenButtonIfNeed()
        updateScore()
        selectedcard.removeAll()
        hintedCard.removeAll()
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
                updateViewFromModelIsSet()
                selectedcard.removeAll()
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
    
    private func updateViewFromModelIsSet(){
        let dealToStView = setView.convert(moreThreeButton.bounds, from: moreThreeButton)
        let grid = SetGrid(for: self.setView.bounds, withNoOfFrames: self.engine.cardOnTable.count)
        for index in selectedcard.indices{
            let removeIndex = self.cardsOnScreen.firstIndex(of: selectedcard[index])!
            UIView.transition(with: cardsOnScreen[removeIndex], duration: 0.7, options: .transitionCrossDissolve, animations: {
                self.cardsOnScreen[removeIndex].alpha = 0
            }) { finished in
                let gridIndex = self.cardsOnScreen.firstIndex(of: self.cardsOnScreen[removeIndex])
                var mycard = CardView.init(frame: dealToStView)
                mycard.isFaceUp = false
                mycard.backgroundColor = UIColor.blue
                mycard.frame = dealToStView


                self.setView.addSubview(mycard)
                UIView.animate(withDuration: 0.7,
                               delay: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.moreThreeButton.isUserInteractionEnabled = false
                                self.hintButton.isUserInteractionEnabled = false
                                mycard.frame = grid[gridIndex!]!
                },
                               completion: { finisehed in
                                UIView.transition(with: mycard,
                                                  duration: 0.2,
                                                  options: .transitionFlipFromLeft,
                                                  animations: {
                                                    mycard.isFaceUp = true
                                                    mycard.card = self.engine.cardOnTable[removeIndex]
                                                    mycard.setNeedsDisplay()

                                }, completion: { finisehed in
                                    self.moreThreeButton.isUserInteractionEnabled = true
                                    self.hintButton.isUserInteractionEnabled = true
                                    self.cardsOnScreen[removeIndex] = mycard
                                    self.cardsOnScreen[removeIndex].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapCard(_:))))
                                    self.cardsOnScreen[removeIndex].state = State.stateOfSelection.unselected
                                    self.cardsOnScreen[removeIndex].setNeedsDisplay()
                                })
                })


            }
        }
    }
    
    
    //第一次updateview，发牌
    private func updateViewFromModelFirstTime(){
        cardsOnScreen.removeAll()
        cardsOnScreen.forEach { card in
            card.removeFromSuperview() }
        
        
        let dealToStView = setView.convert(moreThreeButton.bounds, from: moreThreeButton)
        for index in engine.cardOnTable.indices {
            cardsOnScreen.append(CardView.init(frame: dealToStView))
            cardsOnScreen[index].isFaceUp = false
            cardsOnScreen[index].backgroundColor = UIColor.blue
            setView.addSubview(cardsOnScreen[index])
            cardsOnScreen[index].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapCard(_:))))
            cardsOnScreen[index].setNeedsDisplay()
            cardsOnScreen[index].state = State.stateOfSelection.unselected
        }
        setView.setNeedsDisplay()
        dealFirstTime()
    }
    
    
    func dealFirstTime(){
        let grid = SetGrid(for: setView.bounds, withNoOfFrames: engine.cardOnTable.count)
        
        var delayTime = 0.0
        for timeOfAnimate in 0..<cardsOnScreen.count {
            let gridIndex = cardsOnScreen.index(of: cardsOnScreen[timeOfAnimate])
            //gridIndex为屏幕上要有动画的卡片在cardsOnScreen的index
            //timeOfAnimate为cardsNeedAnimated中的index
            delayTime = 0.1 * Double(timeOfAnimate)
            
            UIView.animate(withDuration: 0.7,
                           delay: delayTime,
                           options: .curveEaseInOut,
                           animations: {
                            // print(self.cardsNeedAnimated[timeOfAnimate].isFaceUp)
                            self.moreThreeButton.isUserInteractionEnabled = false
                            self.cardsOnScreen[timeOfAnimate].frame = grid[gridIndex!]!
            },
                           completion: { finisehed in
                            UIView.transition(with: self.cardsOnScreen[timeOfAnimate],
                                              duration: 0.2,
                                              options: .transitionFlipFromLeft,
                                              animations: {
                                                self.cardsOnScreen[timeOfAnimate].isFaceUp = true
                                                self.cardsOnScreen[timeOfAnimate].card = self.engine.cardOnTable[timeOfAnimate]
                                                self.cardsOnScreen[timeOfAnimate].setNeedsDisplay()
                                            
                            }, completion: { finisehed in
                                if timeOfAnimate == self.cardsOnScreen.endIndex - 1 {
                                    self.moreThreeButton.isUserInteractionEnabled = true
                                }
                            })
            })
        }
    }
    
    
    private func updateViewFromModelByThreeMoreCards(){
        let grid = SetGrid(for: setView.bounds, withNoOfFrames: engine.cardOnTable.count)
        
        for index in cardsOnScreen.indices{
            UIView.transition(with: cardsOnScreen[index], duration: 1, options: [.allowAnimatedContent], animations: {
                let scaleX = grid[index]!.width/self.cardsOnScreen[index].frame.width
                let scaleY = grid[index]!.height/self.cardsOnScreen[index].frame.height
                self.cardsOnScreen[index].transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
                self.moreThreeButton.isUserInteractionEnabled = false
            }, completion: {
                finished in
                UIView.animate(withDuration: 1, animations: {
                    self.cardsOnScreen[index].frame = grid[index]!
                    self.cardsOnScreen[index].subviews.map{
                        $0.removeFromSuperview()
                    }
                    self.cardsOnScreen[index].setNeedsDisplay()
                }, completion: { (finished) in
                    self.moreThreeButton.isUserInteractionEnabled = true
                    
                })
                
            })
        }
        self.dealByThreeMore()
    }
    
    //这个时候已经有一堆cardView在3morebutton上了
    //他们就是cardsNeedanimated，我只需要把他们从牌堆发出去
    private func dealByThreeMore(){
        cardsNeedAnimated = []
        let newCardRect = setView.convert(moreThreeButton.bounds, from:moreThreeButton)
        let countOfCardsOnScreen = cardsOnScreen.count
        for index in 0...2{
            cardsOnScreen.append(CardView.init(frame: newCardRect))
            cardsOnScreen[countOfCardsOnScreen+index].backgroundColor = UIColor.blue
            setView.addSubview(cardsOnScreen[countOfCardsOnScreen+index])
        }
        
        //将card3morebutton上的uiview发到对应的牌区
        var delay = 0.2
        var countOfCardsOnTable = engine.cardOnTable.count - 3
        let grid = SetGrid(for: setView.bounds, withNoOfFrames: engine.cardOnTable.count)
        for index in 0...2{
            
            UIView.animate(withDuration: 0.7, delay: delay * Double(index)+2, options: [.allowAnimatedContent], animations: {
                self.moreThreeButton.isUserInteractionEnabled = false
                self.cardsOnScreen[index+countOfCardsOnTable].frame = grid[index+countOfCardsOnScreen]!
            }) { (finished) in
                UIView.transition(with: self.cardsOnScreen[index+countOfCardsOnTable],
                                  duration: 0.2,
                                  options: .transitionFlipFromLeft,
                                  animations: {
                                    self.cardsOnScreen[index+countOfCardsOnTable].card = self.engine.cardOnTable[index+countOfCardsOnScreen]
                                    self.cardsOnScreen[index+countOfCardsOnTable].addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapCard(_:))))
                                    self.cardsOnScreen[index+countOfCardsOnTable].isFaceUp = true
                                    self.cardsOnScreen[index+countOfCardsOnTable].setNeedsDisplay()
                }, completion: { finisehed in
                    if index+countOfCardsOnTable == self.cardsOnScreen.endIndex - 1 {
                        self.moreThreeButton.isUserInteractionEnabled = true
                    }
                })
            }
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

