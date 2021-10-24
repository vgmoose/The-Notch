import AppKit
import SwiftUI

class NotchWindow : NSWindow
{
	static var defaultNotchHeight = 40
	static var defaultNotchWidth = 160

	static var notchHeight = defaultNotchHeight
	static var notchWidth = defaultNotchWidth
	
	static var singleton: NotchWindow? = nil
	static var allowMoving = false
	static var showOnAllSpaces = true
	
	override init(contentRect: NSRect, styleMask style: NSWindow.StyleMask, backing backingStoreType: NSWindow.BackingStoreType, defer flag: Bool)
	{
		super.init(contentRect: contentRect, styleMask: style, backing: backingStoreType, defer: flag)

		let window = self
		NotchWindow.singleton = window

		window.showsToolbarButton = false
		window.isOpaque = false
		window.hasShadow = false

		window.backgroundColor = NSColor.clear
		
		window.titleVisibility = .hidden
		window.level = .screenSaver
		window.styleMask = .borderless
					
		window.standardWindowButton(.zoomButton)?.isHidden = true
		window.standardWindowButton(.miniaturizeButton)?.isHidden = true
		window.standardWindowButton(.closeButton)?.isHidden = true
	
		refreshNotch()
	}
	
	func refreshNotch() {
		
		self.ignoresMouseEvents = !NotchWindow.allowMoving
		self.isMovableByWindowBackground = NotchWindow.allowMoving
		
		self.collectionBehavior = NotchWindow.allowMoving ? .managed : .stationary

		if NotchWindow.showOnAllSpaces {
			self.collectionBehavior = [ self.collectionBehavior, .canJoinAllSpaces ]
		}
		
		var screenWidth = 1680
		var screenHeight = 1050
		
		let notchWidth = NotchWindow.notchWidth
		let notchOffset = 10
		
		if let screen = self.screen {
			let frame = screen.frame
			
			// get the current window's screen and its width and heights
			screenWidth = Int(frame.width)
			screenHeight = Int(frame.height)
			
			// update default notch sizes based on display, so other screen sizes don't get anything unexpected
			NotchWindow.defaultNotchWidth = Int(Double(screenWidth) / 10.5)
			NotchWindow.defaultNotchHeight = Int(Double(screenHeight) / 26.25)
		}
		
		self.contentView = NSHostingView(rootView: NotchView())
		
		if !NotchWindow.allowMoving {
			let pos = NSPoint(x: screenWidth/2 - notchWidth/2, y: screenHeight + notchOffset)
			self.setFrameTopLeftPoint(pos)
		}
	}
}
