//
//  SimpleButton.swift
//  AudioRecorder
//
//  Created by Lazaro Lima on 22/04/22.
//

import UIKit

final class SimpleButton: UIButton {
    private let handlerTapped: () -> Void

    init(title: String, handlerTapped: @escaping () -> Void) {
        self.handlerTapped = handlerTapped
        super.init(frame: .zero)
        
        setup(title: title)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(title: String) {
        setTitle(title, for: .normal)
        setTitleColor(.orange, for: .normal)
        setTitleColor(.gray.withAlphaComponent(0.8), for: .highlighted)
        titleLabel?.font = .boldSystemFont(ofSize: 18)
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = .orange
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    @objc private func buttonTapped() {
        handlerTapped()
    }
}

