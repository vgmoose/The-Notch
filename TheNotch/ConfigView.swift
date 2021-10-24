import SwiftUI

struct ConfigView: View {
	
	@State private var scale = 50.0
	@State private var isEditing = false
	
	@State private var movable = NotchWindow.allowMoving
	@State private var allSpaces = NotchWindow.showOnAllSpaces
	
	var body: some View {
		VStack {
			// For adjusting the overall scale
			Text("Relative overall notch size in percent")
			Slider(
				value: $scale,
				in: 25...75,
				step: 5,
				onEditingChanged: { editing in
					NotchWindow.notchHeight = Int(Double(NotchWindow.defaultNotchHeight) * (scale / 50.0))
					NotchWindow.notchWidth = Int(Double(NotchWindow.defaultNotchWidth) * (scale / 50.0))
					NotchWindow.singleton?.refreshNotch()
				}
			)
			Text(String(format: "%.2fx", scale / 50))
			Spacer(minLength: 10)
			
			// For adjusting only the width
//			Text("Notch width in scaled pixels")
//			Slider(
//				value: $scale,
//				in: 25...75,
//				step: 5,
//				onEditingChanged: { editing in
//					NotchWindow.notchHeight = Int(Double(NotchWindow.defaultNotchHeight) * (scale / 50.0))
//					NotchWindow.notchWidth = Int(Double(NotchWindow.defaultNotchWidth) * (scale / 50.0))
//					NotchWindow.singleton?.refreshNotch()
//				}
//			)
//			Text(String(format: "%.2fx", scale / 50))
			Toggle("Allow Notch to be moved and dragged", isOn: $movable).onChange(of: movable) {
				NotchWindow.allowMoving = $0
				NotchWindow.singleton?.refreshNotch()
			}
			Toggle("Show Notch on all Spaces", isOn: $allSpaces).onChange(of: allSpaces) {
				NotchWindow.showOnAllSpaces = $0
				NotchWindow.singleton?.refreshNotch()
			}
		}
		
		.scaledToFit()
	}
}

struct ConfigView_Previews: PreviewProvider {
	static var previews: some View {
		ConfigView()
	}
}
