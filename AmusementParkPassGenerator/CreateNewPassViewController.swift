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
    @IBOutlet weak var testResultsBackground: UIView!
    
    public let testResultsFont = UIFont.boldSystemFont(ofSize: 18)
    public let successColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    public let failColor = #colorLiteral(red: 0.9254902005, green: 0.3349699263, blue: 0.2380417806, alpha: 1)
    
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
    
    @IBAction func testOffice() {
        runTest(parkArea: .office)
    }
    
    @IBAction func testKitchen() {
        runTest(parkArea: .kitchen)
    }
    
    @IBAction func testRideControl() {
        runTest(parkArea: .rideControl)
    }
    
    @IBAction func testAmusement() {
        runTest(parkArea: .amusement)
    }
    
    @IBAction func testRides() {
        guard let thePass = pass else {
            showNoPass()
            return
        }
        
        var result = thePass.swipe(rideAccess: .skipLines)
        if result.success {
            result = SwipeResult(success: result.success, message: "Skip Lines: \(result.message)")
            showSwipeResult(result)
            return
        }
        
        result = thePass.swipe(rideAccess: .all)
        showSwipeResult(result)
    }
    
    @IBAction func testFoodDiscount() {
        runTest(discountType: .food)
    }
    
    @IBAction func testMerchDiscount() {
        runTest(discountType: .merchandise)
    }
    
    @IBAction func testMaintenance() {
        runTest(parkArea: .maintenance)
    }
    
    @IBAction func createNewPass() {
        dismiss(animated: true, completion: nil)
    }
    
    func runTest(parkArea: ParkArea) {
        guard let thePass = pass else {
            showNoPass()
            return
        }
        
        let result = thePass.swipe(parkArea: parkArea)
        showSwipeResult(result)
    }
    
    func runTest(discountType: DiscountType) {
        guard let thePass = pass else {
            showNoPass()
            return
        }
        
        let result = thePass.swipe(discountType: discountType)
        let success = result > 0.001
        let percent = Int(result * 100.0)
        let message = "\(percent)% discount"
        showSwipeTest(success: success, message: message)
    }
    
    private func showNoPass() {
        testResultsLabel.text = "No pass was found!"
        testResultsBackground.backgroundColor = failColor
    }
    
    private func showSwipeResult(_ swipeResult: SwipeResult) {
        showSwipeTest(success: swipeResult.success, message: swipeResult.message)
    }
    
    private func showSwipeTest(success: Bool, message: String) {
        testResultsLabel.text = message
        if success {
            testResultsBackground.backgroundColor = successColor
        } else {
            testResultsBackground.backgroundColor = failColor
        }
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
