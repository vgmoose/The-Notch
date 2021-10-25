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
	static var showInDock = true
	
	static var scale = 1.0
	
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
		
		// update how it can be interacted with
		self.ignoresMouseEvents = !NotchWindow.allowMoving
		self.isMovableByWindowBackground = NotchWindow.allowMoving
		self.collectionBehavior = NotchWindow.allowMoving ? .managed : .stationary

		if NotchWindow.showOnAllSpaces {
			self.collectionBehavior = [ self.collectionBehavior, .canJoinAllSpaces ]
		}
		
		// default 13-inch resolution (is used if some display change events being nil)
		var screenWidth = 1440
		var screenHeight = 900
		
		// update the size to the latest scaling info from the config
		NotchWindow.notchHeight = Int(Double(NotchWindow.defaultNotchHeight) * (NotchWindow.scale))
		NotchWindow.notchWidth = Int(Double(NotchWindow.defaultNotchWidth) * (NotchWindow.scale))
		
		let notchWidth = NotchWindow.notchWidth
		let notchOffset = 10
		
		NSApp.setActivationPolicy(NotchWindow.showInDock ? .regular : .accessory)
		
		if !NotchWindow.showInDock {
			// if we aren't showing in the dock, it has to remain clickable
			self.ignoresMouseEvents = false
			
			// always show preferences, there's no other entrypoint
			NSApp.activate(ignoringOtherApps: true)
		}
		
		// get window's screen dimensions, or default if they aren't available for some reason
		// TODO: default to main display?
		let frame = self.screen?.frame ?? NSRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

		// get the current window's screen and its width and heights
		screenWidth = Int(frame.width)
		screenHeight = Int(frame.height)
		
		// update default notch sizes based on display, so other screen sizes don't get anything unexpected
		NotchWindow.defaultNotchWidth = Int(Double(screenWidth) / 10.5)
		NotchWindow.defaultNotchHeight = Int(Double(screenHeight) / 26.25)

		self.contentView = NSHostingView(rootView: NotchView())
		
		if !NotchWindow.allowMoving {
			let pos = NSPoint(x: screenWidth/2 - notchWidth/2, y: screenHeight + notchOffset)
			self.setFrameTopLeftPoint(pos)
		}
	}
}
