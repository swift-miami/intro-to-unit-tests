protocol ViewModelInput {
    func selectedEmail(at index: Int)
    func filter(_ queryString: String)
}

protocol ViewModelOutput {
    var emails: [Email] { get }
}

protocol ViewModelObserver {
    func addedEmail(at index: Int)
    func updatedEmail(at index: Int)
    func filterUpdated()
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

    var emails: [Email] {
        if filteredQuery.isEmpty {
            return allEmails
        } else {
            return filteredEmails
        }
    }
    
    fileprivate var filteredEmails = [Email]()

    fileprivate var allEmails: [Email]
    
    fileprivate var filteredQuery = ""

    init(emails: [Email] = []) {
        self.allEmails = emails
    }

    // Inputs
    func selectedEmail(at index: Int) {
        guard emails[index].isRead == true else {
            allEmails[index].isRead = true
            observer?.updatedEmail(at: index)
            return
        }
    }
    
    func filter(_ queryString: String) {
        filteredEmails = allEmails.filter({$0.subject.contains(queryString)})
        
        filteredQuery = queryString
        
        observer?.filterUpdated()
    }
}

