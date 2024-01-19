import Foundation
import Combine

/// Team Input & Output
///
typealias TeamViewModelType = TeamViewModelInput & TeamViewModelOutput

/// Team ViewModel Input
///
protocol TeamViewModelInput {
    var onTapPlayer: PassthroughSubject<Void, Never> { get }
}

/// Team ViewModel Output
///
protocol TeamViewModelOutput {
    var players: PassthroughSubject<Team, Never> { get }
    func viewDidLoad()
}
