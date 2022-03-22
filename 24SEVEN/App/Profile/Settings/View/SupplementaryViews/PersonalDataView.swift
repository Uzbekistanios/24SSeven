//
//  PersonalDataView.swift
//  24SEVEN
//
//  Created by Islom on 19/02/21.
//

import UIKit

class PersonalDataView : IBView {
    
    let titleLabel = UILabel.makeLabel(string: "personal_info".localized(using: "Localizable"), size: .l, weight: .black, alignment: .center)
    
    let nameTextField = FillTextField(placeholder: "Имя*")
    
    let surNameTextField = FillTextField(placeholder: "Фамилия*")
    
    let phoneTextField = FillTextField(placeholder: "+998 99 999 99 99", type: .phone)
    
    let dobTextField = FillTextField(placeholder: "dob".localized(using: "Localizable"))
    
    let dobButton = UIButton.makeButton(imageName: Constants.dateOfBirth)
    
    let datePicker = UIDatePicker()
    
    override init() {
        super.init()
        
        style()
        layout()
        setup()
        showDatePicker()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup() {
        phoneTextField.isUserInteractionEnabled = false
    }
    
    func showDatePicker(){
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) { datePicker.preferredDatePickerStyle = .wheels }
        
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Выбирать", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Отмена", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        
        dobTextField.inputAccessoryView = toolbar
        dobTextField.inputView = datePicker
    }
    
    @objc func donedatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        dobTextField.text = formatter.string(from: datePicker.date)
        self.dobTextField.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.dobTextField.endEditing(true)
    }
    
    private func style() {
        phoneTextField.backgroundColor = UIColor(hex: "#DADADAFF") //disabled gray
        phoneTextField.font = UIFont.appFont(size: .m, weight: .medium)
        dobTextField.font = UIFont.appFont(size: .m, weight: .medium)
        nameTextField.font = UIFont.appFont(size: .m, weight: .medium)
        surNameTextField.font = UIFont.appFont(size: .m, weight: .medium)
        dobButton.tintColor = UIColor.defaultOrange
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(nameTextField)
        addSubview(surNameTextField)
        addSubview(phoneTextField)
        addSubview(dobTextField)
        addSubview(dobButton)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            nameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 21),
            nameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            nameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            nameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            surNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 12),
            surNameTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            surNameTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            surNameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            phoneTextField.topAnchor.constraint(equalTo: surNameTextField.bottomAnchor, constant: 12),
            phoneTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            phoneTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            phoneTextField.heightAnchor.constraint(equalToConstant: 48),
            
            dobTextField.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 12),
            dobTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            dobTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            dobTextField.heightAnchor.constraint(equalToConstant: 48),
            dobTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            
            dobButton.trailingAnchor.constraint(equalTo: dobTextField.trailingAnchor, constant: -15),
            dobButton.centerYAnchor.constraint(equalTo: dobTextField.centerYAnchor)
        ])
    }
}
