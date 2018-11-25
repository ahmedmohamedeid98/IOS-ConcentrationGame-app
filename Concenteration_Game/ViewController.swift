//
//  ViewController.swift
//  Concenteration_Game
//
//  Created by MacOS on 3/15/1440 AH.
//  Copyright © 1440 AH Ahmed Eid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    // model
    private lazy var game = Concenteration(numberOfPairsOfCard: numberOfPairsOfCard)
    
    // if readonly you can write it without get{}
    var numberOfPairsOfCard:Int{
        return (CardButtons.count + 1)/2
    }
    
    // read only
    private(set) var FlipCount = 0{didSet{FlipCountLable.text = "Flips :\(FlipCount)"}}
    
    
    @IBOutlet private var CardButtons: [UIButton]!
    @IBOutlet private weak var FlipCountLable: UILabel!
    @IBAction private func touchCard(_ sender: UIButton) {
        FlipCount += 1
        if let cardNumber = CardButtons.index(of: sender){
            game.ChoosCard(at: cardNumber)
            updataViewFromModel()
        }
        
    }
    private func updataViewFromModel(){
        for index in CardButtons.indices{
            let button = CardButtons[index]
            let card = game.Cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = UIColor.white
            }
            else{
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }
    private var emojiChoice = ["👻","🍇","🍐","🍎","🍋","🌎","☀️","🍀","🦀","🐫","🦅","🐿","🥦"]
    private var emoji = [Int:String]()
    private func emoji(for card: Card) -> String{
        if emoji[card.identifier] == nil , emojiChoice.count > 0{
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoice.count)))
            emoji[card.identifier] = emojiChoice.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
    
    //        return emoji[card.identifier] ?? "?" is ->
    //        if emoji[card.identifier] != nil{
    //            return emoji[card.identifier]!
    //        }
    //        else{
    //            return "?"
    //        }

}

