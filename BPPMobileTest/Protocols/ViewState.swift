import Foundation

enum ViewState {
    case idle, isLoading, hasError(Error)
}

protocol HasViewState {
    var viewState: ViewState { get }
}
