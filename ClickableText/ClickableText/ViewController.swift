//
//  ViewController.swift
//  ClickableText
//
//  Created by Emilia Nedyalkova on 30.07.21.
//

import UIKit

class ViewController: UIViewController {
	@IBOutlet weak var textView: UITextView!

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		
		let text = "By creating an account, you agree with our Terms & Conditions and our Privacy Policy."
		let links: [(url: String, part: String)] = [
			(url: "terms://termsAndConditions", part: "Terms & Conditions"),
			(url: "policy://privacyAndPolicy", part: "Privacy Policy")
		]
		
		textView.setInnerLinks(text, links)
		textView.linkTextAttributes = [.foregroundColor: UIColor.blue]
		textView.delegate = self
		textView.dataDetectorTypes = .all
		textView.delaysContentTouches = false
		textView.sizeToFit()
	}
}

extension UITextView {
	func setInnerLinks(_ text: String, _ links: [(url: String, part: String)]) {
		let attributedString = NSMutableAttributedString(string: text)
		let textAsString = attributedString.string as NSString
		for link in links {
			attributedString.addAttribute(.link, value: link.url, range: (textAsString).range(of: link.part))
		}
		
		self.attributedText = attributedString
	}
}

extension ViewController: UITextViewDelegate {
	
	func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
		switch URL.scheme {
		case "terms":
			print("terms")
		case "policy":
			print("policy")
		default:
			print("other")
		}
		return false
	}
}

/*
let attributedString = NSMutableAttributedString(string: "By continueing you agree terms and conditions and the privacy policy")

attributedString.addAttribute(.link, value: "terms://termsofCondition", range: (attributedString.string as NSString).range(of: "terms and conditions"))

attributedString.addAttribute(.link, value: "privacy://privacypolicy", range: (attributedString.string as NSString).range(of: "privacy policy"))

textView.linkTextAttributes = [ NSAttributedString.Key.foregroundColor: UIColor.blue]
textView.attributedText = attributedString
textView.delegate = self
textView.isSelectable = true
textView.isEditable = false
textView.delaysContentTouches = false
textView.isScrollEnabled = false

func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

if URL.scheme == "terms" {
//push view controller 1
return false
} else  if URL.scheme == "privacy"{
// pushViewcontroller 2
return false
}
return true
// let the system open this URL
}
*/
