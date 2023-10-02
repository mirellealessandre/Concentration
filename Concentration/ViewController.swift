//
//  ViewController.swift
//  Concentration
//
//  Created by Mirelle Alessandre on 31/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numbersOfPairsOfCards: numbersOfPairsOfCards)
    
    var numbersOfPairsOfCards: Int {
        return (cardButtons.count + 1)/2
    }
    
    private(set) var flipsCount = 0 {
        didSet {
            flipsCountLabel.text = ("Flips: \(flipsCount)")
        }
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
        
    @IBOutlet private weak var flipsCountLabel: UILabel!
    
    @IBAction private func playAgain(_ sender: UIButton) {
        flipsCount = 0
        updateNewGame()
    }
    
    private func updateNewGame() {
        game.reset()
        updateViewFromModel()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipsCount += 1
        if let cardNumber = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("Chosen card wasnt in cardButtons")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = UIColor.white
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? UIColor.clear : UIColor.orange
            }
        }
    }

    private var emojiChoices = ["👻","💀","😈","🫀","🐷","🦉","🕸","🦑","🦚"]
    
    private var emoji = [Int:String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
    
}
