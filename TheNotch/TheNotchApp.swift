import SwiftUI

final class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ notification: Notification) {
		NotchWindow().makeKeyAndOrderFront(self)
		NSApp.windows.first?.makeKeyAndOrderFront(true)
	}
}

@main
struct TheNotchApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            ConfigView()
				.padding(10)
        }
	}
}
