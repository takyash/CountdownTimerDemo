//
//  RootViewController.swift
//  CountdownTimerDemo
//
//  Created by Yash Tak on 19/10/23.
//

import UIKit
import TimerControl

class RootViewController: UIViewController {

    var countdownTimer: SRCountdownTimer!
    var toggleBtn: UIButton!

    var isTimerRunning = false

    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        countdownTimer.start(beginingValue: 30)
        countdownTimer.pause()
    }

    func configUI() {

        countdownTimer = SRCountdownTimer()
        countdownTimer.layer.borderColor = UIColor.systemRed.cgColor
        countdownTimer.layer.borderWidth = 1.0
        countdownTimer.delegate = self
        countdownTimer.moveClockWise = false
        countdownTimer.trailLineColor = .systemGreen
        countdownTimer.isLabelHidden = false
        countdownTimer.lineWidth = 5.0
        countdownTimer.useMinutesAndSecondsRepresentation = false
        countdownTimer.labelTextColor = .systemGreen
        countdownTimer.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(countdownTimer)

        toggleBtn = UIButton()
        toggleBtn.layer.cornerRadius = 50
        toggleBtn.setTitle("Start", for: .normal)
        toggleBtn.backgroundColor = .systemGreen
        toggleBtn.titleLabel?.textColor = .white
        toggleBtn.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(toggleBtn)

        NSLayoutConstraint.activate([
            countdownTimer.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            countdownTimer.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            countdownTimer.heightAnchor.constraint(equalToConstant: 240),
            countdownTimer.widthAnchor.constraint(equalToConstant: 240),

            toggleBtn.widthAnchor.constraint(equalToConstant: 100),
            toggleBtn.heightAnchor.constraint(equalToConstant: 100),
            toggleBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            toggleBtn.topAnchor.constraint(equalTo: countdownTimer.bottomAnchor, constant: 50)
        ])

        toggleBtn.addTarget(self, action: #selector(didTapToggleBtn), for: .touchDown)
    }

    @objc
    func didTapToggleBtn() {

        if(isTimerRunning) {
            countdownTimer.pause()
            toggleBtn.setTitle("Start", for: .normal)
            toggleBtn.backgroundColor = .systemGreen
        } else {
            countdownTimer.resume()
            toggleBtn.setTitle("Stop", for: .normal)
            toggleBtn.backgroundColor = .systemRed
        }

        isTimerRunning = !isTimerRunning
    }
}

extension RootViewController: SRCountdownTimerDelegate {

    func timerDidEnd(sender: SRCountdownTimer, elapsedTime: TimeInterval) {
        
        print("Elapsed Time -> \(elapsedTime)")
        sender.start(beginingValue: 30)
    }

    func timerDidUpdateCounterValue(sender: SRCountdownTimer, newValue: Int) {

        print("SRCountdownTimerDelegate -> timerDidUpdateCounterValue")
        print("newValue -> \(newValue)")
        if(newValue <= 5) {
            sender.trailLineColor = .systemRed
        } else {
            sender.trailLineColor = .systemGreen
        }
    }
}
