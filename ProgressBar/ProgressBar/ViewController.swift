//
//  ViewController.swift
//  ProgressBar
//
//  Created by Emilia Nedyalkova on 13.08.21.
//

import UIKit

class ViewController: UIViewController {
	private let button: UIButton = {
		let button = UIButton()
		button.backgroundColor = .systemGreen
		button.setTitle("Start Task", for: .normal)
		button.setTitleColor(.white, for: .normal)
		button.layer.cornerRadius = 9
		button.layer.masksToBounds = true
		return button
	}()
	
	private let progressView: UIProgressView = {
		let progressView = UIProgressView(progressViewStyle: .bar)
		progressView.trackTintColor = .gray
		progressView.progressTintColor = .systemBlue
		return progressView
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.addSubview(button)
		button.frame = CGRect(x: 0, y: 0, width: 220, height: 55)
		button.center = view.center
		button.addTarget(self,
										 action: #selector(didTapButton(_:)),
										 for: .touchUpInside)
		
		view.addSubview(progressView)
		progressView.frame = CGRect(x: 10, y: 100, width: view.frame.size.width - 20, height: 20)
		progressView.setProgress(0, animated: false)
	}
	
	@objc private func didTapButton(_ sender: UIButton) {
		for x in 0...100 {
			DispatchQueue.main.asyncAfter(deadline: .now() + (Double(x) * 0.25), execute: {
				self.progressView.setProgress(Float(x) / 100, animated: true)
			})
			
		}
	}
}

