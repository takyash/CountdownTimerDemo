//
//  RootViewController.swift
//  CountdownTimerDemo
//
//  Created by Yash Tak on 19/10/23.
//

import UIKit
import TimerControl

class RootViewController: UIViewController {

    var timerControlView: TimerControlView!
    var toggleBtn: UIButton!

    var isTimerRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    func configUI() {

        timerControlView = TimerControlView()
        timerControlView.delegate = self
        timerControlView.configureTimerControl(innerColor: .black, outerColor: .white, counterTextColor: .white, hideInactiveCounter: false, arcWidth: 2, arcDashPattern: .none)
        timerControlView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(timerControlView)

        toggleBtn = UIButton()
        toggleBtn.layer.cornerRadius = 50
        toggleBtn.setTitle("Start", for: .normal)
        toggleBtn.backgroundColor = .systemGreen
        toggleBtn.titleLabel?.textColor = .white
        toggleBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toggleBtn)

        NSLayoutConstraint.activate([
            timerControlView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            timerControlView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            timerControlView.heightAnchor.constraint(equalToConstant: 240),
            timerControlView.widthAnchor.constraint(equalToConstant: 240),

            toggleBtn.widthAnchor.constraint(equalToConstant: 100),
            toggleBtn.heightAnchor.constraint(equalToConstant: 100),
            toggleBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toggleBtn.topAnchor.constraint(equalTo: timerControlView.bottomAnchor, constant: 50)
        ])

        toggleBtn.addTarget(self, action: #selector(didTapToggleBtn), for: .touchDown)
    }

    @objc
    func didTapToggleBtn() {

        if(isTimerRunning) {
            timerControlView.stopTimer()
            toggleBtn.setTitle("Start", for: .normal)
            toggleBtn.backgroundColor = .systemGreen
        } else {
            timerControlView.startTimer(duration: 30)
            toggleBtn.setTitle("Stop", for: .normal)
            toggleBtn.backgroundColor = .systemRed
        }

        isTimerRunning = !isTimerRunning
    }
}

extension RootViewController: TimerControlDelegate {

    func timerCompleted() {

        print("Timer Completed")
    }
    
    func timerTicked() {

        print("Timer Ticked")
    }
}
