//
//  ViewController.swift
//  AmusementParkPassGenerator
//
//  Created by Erik Carlson on 10/4/18.
//  Copyright © 2018 Round and Rhombus. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var employeeButton: UIButton!
    @IBOutlet weak var managerButton: UIButton!
    @IBOutlet weak var vendorButton: UIButton!
    @IBOutlet weak var entrantSubtypeStackView: UIStackView!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var ssnLabel: UILabel!
    @IBOutlet weak var ssnTextField: UITextField!
    @IBOutlet weak var projectNumberLabel: UILabel!
    @IBOutlet weak var projectNumberTextField: UITextField!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var streetAddressLabel: UILabel!
    @IBOutlet weak var streetAddressTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var zipCodeTextField: UITextField!
    
    /// The selected entrant type.
    /// Updates the appearance of the entrant type buttons.
    /// Updates which entrant subtype buttons are displayed.
    var selectedEntrantType: EntrantType = .guest {
        didSet {
            selectButtonInSet(buttonDict: entrantTypeButtons, currentSelection: selectedEntrantType)
            if let subtypeButtons = entrantSubtypeButtons[selectedEntrantType] {
                currentEntrantSubtypeButtons = subtypeButtons
            }
            
            selectedEntrantSubtype = nil
        }
    }
    
    /// The selected entrant subtype.
    /// Updates the appearance of entrant subtype buttons.
    var selectedEntrantSubtype: EntrantSubtype? {
        didSet {
            selectButtonInSet(buttonDict: currentEntrantSubtypeButtons, currentSelection: selectedEntrantSubtype)
        }
    }
    
    /// The entrant subtype buttons that are visible on screen.
    /// Removes all buttons from entrantSubtypeStackView,
    /// then adds all of the newly assigned entrantSubtypeButtons to entrantSubtypeStackView.
    private var currentEntrantSubtypeButtons = [EntrantSubtype: UIButton]() {
        didSet {
            for subview in entrantSubtypeStackView.arrangedSubviews {
                subview.removeFromSuperview()
            }
            
            for button in currentEntrantSubtypeButtons.values {
                entrantSubtypeStackView.addArrangedSubview(button)
            }
        }
    }
    
    private var entrantTypeButtons = [EntrantType: UIButton]()
    private var entrantSubtypeButtons: [EntrantType: [EntrantSubtype: UIButton]] = [
        .guest: [:], .employee: [:], .manager: [:], .vendor: [:]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Assign entrant type buttons
        entrantTypeButtons = [
            .guest: guestButton,
            .employee: employeeButton,
            .manager: managerButton,
            .vendor: vendorButton]
        // Start out with no entrant type buttons selected
        for button in entrantTypeButtons.values {
            selectButton(button, isSelected: false)
        }
        
        // Clear entrant subtypes
        for subview in entrantSubtypeStackView.arrangedSubviews {
            subview.removeFromSuperview()
        }
        
        // Create all entrant subtype buttons
        for key in entrantSubtypeButtons.keys {
            var subtypeButtons = [EntrantSubtype: UIButton]()
            for (subtype, displayName) in EntrantSubtype.displayNames(for: key) {
                subtypeButtons[subtype] = createEntrantSubtypeButton(title: displayName)
            }
            entrantSubtypeButtons[key] = subtypeButtons
        }
    }
    
    @IBAction func guestChosen() {
        selectedEntrantType = .guest
    }
    
    @IBAction func employeeChosen() {
        selectedEntrantType = .employee
    }
    
    @IBAction func managerChosen() {
        selectedEntrantType = .manager
    }
    
    @IBAction func vendorChosen(_ sender: Any) {
        selectedEntrantType = .vendor
    }
    
    @objc func entrantSubtypeSelected(_ sender: UIButton) {
        // Match the selected button to the associated entrant subtype,
        // and assign it to currentEntrantSubtype
        for (et, button) in currentEntrantSubtypeButtons {
            if button == sender {
                selectedEntrantSubtype = et
                break
            }
        }
    }
    
    @IBAction func generatePass() {
    }
    
    @IBAction func populateData() {
    }
    
    /**
     Create an entrant subtype button.
     
     - Parameter title: The button title text.
     - Returns: The entrant subtype button that was created.
    */
    private func createEntrantSubtypeButton(title: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        selectButton(button, isSelected: false)
        button.addTarget(self, action: #selector(ViewController.entrantSubtypeSelected(_:)), for: .touchUpInside)
        return button
    }
    
    /**
     Select a button in a set of buttons.
     
     Changes the appearance of all buttons based on which one is selected.
     
     - Parameter buttonDict: The buttons in the set.
     - Parameter currentSelection: The key of the button to select.
    */
    private func selectButtonInSet<T: Hashable>(buttonDict: [T: UIButton], currentSelection: T) {
        for (et, button) in buttonDict {
            let isSelected = et == currentSelection
            selectButton(button, isSelected: isSelected)
        }
    }
    
    /**
     Toggle an entrant type or entrant subtype button's appearance based on its selection state.
     
     - Parameter button: The button to select/deselect.
     - Parameter isSelected: Whether to select the button or not.
    */
    private func selectButton(_ button: UIButton, isSelected: Bool) {
        button.isSelected = isSelected
        if isSelected {
            button.alpha = 1.0
        } else {
            button.alpha = 0.5
        }
    }
}

