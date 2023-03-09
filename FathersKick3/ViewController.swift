//
//  ViewController.swift
//  FathersKick3
//
//  Created by Андрей Абакумов on 07.03.2023.
//

import UIKit

class ViewController: UIViewController {
    
    private let squareView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let animator = UIViewPropertyAnimator(duration:0.3, curve: .linear)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstraints()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        
        view.addSubview(squareView)
        view.addSubview(slider)
        slider.addTarget(self, action: #selector(sliderChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderDidEndDragging), for: .touchUpInside)
        
        animator.addAnimations {
            self.squareView.frame = self.squareView.frame.offsetBy(
                dx: self.view.frame.width -
                self.squareView.frame.width * 1.5 -
                self.view.layoutMargins.right,
                dy: 0
            )
            self.squareView.transform = CGAffineTransform(rotationAngle: (.pi) / 2).scaledBy(x: 1.5, y: 1.5)
        }
        animator.pausesOnCompletion = true
    }
    
    @objc func sliderChanged() {
        animator.fractionComplete = CGFloat(self.slider.value)
    }
    
    @objc func sliderDidEndDragging() {
        if slider.value != 1 {
            UIView.animate(withDuration: 0.2, delay: 0) {
                self.animator.startAnimation()
                self.slider.setValue(1, animated: true)
            }
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            squareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            squareView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            squareView.widthAnchor.constraint(equalToConstant: 55),
            squareView.heightAnchor.constraint(equalTo: squareView.widthAnchor),
            
            slider.topAnchor.constraint(equalTo: squareView.bottomAnchor, constant: 50),
            slider.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
