import Foundation
import Combine

// MARK: TeamViewModel

class TeamViewModel {
    private let teamFireStore: TeamFireStore
    var players: PassthroughSubject<Team, Never> = PassthroughSubject()
    
    init(teamFireStore: TeamFireStore) {
        self.teamFireStore = teamFireStore
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

private extension TeamViewModel {}
