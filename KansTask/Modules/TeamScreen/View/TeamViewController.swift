import UIKit
import Combine

class TeamViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var lineupContainerView: UIView!
    @IBOutlet weak var stadiumContainerView: UIView!
    @IBOutlet weak var shareContainerView: UIView!
    @IBOutlet var playersImageView: [UIImageView]!
    
    // MARK: Properties

    private let viewModel: TeamViewModelType
    private var subscription = Set<AnyCancellable>()
    
    // MARK: Init

    init(viewModel: TeamViewModelType) {
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
        viewModel.viewDidLoad()
        bindVM()
    }
}

// MARK: - Actions

extension TeamViewController {
    @objc func navigateToPlayerDetails() {
        viewModel.onTapPlayer.send()
    }
}

// MARK: - Configurations

extension TeamViewController {
    func bindVM() {
        viewModel.players.sink { players in
            print(players)
        }.store(in: &subscription)
    }
}

// MARK: - Private Handlers

private extension TeamViewController {
    func setupUI() {
        applyCornerRadiusStyle()
        setupGesture()
    }
    
    func applyCornerRadiusStyle() {
        applyCornerToViews(view: stadiumContainerView, radius: 20, corners: [.layerMaxXMinYCorner, .layerMinXMinYCorner])
        applyCornerToViews(view: lineupContainerView, radius: 28, corners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        applyCornerToViews(view: shareContainerView, radius: 28, corners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
    }
    
    func setupGesture() {
        playersImageView.forEach{
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(navigateToPlayerDetails))
            $0.isUserInteractionEnabled = true
            $0.addGestureRecognizer(tapGesture)
        }
    }
}
