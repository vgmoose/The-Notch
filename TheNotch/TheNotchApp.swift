import SwiftUI
import Cocoa

@NSApplicationMain
class TheNotchApp: NSApplication, NSApplicationDelegate {

	var window: NSWindow?
	static var singleton: TheNotchApp?

	override init() {
		super.init()
		delegate = self
	 }
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func applicationShouldHandleReopen(_ sender: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
		window?.makeKeyAndOrderFront(sender)
		return true
	}
	
	func applicationDidFinishLaunching(_ notification: Notification) {
		let window = NSWindow(
			contentRect: NSRect(x: 0, y: 0, width: 450, height: 200),
			styleMask: [.titled, .closable, .miniaturizable, .resizable],
			backing: .buffered, defer: false
		)
		window.center()
		window.title = "The Notch"
		window.isReleasedWhenClosed = false

		let view = ConfigView().padding(20).frame(width: 450, height: 200)
		window.contentView = NSHostingView(rootView: view)

		window.makeKeyAndOrderFront(true)
		NotchWindow().makeKeyAndOrderFront(self)
		window.makeKeyAndOrderFront(true)

		self.window = window
		TheNotchApp.singleton = self
	}
}
