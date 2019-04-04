import XCTest
@testable import EmailListV5

fileprivate class ViewModelTests: XCTestCase {

    var observer: Observer!

    override func setUp() {
        observer = Observer()
    }

    func testSelectingAnUnreadEmailMarksItAsRead() {
        let vm = ViewModel(emails: [
            Email(subject: "Subject", isRead: false)
            ]
        )

        vm.input.selectedEmail(at: 0)

        XCTAssertTrue(vm.emails[0].isRead)
    }

    func testSelectingAReadEmailDoesNotMarkItAsUnread() {
        let vm = ViewModel(emails: [
            Email(subject: "Subject", isRead: true)
            ]
        )

        vm.input.selectedEmail(at: 0)

        XCTAssertTrue(vm.emails[0].isRead)
    }

    func testMarkingAnEmailAsReadCallsTheObserver() {
        let vm = ViewModel(emails: [
            Email(subject: "Subject", isRead: false)
            ]
        )

        vm.observer = observer
        vm.input.selectedEmail(at: 0)

        wait(for: [observer.updatedEmailExpectation], timeout: 0.1)
    }

}

fileprivate class Observer: ViewModelObserver {
    let addedEmailExpectation: XCTestExpectation = XCTestExpectation(description: "Should call vm.observer.addedEmail")
    let updatedEmailExpectation: XCTestExpectation = XCTestExpectation(description: "Should call vm.observer.updatedEmail")

    func addedEmail(at index: Int) { addedEmailExpectation.fulfill() }

    func updatedEmail(at index: Int) { updatedEmailExpectation.fulfill() }

}
