import Foundation
import Combine

/// Team Input & Output
///
typealias TeamViewModelType = TeamViewModelInput & TeamViewModelOutput

/// Team ViewModel Input
///
protocol TeamViewModelInput {}

/// Team ViewModel Output
///
protocol TeamViewModelOutput {
    var players: PassthroughSubject<Team, Never> { get }
    func viewDidLoad()
}
