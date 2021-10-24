import SwiftUI

struct NotchView: View {
    var body: some View {
		RoundedRectangle(cornerRadius: 10)
			.fill(Color.black)
			.frame(width: 130, height: 30)
    }
}

struct NotchView_Previews: PreviewProvider {
    static var previews: some View {
        NotchView()
    }
}
