//
//  CreateNewPassViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/16/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

/// The View Controller for showing and testing a newly created pass
class CreateNewPassViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var entrantSubtypeLabel: UILabel!
    @IBOutlet weak var passDetailsLabel: UILabel!
    @IBOutlet weak var testResultsLabel: UILabel!
    @IBOutlet weak var testResultsBackground: UIView!
    
    @IBOutlet weak var passBackground: UIView!
    @IBOutlet weak var passImage: UIImageView!
    @IBOutlet weak var passHole: UIView!
    @IBOutlet weak var buttonsStackView0: UIStackView!
    @IBOutlet weak var buttonsStackView1: UIStackView!
    @IBOutlet weak var createNewPassButton: UIButton!
    
    public let successSoundName = "AccessGranted"
    public let failSoundName = "AccessDenied"
    public let successColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
    public let failColor = #colorLiteral(red: 0.9254902005, green: 0.3349699263, blue: 0.2380417806, alpha: 1)
    private let standardBorderRadius: CGFloat = 4
    
    /// The current pass to show and test with
    public var pass: Pass?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupStyles()
        testResultsLabel.text = ""
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        updateInformation()
    }
    
    /// Update information on the pass including fullName, pass type, ride access, and discounts
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
    
    /**
     Test swipe in an area of the park.
     
     - Parameter parkArea: The area of the park the swipe happens in.
    */
    func runTest(parkArea: ParkArea) {
        guard let thePass = pass else {
            showNoPass()
            return
        }
        
        let result = thePass.swipe(parkArea: parkArea)
        showSwipeResult(result)
    }
    
    /**
     Test swipe for a discount.
     
     - Parameter discountType: The type of discount the swipe is for.
    */
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
    
    /// Setup styling that could not be done in Storyboard
    private func setupStyles() {
        passBackground.layer.cornerRadius = 10
        passBackground.layer.shadowRadius = 1
        passBackground.layer.shadowColor = UIColor.black.cgColor
        passBackground.layer.shadowOffset = CGSize(width: 1, height: 1)
        passBackground.layer.shadowOpacity = 0.3
        
        passImage.layer.masksToBounds = true
        passImage.layer.cornerRadius = standardBorderRadius
        
        passHole.layer.cornerRadius = 8
        let _ = passHole.layer.addInnerShadow(innerOffset: CGSize(width: 0, height: 1), innerOpacity: 0.3)
        
        for case let button as UIButton in buttonsStackView0.arrangedSubviews {
            button.layer.cornerRadius = standardBorderRadius
        }
        
        for case let button as UIButton in buttonsStackView1.arrangedSubviews {
            button.layer.cornerRadius = standardBorderRadius
        }
        
        testResultsBackground.layer.cornerRadius = standardBorderRadius
        let _ = testResultsBackground.layer.addInnerShadow(innerOffset: CGSize(width: 0, height: 1), innerOpacity: 0.3)
        createNewPassButton.layer.cornerRadius = standardBorderRadius
    }
    
    /// If for some reason, pass is nil, a custom message will be shown in the test area.
    private func showNoPass() {
        testResultsLabel.text = "No pass was found!"
        testResultsBackground.backgroundColor = failColor
    }
    
    /**
     Show the results of a swipe test.
     
     - Parameter swipeResult: The result object of a swipe.
    */
    private func showSwipeResult(_ swipeResult: SwipeResult) {
        showSwipeTest(success: swipeResult.success, message: swipeResult.message)
    }
    
    /**
     Show the results of a swipe test.
     
     - Parameter success: Whether the swipe was successful or not.
     - Parameter message: A message to display.
    */
    private func showSwipeTest(success: Bool, message: String) {
        testResultsLabel.text = message
        testResultsBackground.backgroundColor = success ? successColor : failColor
        let soundName = success ? successSoundName : failSoundName
        SoundPlayer.playSound(name: soundName, ext: "wav")
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
