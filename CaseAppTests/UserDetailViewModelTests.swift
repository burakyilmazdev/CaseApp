//
//  UserDetailViewModelTests.swift
//  CaseAppTests
//
//  Created by Unica Fintech on 7.03.2025.
//

import XCTest
@testable import CaseApp


final class UserDetailViewModelTests: XCTestCase {
    
    var viewModel: UserListViewModel!

    override func setUp() {
        super.setUp()
        viewModel = UserListViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel = nil
    }
    
    // MARK: - Test getUserColor()
    func test_getUserColor_withValidIndex() {
        let color = viewModel.getUserColor(indexPath: IndexPath(row: 2, section: 0))
        XCTAssertEqual(color, viewModel.userColors[2])
    }
    
    // MARK: - Test getInitials()
    func test_getInitials_withFullName() {
        let initials = viewModel.getInitials(name: "John Doe")
        XCTAssertEqual(initials, "JD")
    }
    
    func test_getInitials_withSingleName() {
        let initials = viewModel.getInitials(name: "Alice")
        XCTAssertEqual(initials, "AL")
    }
    
    func test_getInitials_withEmptyString() {
        let initials = viewModel.getInitials(name: "")
        XCTAssertEqual(initials, "XX")
    }
    
    // MARK: - Test distributeUserList()
    class MockUserListDelegate: UserListProtocol {
        var receivedUsers: [User]?
        var receivedError: String?
        
        func userListDidCome(userList: [User]) {
            receivedUsers = userList
        }
        
        func userListErrorDidOccur(error: String) {
            receivedError = error
        }
    }
    
    func test_distributeUserList() {
        let mockDelegate = MockUserListDelegate()
        viewModel.subscribeUserList(userListProtocol: mockDelegate)
        
        let mockUsers = [
            User(id: 1, name: "Burak Yılmaz", username: "Buraky", email: "burak@gmail.com", address: Address(street: "Test", suite: "Test", city: "İstanbul", zipcode: "34758", geo: Geo(lat: "100", lng: "100")), phone: "05523632716", website: "www.burak.com", company: Company(name: "Test", catchPhrase: "Test", bs: "Test")),
            User(id: 2, name: "Burak Yılmaz 2 ", username: "Buraky2", email: "burak2@gmail.com", address: Address(street: "Test", suite: "Test", city: "İstanbul", zipcode: "34758", geo: Geo(lat: "100", lng: "100")), phone: "05523632717", website: "www.burak2.com", company: Company(name: "Test", catchPhrase: "Test", bs: "Test"))
        ]
        
        viewModel.distributeUserList(userList: mockUsers)
        
        XCTAssertEqual(mockDelegate.receivedUsers?.count, 2)
        XCTAssertEqual(mockDelegate.receivedUsers?.first?.name, "Burak Yılmaz")
    }
    
    func test_distributeError() {
        let mockDelegate = MockUserListDelegate()
        viewModel.subscribeUserList(userListProtocol: mockDelegate)
        
        let errorMessage = "Network Error"
        viewModel.distributeError(errorMessage: errorMessage)
        
        XCTAssertEqual(mockDelegate.receivedError, errorMessage)
    }


}
