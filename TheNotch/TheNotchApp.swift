import SwiftUI

var displayFrame = NSRect(x: 0, y: 0, width: 10, height: 10)

final class AppDelegate: NSObject, NSApplicationDelegate {
	func applicationDidFinishLaunching(_ notification: Notification) {
		if let window = NSApplication.shared.windows.first {
			window.titleVisibility = .hidden
			window.showsToolbarButton = false
			window.isOpaque = false
			window.backgroundColor = NSColor.clear
			window.level = .screenSaver
			window.hasShadow = false
						
			window.standardWindowButton(.zoomButton)?.isHidden = true
			window.standardWindowButton(.miniaturizeButton)?.isHidden = true
			window.standardWindowButton(.closeButton)?.isHidden = true

			window.ignoresMouseEvents = true
//			window.isMovableByWindowBackground = true
			
			Swift.print(window.frame)
//			window.constrainFrameRect =
			let frame = NSRect(x: -1000, y: -1000, width: 100, height: 100)
			var constraints = window.constrainFrameRect(frame, to: window.screen)
			Swift.print(constraints)
			constraints = window.constrainFrameRect(window.frame, to: window.screen)
			Swift.print(constraints)
	
			if let screen = window.screen {
				displayFrame = screen.frame
//				Swift.print(displayFrame)
			}

		}
	}
}

@main
struct TheNotchApp: App {
	@NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            NotchView()
				.frame(width: 130, height: 30, alignment: .topTrailing)
        }
		.windowStyle(HiddenTitleBarWindowStyle())
	}
}
