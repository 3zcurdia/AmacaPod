import XCTest
import Amaca

class QueryAuthenticationTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testApply() {
        let url = URL(string: "https://example.com/")!
        let auth = QueryAuthentication(token: "secret123")
        var req = URLRequest(url: url)
        req = auth.applyTo(request: req)
        XCTAssertEqual(req.url!.absoluteString, "https://example.com/?token=secret123")
    }
}
