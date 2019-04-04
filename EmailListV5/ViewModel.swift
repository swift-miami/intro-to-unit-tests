protocol ViewModelInput {
    func selectedEmail(at index: Int)
}

protocol ViewModelOutput {
    var emails: [Email] { get }
}

protocol ViewModelObserver {
    func addedEmail(at index: Int)
    func updatedEmail(at index: Int)
}

protocol ViewModelType: ViewModelInput, ViewModelOutput {
    var input: ViewModelInput { get }
    var output: ViewModelOutput { get }
    var observer: ViewModelObserver? { get set }
}

class ViewModel: ViewModelType {
    var input: ViewModelInput { return self }
    var output: ViewModelOutput { return self }
    var observer: ViewModelObserver? // delegate

    var emails: [Email]

    init(emails: [Email] = []) {
        self.emails = emails
    }

    // Inputs
    func selectedEmail(at index: Int) {
        guard emails[index].isRead == true else {
            emails[index].isRead = true
            observer?.updatedEmail(at: index)
            return
        }
    }

}

