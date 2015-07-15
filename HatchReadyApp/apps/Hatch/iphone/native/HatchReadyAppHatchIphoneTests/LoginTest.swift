/*
Licensed Materials - Property of IBM
© Copyright IBM Corporation 2015. All Rights Reserved.
*/

import UIKit
import XCTest
import Hatch

class LoginTest: XCTestCase {
    
    var loginManager: LoginDataManager!
    var dashboardDataManager: DashboardDataManager!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        loginManager = LoginDataManager.sharedInstance
        dashboardDataManager = DashboardDataManager.sharedInstance
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testValidLogin() {
        
        let username = "u1"
        let password = "p1"
        
        // Ensure user data is empty.
        // Fire authentication.
        //loginManager.submitAuthentication(username, password: password)
        // Check that login succeeds by seeing that user data has loaded.
        
    }
    
    func testInvalidLogin() {
        
        let username = "fakeuser"
        let password = "fakepassword"
        
        // Ensure user data is empty.
        // Fire authentication.
        //loginManager.submitAuthentication(username, password: password)
        // Check that login fails by seeing that user data is still empty.
        
    }
    
    func testChallengeAuth() {
        
        // Ensure user is not authenticated and login is nil.
        //XCTAssertNil(loginManager.challengeHandler.loginViewController, "loginViewController is not nil and has already be instantiated.")
        // Attempt to access protected data.
        //dashboardDataManager.getDashboardDataTest()
        // Check that challenge handler fires.
        //sleep(1)
        //XCTAssertNotNil(loginManager.challengeHandler.loginViewController, "loginVC is still nil and has not been successfully instantiated.")
        
    }

}
