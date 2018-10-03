//
//  StepCalculatorViewController.swift
//  CalculatorProgramatic
//
//  Created by Cody on 10/2/18.
//  Copyright © 2018 Cody Adcock. All rights reserved.
//

import UIKit

class StepCalculatorViewController: UIViewController {
    
    var updates = 0
    
    func updateViews(){
        stepsTextField.text = String(format: "%.0f", SubmissionController.shared.submission.steps)
        milesTextField.text = String(format: "%.2f", SubmissionController.shared.submission.miles)
        kmTextField.text = String(format: "%.2f", SubmissionController.shared.submission.kilometers)
    }
    
    let nf = NumberFormatter()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.01295656338, green: 0.08728515357, blue: 0.153229326, alpha: 1)
        
//        navigationItem.titleView = titleImage
        
        
        stepsTextField.delegate = self
        milesTextField.delegate = self
        kmTextField.delegate = self
        
        //setup functions
        setUpTitleImage()
        setUpSteps()
        setUpMiles()
        setUpKm()
        setUpButton()
        setUpPedometer()
        updatePedometer()
        setUpInstructButton()
    }
    
    //MARK: - Properties
    let titleImage  = UIImageView(image: #imageLiteral(resourceName: "titleGradient"))
    let stepsLabel: UILabel = {
        let label = UILabel()
        label.text = "Steps: "
        label.textColor = #colorLiteral(red: 0.9894761443, green: 1, blue: 0.9896005988, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    let milesLabel: UILabel = {
        let label = UILabel()
        label.text = "Miles: "
        label.textColor = #colorLiteral(red: 0.9894761443, green: 1, blue: 0.9896005988, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    let kmLabel: UILabel = {
        let label = UILabel()
        label.text = "Kilometers: "
        label.textColor = #colorLiteral(red: 0.9894761443, green: 1, blue: 0.9896005988, alpha: 1)
        label.textAlignment = .left
        return label
    }()
    let pedometerLabel: UILabel = {
        let label = UILabel()
        label.text = "Total Steps: \n(Steps Taken from HealthKit)"
        label.textColor = #colorLiteral(red: 0.9894761443, green: 1, blue: 0.9896005988, alpha: 1)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    let stepsTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter a Value", attributes: [.foregroundColor: UIColor.gray])
        textField.textColor = #colorLiteral(red: 0.9894761443, green: 1, blue: 0.9896005988, alpha: 1)
        textField.textAlignment = .right

        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    let milesTextField: UITextField = {
        let textField = UITextField()
        textField.attributedPlaceholder = NSAttributedString(string: "Enter a Value", attributes: [.foregroundColor: UIColor.gray])
        textField.textColor = #colorLiteral(red: 0.9894761443, green: 1, blue: 0.9896005988, alpha: 1)
        textField.textAlignment = .right
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    let kmTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = #colorLiteral(red: 0.9894761443, green: 1, blue: 0.9896005988, alpha: 1)
        textField.textAlignment = .right
        textField.attributedPlaceholder = NSAttributedString(string: "Enter a Value", attributes: [.foregroundColor: UIColor.gray])
        textField.keyboardType = .numbersAndPunctuation
        return textField
    }()
    
    let clearButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "clearRed"), for: .normal)
        return button
    }()
    let pedometerButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "updateOrange"), for: .normal)
        return button
    }()
    let instructButton: UIButton = {
        let button = UIButton()
        button.setTitle("ℹ︎", for: .normal)
        return button
    }()
    
    //MARK: - Setup Functions
    fileprivate func setUpTitleImage(){
        view.addSubview(titleImage)
        titleImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            titleImage.heightAnchor.constraint(equalToConstant: 133),
            titleImage.widthAnchor.constraint(equalToConstant: 488)
            ])
    }
    fileprivate func setUpSteps(){
        let stackView = UIStackView(arrangedSubviews: [stepsLabel, stepsTextField])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: titleImage.bottomAnchor, constant: 0),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 250)
            ])
    }
    fileprivate func setUpMiles(){
        let stackView = UIStackView(arrangedSubviews: [milesLabel, milesTextField])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: stepsLabel.topAnchor, constant: 50),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 250)
            ])
    }
    fileprivate func setUpKm(){
        let stackView = UIStackView(arrangedSubviews: [kmLabel, kmTextField])
        view.addSubview(stackView)
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: milesLabel.topAnchor, constant: 50),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalToConstant: 250)
            ])
    }

    fileprivate func setUpButton(){
        view.addSubview(clearButton)
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.topAnchor.constraint(equalTo: kmLabel.topAnchor, constant: 50),
            clearButton.heightAnchor.constraint(equalToConstant: 133),
            clearButton.widthAnchor.constraint(equalToConstant: 488)
            ])
        setUpClearButtonTappedAction()
    }
    
    fileprivate func setUpPedometer(){
        view.addSubview(pedometerLabel)
        view.addSubview(pedometerButton)
        pedometerLabel.translatesAutoresizingMaskIntoConstraints = false
        pedometerButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pedometerLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pedometerLabel.topAnchor.constraint(equalTo: clearButton.bottomAnchor, constant: 0),
            pedometerLabel.heightAnchor.constraint(equalToConstant: 50),
            pedometerLabel.widthAnchor.constraint(equalToConstant: 360)
            ])
        NSLayoutConstraint.activate([
            pedometerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pedometerButton.topAnchor.constraint(equalTo: pedometerLabel.bottomAnchor, constant: 0),
            pedometerButton.heightAnchor.constraint(equalToConstant: 133),
            pedometerButton.widthAnchor.constraint(equalToConstant: 488)
            ])
     setUpUpdatePedometerButtonTappedAction()
    }
    
    fileprivate func setUpInstructButton(){
        view.addSubview(instructButton)
        instructButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            instructButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            instructButton.topAnchor.constraint(equalTo: pedometerButton.bottomAnchor, constant: 0),
            instructButton.heightAnchor.constraint(equalToConstant: 50),
            instructButton.widthAnchor.constraint(equalToConstant: 360)
            ])
        setUpIntsructionButtonTappedButton()
    }
    
    fileprivate func setUpClearButtonTappedAction(){
        clearButton.addTarget(self, action: #selector(clearViews), for: .touchUpInside)
    }
    fileprivate func setUpUpdatePedometerButtonTappedAction(){
        pedometerButton.addTarget(self, action: #selector(updatePedometer), for: .touchUpInside)
    }
    fileprivate func setUpIntsructionButtonTappedButton(){
        instructButton.addTarget(self, action: #selector(infoAlert), for: .touchUpInside)
    }
    @objc func infoAlert(){
        let alert = UIAlertController(title: "Welcome to iWalked!", message: "iWalked is a simple steps to miles to km calculator!\nTap any of the numbers above to edit them. Hitting return on the keyboard will calculate the conversion for any of the three!\nBy default it's automatically populated by your own steps for the day!\nHit update at anytime to update your step count and or use your own steps!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Sounds Good", style: .default, handler: { (action) in
        }))
        self.present(alert, animated: true)
    }
    
    @objc func updatePedometer(){
        PedometerController.shared.getTodaysSteps { (steps) in
            DispatchQueue.main.async {
                self.pedometerLabel.text = "Total Steps: \(steps)\n(Steps Taken from HealthKit)"
                SubmissionController.shared.fromSteps(steps: steps)
                self.updateViews()
            }
        }

        updates += 1
    }
    @objc func clearViews(){
        SubmissionController.shared.submission.steps = 0
        SubmissionController.shared.submission.miles = 0
        SubmissionController.shared.submission.kilometers = 0
        
        stepsTextField.text = ""
        milesTextField.text = ""
        kmTextField.text = ""
    }
}

extension StepCalculatorViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case stepsTextField:
            guard let text = stepsTextField.text else {return false}
            guard let steps = Double(text) else {return false}
            SubmissionController.shared.fromSteps(steps: steps)
            updateViews()
        case milesTextField:
            guard let text = milesTextField.text else {return false}
            guard let miles = Double(text) else {return false}
            SubmissionController.shared.fromMiles(miles: miles)
            updateViews()
        case kmTextField:
            guard let text = kmTextField.text else {return false}
            guard let km = Double(text) else {return false}
            SubmissionController.shared.fromKilometers(kilometers: km)
            updateViews()
            
        default:
            print("um....?👺👺  ")
            return false
        }
        textField.resignFirstResponder()
        return true
    }
}

