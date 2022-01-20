import SwiftUI

struct Circle_beauty: View {
    var body: some View {
        ZStack{
            //Mark: Placeholder Ring
            Circle()
                .foregroundColor(.gray)
                .opacity(0.1)
            Button("Button") {
                // Action for the button
            }
        }
    }
}

struct Circle_beauty_Previews: PreviewProvider {
    static var previews: some View {
        Circle_beauty()
    }
}
