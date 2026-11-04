import XCTest
import SwiftUI
@testable import AlertToast

final class AlertToastTests: XCTestCase {
    
    func testInit() {
        let toast = AlertToast(type: .regular, title: "Title", subTitle: "Subtitle")
        XCTAssertEqual(toast.type, .regular)
        XCTAssertEqual(toast.title, "Title")
        XCTAssertEqual(toast.subTitle, "Subtitle")
    }

    func testCustomViewInit() {
        let toast = AlertToast {
            Text("Custom")
        }
        XCTAssertEqual(toast.displayMode, .custom)
        XCTAssertNotNil(toast.customView)
    }

    func testProgressTypeIsEquatableByValue() {
        XCTAssertEqual(AlertToast.AlertType.progress(0.4, .blue), .progress(0.4, .blue))
        XCTAssertNotEqual(AlertToast.AlertType.progress(0.4, .blue), .progress(0.5, .blue))
        XCTAssertNotEqual(AlertToast.AlertType.progress(0.4, .blue), .progress(0.4, .red))
        XCTAssertNotEqual(AlertToast.AlertType.progress(0.4, .blue), .loading)
    }

    func testProgressToastBuildsInEveryDisplayMode() {
        let modes: [AlertToast.DisplayMode] = [.alert, .hud, .banner(.slide), .banner(.pop)]
        for mode in modes {
            let toast = AlertToast(displayMode: mode, type: .progress(0.4, .blue), title: "Uploading…")
            XCTAssertEqual(toast.displayMode, mode)
            XCTAssertEqual(toast.type, .progress(0.4, .blue))
            XCTAssertEqual(toast.title, "Uploading…")
            _ = toast.body
        }
        _ = AlertToast(type: .progress(0.4, .blue), title: "Uploading…").alert
        _ = AlertToast(displayMode: .hud, type: .progress(0.4, .blue), title: "Uploading…").hud
        _ = AlertToast(displayMode: .banner(.pop), type: .progress(0.4, .blue), title: "Uploading…").banner
    }

    func testProgressNeverDismissesItself() {
        XCTAssertTrue(AlertToast.AlertType.progress(0.4, .blue).isInProgress)
        XCTAssertTrue(AlertToast.AlertType.loading.isInProgress)
        XCTAssertFalse(AlertToast.AlertType.regular.isInProgress)
        XCTAssertFalse(AlertToast.AlertType.complete(.green).isInProgress)
        XCTAssertFalse(AlertToast.AlertType.error(.red).isInProgress)
        XCTAssertFalse(AlertToast.AlertType.systemImage("star", .yellow).isInProgress)
        XCTAssertFalse(AlertToast.AlertType.image("logo", .gray).isInProgress)
    }

    func testLoadingToastBuildsWithAndWithoutIndicatorColor() {
        let modes: [AlertToast.DisplayMode] = [.alert, .hud, .banner(.slide)]
        for mode in modes {
            _ = AlertToast(displayMode: mode, type: .loading, title: "Loading…").body
            _ = AlertToast(displayMode: mode, type: .loading, title: "Loading…",
                           style: .style(activityIndicatorColor: .white)).body
        }
    }

    static var allTests = [
        ("testInit", testInit),
        ("testCustomViewInit", testCustomViewInit),
        ("testProgressTypeIsEquatableByValue", testProgressTypeIsEquatableByValue),
        ("testProgressToastBuildsInEveryDisplayMode", testProgressToastBuildsInEveryDisplayMode),
        ("testProgressNeverDismissesItself", testProgressNeverDismissesItself),
        ("testLoadingToastBuildsWithAndWithoutIndicatorColor", testLoadingToastBuildsWithAndWithoutIndicatorColor),
    ]
}
