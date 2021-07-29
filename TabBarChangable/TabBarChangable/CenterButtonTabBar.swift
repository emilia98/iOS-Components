//
//  CenterButtonTabBar.swift
//  TabBarChangable
//
//  Created by Emilia Nedyalkova on 28.07.21.
//

import UIKit

extension CGFloat {
    func inRadians() -> CGFloat {
        (self * .pi) / 180
    }
}

class CenterButtonTabBar: UITabBar {
    private(set) var centerButton = UIButton(type: .system)
    weak var tabBarController: CustomTabBarController?
    private let image = UIImage(named: "plus-icon")?.withRenderingMode(.alwaysTemplate)
    private var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // this sets the tab bar color and removes the line from its top so the border of the button blends in
        let appearance = standardAppearance.copy()
        appearance.backgroundColor = .systemGroupedBackground
        appearance.shadowColor = .clear
        standardAppearance = appearance
        setupCenterButton()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.isHidden {
            return super.hitTest(point, with: event)
        }
        
        let from = point
        let to = centerButton.center
        
        return sqrt((from.x - to.x) * (from.x - to.x) + (from.y - to.y) * (from.y - to.y)) <= 52 ? centerButton : super.hitTest(point, with: event)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        centerButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: -2)
        imageView.center = centerButton.center
    }
    
    private func setupCenterButton() {
        let side = CGFloat(80)
        centerButton.frame.size = CGSize(width: side, height: side)
        centerButton.center = CGPoint(x: UIScreen.main.bounds.width / 2, y: 10)
        // centerButton.tintColor = .white
        centerButton.backgroundColor = .blue
        centerButton.layer.masksToBounds = true
        centerButton.layer.cornerRadius = side / 2
        centerButton.layer.borderColor = UIColor.white.cgColor
        //centerButton.layer.borderWidth = 10
        centerButton.clipsToBounds = true
        
        
        imageView = UIImageView(image: image)
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        centerButton.addTarget(self, action: #selector(openScanning), for: .touchUpInside)
        addSubview(centerButton)
        centerButton.addSubview(imageView)
        imageView.frame.size = CGSize(width: side / 2, height: side / 2)
        self.insertSubview(imageView, aboveSubview: centerButton)
    }
    
    @objc private func openScanning() {
        if let tbc = tabBarController {
            if tbc.isClosed {
                tbc.instantiateSecondGroup()
            } else {
                tbc.instantiateFirstGroup()
            }
        }
        switchVCs()
    }
    
    private func switchVCs() {
        let isClosed = tabBarController!.isClosed
        UIView.animate(withDuration: 0.5) { [self] in
            imageView.tintColor = isClosed ? .blue : .white
            centerButton.backgroundColor = isClosed ? .white : .blue
            imageView.transform = isClosed ? CGAffineTransform(rotationAngle: CGFloat(45).inRadians()) : .identity
        } completion: { [self] isFinished in
            tabBarController!.isClosed.toggle()
        }
    }
}
