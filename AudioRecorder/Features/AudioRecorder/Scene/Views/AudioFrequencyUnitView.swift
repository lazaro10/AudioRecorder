import UIKit

final class AudioFrequencyUnitView: UIView {
    private let dashView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "OwlPink")

        return view
    }()

    private var heightConstraint: NSLayoutConstraint?

    init(size: Float) {
        super.init(frame: .zero)

        setupDashView(size: size)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateSize(size: Float) {
        DispatchQueue.main.async { [weak self] in
            self?.heightConstraint?.constant = CGFloat(size)
            self?.layoutIfNeeded()
        }
    }

    private func setupDashView(size: Float) {
        addSubview(dashView)

        let constraints = [
            dashView.leadingAnchor.constraint(equalTo: leadingAnchor),
            dashView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -3),
            dashView.widthAnchor.constraint(equalToConstant: 1),
            dashView.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]

        heightConstraint = dashView.heightAnchor.constraint(equalToConstant: CGFloat(size))
        heightConstraint?.isActive = true

        NSLayoutConstraint.activate(constraints)
    }
}
