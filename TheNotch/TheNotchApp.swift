import SwiftUI
import Cocoa

@NSApplicationMain
class TheNotchApp: NSApplication, NSApplicationDelegate {

	override init() {
		super.init()
		delegate = self
//		mainMenu = mainAppMenu
	 }
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func applicationDidFinishLaunching(_ notification: Notification) {
		Swift.print("wasup")
		let window = NSWindow(
			contentRect: NSRect(x: 0, y: 0, width: 450, height: 200),
			styleMask: [.titled, .closable, .miniaturizable, .resizable],
			backing: .buffered, defer: false
		)
		window.center()
		window.title = "The Notch"

		let view = ConfigView().padding(20).frame(width: 450, height: 200)
		window.contentView = NSHostingView(rootView: view)

		window.makeKeyAndOrderFront(true)
		NotchWindow().makeKeyAndOrderFront(self)
		window.makeKeyAndOrderFront(true)

	}
}
