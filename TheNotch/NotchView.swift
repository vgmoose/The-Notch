import SwiftUI

struct NotchView: View {
    var body: some View {
		RoundedRectangle(cornerRadius: CGFloat(NotchWindow.notchHeight) / 4.0)
			.fill(Color.black)
			.frame(width: CGFloat(NotchWindow.notchWidth), height: CGFloat(NotchWindow.notchHeight))
			.onTapGesture {
				if !NotchWindow.showInDock {
					// when the dock icon is hidden, when the view is touched, make config visible
					if TheNotchApp.singleton?.window?.isOnActiveSpace ?? false {
						TheNotchApp.singleton?.window?.makeKeyAndOrderFront(self)
					}
				}
			}
    }
}

struct NotchView_Previews: PreviewProvider {
    static var previews: some View {
        NotchView()
    }
}
