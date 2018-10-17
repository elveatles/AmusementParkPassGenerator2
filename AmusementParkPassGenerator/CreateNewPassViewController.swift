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
        detailsAttributed.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, detailsAttributed.length))
        passDetailsLabel.attributedText = detailsAttributed
    }
    
    @IBAction func testAreaAccess() {
    }
    
    @IBAction func testRideAccess() {
    }
    
    @IBAction func testDiscountAccess() {
    }
    
    @IBAction func createNewPass() {
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
