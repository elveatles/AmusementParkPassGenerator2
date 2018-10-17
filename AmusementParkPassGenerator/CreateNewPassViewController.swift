//
//  CreateNewPassViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/16/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

class CreateNewPassViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var entrantSubtypeLabel: UILabel!
    @IBOutlet weak var passDetailsLabel: UILabel!
    @IBOutlet weak var testResultsLabel: UILabel!
    
    public let testResultsFont = UIFont.boldSystemFont(ofSize: 18)
    public let successColor = UIColor(red: 62.0/255.0, green: 152.0/255.0, blue: 155.0/255.0, alpha: 1.0)
    public let failColor = UIColor(red: 0.9, green: 0.1, blue: 0.0, alpha: 1.0)
    
    public var pass: Pass?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        testResultsLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateInformation()
    }
    
    func updateInformation() {
        guard let thePass = pass else {
            print("updateInformation failed because pass is nil.")
            return
        }
        
        if let fullName = thePass.entrant.fullName {
            nameLabel.text = fullName
        } else {
            nameLabel.text = "???"
        }
        
        entrantSubtypeLabel.text = type(of: thePass).typeDisplayName
        var details = ""
        if thePass.swipe(rideAccess: RideAccess.skipLines, checkSwipeTime: false).success {
            details += "• Skip Ride Lines\n"
        } else if thePass.swipe(rideAccess: RideAccess.all, checkSwipeTime: false).success {
            details += "• Unlimited Rides\n"
        } else {
            details += "• No ride access\n"
        }
        
        let foodDiscount = thePass.swipe(discountType: .food)
        let foodDiscountDisplay = Int(foodDiscount * 100)
        let merchandiseDiscount = thePass.swipe(discountType: .merchandise)
        let merchandiseDiscountDisplay = Int(merchandiseDiscount * 100)
        details += "• \(foodDiscountDisplay)% Food Discount\n"
        details += "• \(merchandiseDiscountDisplay)% Merchandise Discount"
        let detailsAttributed = NSMutableAttributedString(string: details)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 15
        detailsAttributed.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, detailsAttributed.length))
        passDetailsLabel.attributedText = detailsAttributed
    }
    
    @IBAction func testAreaAccess() {
        guard let thePass = pass else {
            testResultsLabel.text = "Pass is missing."
            return
        }
        
        var result = thePass.swipe(parkArea: .amusement)
        let attributedString = createAttributedString(with: result, messageFormat: "Amusement: %@\n")
        result = thePass.swipe(parkArea: .kitchen)
        var line = createAttributedString(with: result, messageFormat: "Kitchen: %@\n")
        attributedString.append(line)
        result = thePass.swipe(parkArea: .rideControl)
        line = createAttributedString(with: result, messageFormat: "Ride Control: %@\n")
        attributedString.append(line)
        result = thePass.swipe(parkArea: .maintenance)
        line = createAttributedString(with: result, messageFormat: "Maintenance: %@\n")
        attributedString.append(line)
        result = thePass.swipe(parkArea: .office)
        line = createAttributedString(with: result, messageFormat: "Office: %@")
        attributedString.append(line)
        attributedString.addAttribute(.font, value: testResultsFont, range: NSMakeRange(0, attributedString.length))
        
        testResultsLabel.attributedText = attributedString
    }
    
    @IBAction func testRideAccess() {
        guard let thePass = pass else {
            testResultsLabel.text = "Pass is missing."
            return
        }
        
        var result = thePass.swipe(rideAccess: .all, checkSwipeTime: false)
        let attributedString = createAttributedString(with: result, messageFormat: "All Rides: %@\n")
        result = thePass.swipe(rideAccess: .skipLines, checkSwipeTime: false)
        let line = createAttributedString(with: result, messageFormat: "Skip Lines: %@")
        attributedString.append(line)
        attributedString.addAttribute(.font, value: testResultsFont, range: NSMakeRange(0, attributedString.length))
        
        testResultsLabel.attributedText = attributedString
    }
    
    @IBAction func testDiscountAccess() {
        guard let thePass = pass else {
            testResultsLabel.text = "Pass is missing!"
            return
        }
        
        let foodDiscount = thePass.swipe(discountType: .food)
        let foodPercent = Int(foodDiscount * 100.0)
        let merchandiseDiscount = thePass.swipe(discountType: .merchandise)
        let merchandisePercent = Int(merchandiseDiscount * 100.0)
        var text = "\(foodPercent)% Food Discount\n"
        text += "\(merchandisePercent)% Merchandise Discount"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: testResultsFont
        ]
        let attributedString = NSMutableAttributedString(string: text, attributes: attributes)
        
        testResultsLabel.attributedText = attributedString
    }
    
    @IBAction func createNewPass() {
        dismiss(animated: true, completion: nil)
    }
    
    private func createAttributedString(with swipeResult: SwipeResult, messageFormat: String) -> NSMutableAttributedString {
        let message = String(format: messageFormat, swipeResult.message)
        let result = NSMutableAttributedString(string: message)
        let color: UIColor = swipeResult.success ? successColor : failColor
        result.addAttribute(.foregroundColor, value: color, range: NSMakeRange(0, result.length))
        return result
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
