import Foundation
import Combine

protocol TeamViewModelCoordinator: AnyObject {
    func didSelectPlayer()
}

// MARK: TeamViewModel

class TeamViewModel {
    private let teamFireStore: TeamFireStore
    private let coordinator: TeamViewModelCoordinator
    private var subscription = Set<AnyCancellable>()
    
    var players: PassthroughSubject<Team, Never> = PassthroughSubject()
    var onTapPlayer: PassthroughSubject<Void, Never> = PassthroughSubject()
    
    init(teamFireStore: TeamFireStore, coordinator: TeamViewModelCoordinator) {
        self.teamFireStore = teamFireStore
        self.coordinator = coordinator
        
        binding()
    }
    
    func viewDidLoad() {
        performTeamPlayer()
    }
    
    func performTeamPlayer() {
        teamFireStore.getTeamPlayers { result in
            switch result {
            case .success(let success):
                self.players.send(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

// MARK: TeamViewModel

extension TeamViewModel: TeamViewModelInput {}

// MARK: TeamViewModelOutput

extension TeamViewModel: TeamViewModelOutput {}

// MARK: Private Handlers

private extension TeamViewModel {
    func binding() {
        onTapPlayer.sink { [weak self] _ in
            self?.coordinator.didSelectPlayer()
        }.store(in: &subscription)
    }
}
