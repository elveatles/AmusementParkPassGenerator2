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
            enableFields()
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
            
            // Add subtype buttons in a specific order since dictionary does not maintain order
            if let order = entrantSubtypeOrder[selectedEntrantType] {
                for subtype in order {
                    if let button = currentEntrantSubtypeButtons[subtype] {
                        entrantSubtypeStackView.addArrangedSubview(button)
                    }
                }
            }
        }
    }
    
    private let textFieldBorderColorEnabled = UIColor(white: 160.0/255.0, alpha: 1.0).cgColor
    private let textFieldBorderColorDisabled = UIColor(white: 190.0/255.0, alpha: 1.0).cgColor
    private var entrantTypeButtons = [EntrantType: UIButton]()
    private var entrantSubtypeButtons: [EntrantType: [EntrantSubtype: UIButton]] = [
        .guest: [:], .employee: [:], .manager: [:], .vendor: [:]
    ]
    private let entrantSubtypeOrder: [EntrantType: [EntrantSubtype]] = [
        .guest: [.childGuest, .classicGuest, .seniorGuest, .seasonPassGuest],
        .employee: [.hourlyEmployeeFoodServices, .hourlyEmployeeRideServices, .hourlyEmployeeMaintenance, .contractEmployee],
        .manager: [.manager],
        .vendor: [.vendor]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        styleTextFields()
        
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
        
        enableFields()
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
    
    /// Style all text fields
    func styleTextFields() {
        styleTextField(dateOfBirthTextField)
        styleTextField(ssnTextField)
        styleTextField(projectNumberTextField)
        styleTextField(firstNameTextField)
        styleTextField(lastNameTextField)
        styleTextField(companyTextField)
        styleTextField(streetAddressTextField)
        styleTextField(cityTextField)
        styleTextField(stateTextField)
        styleTextField(zipCodeTextField)
    }
    
    /**
     Style a text field.
     
     - Parameter textField: The text field to style.
    */
    private func styleTextField(_ textField: UITextField) {
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 4
    }
    
    /**
     Enable/disable fields depending on which entrant subtype is selected.
    */
    private func enableFields() {
        var required = Set<EntrantInfo>()
        if let subtype = selectedEntrantSubtype {
            required = EntrantSubtype.requiredEntrantInfo(for: subtype)
        }
        
        let dateOfBirthEnabled = required.contains(.dateOfBirth)
        let ssnEnabled = required.contains(.ssn)
        let projectNumberEnabled = required.contains(.projectNumber)
        let firstNameEnabled = required.contains(.firstName)
        let lastNameEnabled = required.contains(.lastName)
        let companyEnabled = required.contains(.company)
        let streetAddressEnabled = required.contains(.streetAddress)
        let cityEnabled = required.contains(.city)
        let stateEnabled = required.contains(.state)
        let zipCodeEnabled = required.contains(.zipCode)
        
        enableField(label: dateOfBirthLabel, field: dateOfBirthTextField, isEnabled: dateOfBirthEnabled)
        enableField(label: ssnLabel, field: ssnTextField, isEnabled: ssnEnabled)
        enableField(label: projectNumberLabel, field: projectNumberTextField, isEnabled: projectNumberEnabled)
        enableField(label: firstNameLabel, field: firstNameTextField, isEnabled: firstNameEnabled)
        enableField(label: lastNameLabel, field: lastNameTextField, isEnabled: lastNameEnabled)
        enableField(label: companyLabel, field: companyTextField, isEnabled: companyEnabled)
        enableField(label: streetAddressLabel, field: streetAddressTextField, isEnabled: streetAddressEnabled)
        enableField(label: cityLabel, field: cityTextField, isEnabled: cityEnabled)
        enableField(label: stateLabel, field: stateTextField, isEnabled: stateEnabled)
        enableField(label: zipCodeLabel, field: zipCodeTextField, isEnabled: zipCodeEnabled)
    }
    
    /**
     Enable/disable a field.
     
     - Parameter label: The label for the field to enable/disable.
     - Parameter field: The text field to enable/disable.
     - Parameter isEnabled: Whether the field is enabled.
    */
    private func enableField(label: UILabel, field: UITextField, isEnabled: Bool) {
        label.isEnabled = isEnabled
        field.isEnabled = isEnabled
        if isEnabled {
            field.textColor = .black
            field.backgroundColor = .white
            field.layer.borderColor = textFieldBorderColorEnabled
        } else {
            field.textColor = .lightGray
            field.backgroundColor = .clear
            field.layer.borderColor = textFieldBorderColorDisabled
        }
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

