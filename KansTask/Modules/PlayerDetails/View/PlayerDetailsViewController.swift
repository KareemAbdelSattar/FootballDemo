import UIKit
import FirebaseDynamicLinks

class PlayerDetailsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var detailContainerView: UIView!
    @IBOutlet weak var playerImageView: UIImageView!
    @IBOutlet weak var playerImageViewHeight: NSLayoutConstraint!
    
    // MARK: Properties
    
    private let viewModel: PlayerDetailsViewModelType
    
    // MARK: Init
    
    init(viewModel: PlayerDetailsViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
}

// MARK: - Actions

extension PlayerDetailsViewController {
    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func didTapShareButton(_ sender: Any) {
    }
}

// MARK: - Configurations

extension PlayerDetailsViewController {}

// MARK: - Private Handlers

private extension PlayerDetailsViewController {
    func setupUI() {
        setupScrollView()
        setupCornerRadius()
    }
    
    func setupScrollView() {
        scrollView.delegate = self
    }
    
    func setupCornerRadius() {
        applyCornerToViews(view: detailContainerView, radius: 20, corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        playerImageView.applyShadow()
    }
}

extension PlayerDetailsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let targetHeight = calculateTargetHeight()
        let offset = scrollView.contentOffset.y
        let originalHeight: CGFloat = 362
        let fullRotationAngle: CGFloat = .pi / 2
        
        var heightRatio = min(max(offset / targetHeight, 0), 1)
        let heightDifference = originalHeight - targetHeight
        let tiltAngle = heightRatio * CGFloat.pi / 6
        
        if offset < 0 {
            heightRatio = 0
        }
        
        let newHeight = originalHeight - heightRatio * heightDifference
        let rotationAngle = heightRatio * fullRotationAngle
        
        let rotationTransform = CGAffineTransform(rotationAngle: -rotationAngle)
        let transform3D = create3DTransform(tiltAngle: tiltAngle)
        let transform = CATransform3DConcat(transform3D, CATransform3DMakeAffineTransform(rotationTransform))
        
        applyAnimation(newHeight: newHeight, transform: transform)
    }
    
    
    
    private func calculateTargetHeight() -> CGFloat {
        let screenWidth = scrollView.frame.width
        let targetHeight = screenWidth - 176.0
        
        return targetHeight
    }
    
    private func create3DTransform(tiltAngle: CGFloat) -> CATransform3D {
        var transform3D = CATransform3DIdentity
        transform3D.m34 = -1.0 / 500
        transform3D = CATransform3DRotate(transform3D, tiltAngle, 0, 3, 0)
        
        return transform3D
    }
    
    private func applyAnimation(newHeight: CGFloat, transform: CATransform3D) {
        UIView.animate(withDuration: 0.3) {
            self.playerImageViewHeight.constant = newHeight
            self.playerImageView.layer.transform = transform
            
            self.view.layoutIfNeeded()
        }
    }
}
