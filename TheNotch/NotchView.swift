import SwiftUI

struct NotchView: View {
    var body: some View {
		RoundedRectangle(cornerRadius: CGFloat(NotchWindow.notchHeight) / 4.0)
			.fill(Color.black)
			.frame(width: CGFloat(NotchWindow.notchWidth), height: CGFloat(NotchWindow.notchHeight))
    }
}

struct NotchView_Previews: PreviewProvider {
    static var previews: some View {
        NotchView()
    }
}
