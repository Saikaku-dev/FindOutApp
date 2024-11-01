
import SwiftUI

struct OpenView: View {
    @State private var showHomeView = false

    var body: some View {
        ZStack {
            if showHomeView {
                HomeView()
                    .transition(.opacity)
            } else {
                VStack {
                    Image("openimage")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 1.0)) {
                            showHomeView = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OpenView()
}

