//
//  Rating Control.swift
//  FoodTracker
//
//  Created by Anton Nikolenko on 9/29/15.
//  Copyright © 2015 Anton Nikolenko. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    
    var rating = 0{
        didSet{
            setNeedsLayout()
        }
    }
    var ratingButtons = [UIButton]()
    var spacing = 5
    var stars = 5
    
    
    // MARK: Initialization
    
    override func layoutSubviews() {
        let buttonSize = Int(frame.size.height)
        
        
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        
        // Offset each button's origin by the length of the button plus spacing.
        for (index, button) in ratingButtons.enumerate() {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing))
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<stars { 
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            button.setImage(emptyStarImage, forState: .Normal)
            button.setImage(filledStarImage, forState: .Selected)
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected])
            
            //button.backgroundColor = UIColor.redColor()
            button.adjustsImageWhenHighlighted = false
            button.addTarget(self, action: "ratingButtonTapped:", forControlEvents: .TouchDown)
            ratingButtons += [button]
            addSubview(button)
        }

    }
    
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize + spacing) * stars
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Action
    
    func ratingButtonTapped(button: UIButton) {
        rating = ratingButtons.indexOf(button)! + 1
        updateButtonSelectionStates()
        print("Button pressed 👍")
    }
    
    func updateButtonSelectionStates(){
        for(index,button) in ratingButtons.enumerate(){
            // If the index of a button is less than the rating, that button should be selected.
            button.selected = index < rating
        }
    }
}
