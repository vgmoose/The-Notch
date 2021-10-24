import SwiftUI

var displayFrame = NSRect(x: 0, y: 0, width: 10, height: 10)

final class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ notification: Notification){
		NotchWindow().makeKeyAndOrderFront(self)
		NSApp.windows.first?.makeKeyAndOrderFront(self)
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
