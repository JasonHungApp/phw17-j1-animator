//
//  ViewController.swift
//  phw17-j1-animator
//
//  Created by jasonhung on 2024/2/3.
//

import UIKit

class ViewController: UIViewController {

    private var clickCount = 0
    private var applauseImageView: UIImageView!
    private var applauseLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)

        setupApplauseImageView()
    }

    private func setupApplauseImageView() {
        let applauseImage = UIImage(systemName: "hands.clap.fill")
        applauseImageView = UIImageView(image: applauseImage)
        applauseImageView.tintColor = .blue
        applauseImageView.contentMode = .scaleAspectFit
        applauseImageView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        applauseImageView.center = view.center
        applauseImageView.alpha = 0.0
        view.addSubview(applauseImageView)

        applauseLabel = UILabel(frame: CGRect(x: applauseImageView.frame.width - 10, y: applauseImageView.frame.midY - 10, width: view.bounds.width, height: 40))
        applauseLabel.textColor = .darkGray
        applauseLabel.textAlignment = .center
        applauseLabel.font = UIFont.systemFont(ofSize: 30)
        view.addSubview(applauseLabel)
        
        updateApplauseLabel()
    }

    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        clickCount += 1
        updateApplauseLabel()

        let newAlpha = CGFloat(clickCount) / 100.0
        UIView.animate(withDuration: 0.5) {
            self.applauseImageView.alpha = newAlpha
        }

        let tapLocation = gesture.location(in: view)
        createButton(at: tapLocation)
    }

    private func createButton(at location: CGPoint) {
        let buttonSize: CGFloat = 50
        let finalPosition = CGPoint(x: view.bounds.midX, y: view.bounds.midY)

        let button = UIButton(type: .system)
        button.frame = CGRect(x: location.x - buttonSize/2, y: location.y - buttonSize/2, width: buttonSize, height: buttonSize)

        // 設置按鈕的圖示為 "hands.clap.fill"
        let clapImage = UIImage(systemName: "hands.clap.fill")
        button.setImage(clapImage, for: .normal)

        let randomBackgroundColor = randomColor()
        button.backgroundColor = randomBackgroundColor

        let randomTextColor = randomColor()
        button.tintColor = randomTextColor

        button.layer.cornerRadius = buttonSize / 2
        button.clipsToBounds = true

        button.addTarget(self, action: #selector(buttonPressed(_:)), for: .touchUpInside)
        view.addSubview(button)

        let animator = UIViewPropertyAnimator(duration: 5, dampingRatio: 0.2) {
            button.center = finalPosition
        }
        animator.startAnimation()

        animator.addCompletion { position in
            if position == .end {
                button.removeFromSuperview()
            }
        }
    }


    @objc func buttonPressed(_ sender: UIButton) {
        // 不需要警告，因為在完成區塊中處理了按鈕的移除
    }

    private func updateApplauseLabel() {
        applauseLabel.text = "\(clickCount)"
    }

    private func randomColor() -> UIColor {
        return UIColor(
            red: CGFloat.random(in: 0.0...1.0),
            green: CGFloat.random(in: 0.0...1.0),
            blue: CGFloat.random(in: 0.0...1.0),
            alpha: 1.0
        )
    }
}

