import XCTest
@testable import EmailListV5

fileprivate class ViewModelTests: XCTestCase {
    var observer: Observer!

    override func setUp() {
        observer = Observer()
    }
}

// MARK: - Email Selection
extension ViewModelTests {
    func testSelectingAnUnreadEmailMarksItAsRead() {
        // setup
        let vm = ViewModel(emails: [
            Email(subject: "Subject", isRead: false)
            ]
        )

        // act
        vm.input.selectedEmail(at: 0)

        // assert
        XCTAssertTrue(vm.emails[0].isRead)
    }

    func testSelectingAReadEmailDoesNotMarkItAsUnread() {
        // setup
        let vm = ViewModel(emails: [
            Email(subject: "Subject", isRead: true)
            ]
        )

        // act
        vm.input.selectedEmail(at: 0)

        // assert
        XCTAssertTrue(vm.emails[0].isRead)
    }

    func testMarkingAnEmailAsReadCallsTheObserver() {
        // setup
        let vm = ViewModel(emails: [
            Email(subject: "Subject", isRead: false)
            ]
        )

        // act
        vm.observer = observer
        vm.input.selectedEmail(at: 0)

        // assert
        wait(for: [observer.updatedEmailExpectation], timeout: 0.1)
    }
}

// MARK: - Deleting Emails
extension ViewModelTests {

    func testDeletingAnEmailDecrementsTheCount() {
        // setup
        let vm = ViewModel(emails: [
            Email(subject: "Subject", isRead: false)
            ]
        )

        // act
        vm.input.deleteEmail(at: 0)

        // assert
        XCTAssertEqual(vm.output.emails.count, 0)
    }

    func testDeletingAnEmailCallsTheObserver() {
        // setup
        let vm = ViewModel(emails: [
            Email(subject: "Subject", isRead: false)
            ]
        )
        vm.observer = observer

        // act
        vm.input.deleteEmail(at: 0)

        // assert
        wait(for: [observer.deletedEmailExpectation], timeout: 0.2)
    }

}

// MARK: - Filtering Emails
extension ViewModelTests {

    func testFilteringEmailsReturnsTheCorrectResults() {
        // setup
        let vm = ViewModel(emails: [
            Email(subject: "Welcome", isRead: false),
            Email(subject: "to", isRead: false),
            Email(subject: "Swift", isRead: false),
            Email(subject: "Miami", isRead: false)
            ]
        )

        // act
        vm.input.filter("Swift")

        // assert
        XCTAssertEqual(vm.output.emails.count, 1)
        let email = vm.output.emails[0]
        XCTAssertEqual(email.subject, "Swift")
    }

    func testFilteringCallsTheObserver() {
        // setup
        let vm = ViewModel(emails: [])
        vm.observer = observer

        // act
        vm.input.filter("Hello")

        // assert
        wait(for: [observer.filterUpdatedExpectation], timeout: 0.1)
    }

}

// MARK: - Deleting Filtered Emails
extension ViewModelTests {

    func testDeletingAnEmailWhileFilteredDeletesTheCorrectEmail() {
        // setup
        let vm = ViewModel(emails: [
            Email(subject: "Welcome", isRead: false),
            Email(subject: "to", isRead: false),
            Email(subject: "Swift", isRead: false),
            Email(subject: "Miami", isRead: false)
            ]
        )

        // act
        vm.input.filter("Swift")
        vm.input.deleteEmail(at: 0)

        // assert
        XCTAssertEqual(vm.output.emails.count, 0)
    }

}


// MARK: - ViewModelObserver
fileprivate class Observer: ViewModelObserver {

    let addedEmailExpectation: XCTestExpectation = XCTestExpectation(description: "Should call vm.observer.addedEmail")
    let updatedEmailExpectation: XCTestExpectation = XCTestExpectation(description: "Should call vm.observer.updatedEmail")
    let deletedEmailExpectation: XCTestExpectation = XCTestExpectation(description: "Should call vm.observer.deletedEmail")
    let filterUpdatedExpectation: XCTestExpectation = XCTestExpectation(description: "Should call vm.observer.filterUpdated")

    func addedEmail(at index: Int) { addedEmailExpectation.fulfill() }
    func updatedEmail(at index: Int) { updatedEmailExpectation.fulfill() }
    func deletedEmail(at index: Int) { deletedEmailExpectation.fulfill() }
    func filterUpdated() { filterUpdatedExpectation.fulfill() }

}
