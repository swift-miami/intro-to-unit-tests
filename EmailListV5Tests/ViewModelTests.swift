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
