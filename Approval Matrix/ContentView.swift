import SwiftUI
import SwiftData

struct ContentView: View {
    @Query(sort: \Matrix.numApproval) private var matrices: [Matrix]
    @State private var DefaultExpanded = false
    @State private var TransferOnlineExpanded = false
    @State var DefaultColor = Color.black
    @State var TransferOnlineColor = Color.black

    var body: some View {
        NavigationView {
            ZStack {
                Color.orange
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Color.white
                        .cornerRadius(20)
                        .edgesIgnoringSafeArea(.bottom)
                        .overlay(
                            VStack {
                                headerView
                                Divider()
                                    .background(Color.gray)
                                    .padding(.horizontal, 16)
                                    .padding(.bottom, 20)
                                featureButtons
                                matrixList
                            }
                            .padding(.horizontal, 16),
                            alignment: .topTrailing
                        )
                }
            }
            .navigationTitle("Approval Matrix")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Approval Matrix")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private var headerView: some View {
        HStack {
            Spacer()
            NavigationLink(destination: NewMatrixView()) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("Tambah New Matrix")
                }
                .padding()
                .background(Color(red: 0.06, green: 0.06, blue: 0.6))
                .foregroundColor(.white)
                .font(.system(size: 16, weight: .bold))
                .cornerRadius(20)
            }
            .padding(.vertical)
        }
    }

    private var featureButtons: some View {
        VStack {
            Button(action: {
                DefaultExpanded.toggle()
                DefaultColor = DefaultExpanded ? Color.orange : Color.black
            }) {
                featureButtonContent(title: "Default", color: DefaultColor, expanded: DefaultExpanded)
            }
            .padding(.bottom, 20)
            Button(action: {
                TransferOnlineExpanded.toggle()
                TransferOnlineColor = TransferOnlineExpanded ? Color.orange : Color.black
            }) {
                featureButtonContent(title: "Transfer Online", color: TransferOnlineColor, expanded: TransferOnlineExpanded)
            }
        }
    }

    private func featureButtonContent(title: String, color: Color, expanded: Bool) -> some View {
        HStack {
            Text(title)
                .foregroundColor(color)
                .font(.system(size: 20))
                .padding([.top, .leading, .bottom])
            Spacer()
            Rectangle().frame(width: 1, height: 30)
                .foregroundColor(color.opacity(0.5))
            Text(title)
                .foregroundColor(color)
                .font(.system(size: 20))
            Spacer()
            Image(systemName: expanded ? "chevron.up" : "chevron.down")
                .foregroundColor(color)
                .padding(.trailing)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .stroke(color, lineWidth: 2)
        )
    }

    private var matrixList: some View {
        ScrollView {
            VStack {
                ForEach(matrices) { matrix in
                    VStack {
                        if DefaultExpanded && matrix.selectedFeature == "Default" {
                            NavigationLink(destination: MatrixInfoView(matrix: matrix)) {
                                matrixRow(matrix: matrix)
                            }
                        }
                        if TransferOnlineExpanded && matrix.selectedFeature == "Transfer Online" {
                            NavigationLink(destination: MatrixInfoView(matrix: matrix)) {
                                matrixRow(matrix: matrix)
                            }
                        }
                    }
                }
            }
            .padding()
        }
    }

    private func matrixRow(matrix: Matrix) -> some View {
        VStack {
            HStack {
                Text("Range Limit of Approval")
                Spacer()
                VStack {
                    HStack {
                        Text("Minimum IDR")
                        Spacer()
                        Text(matrix.rangeApprovalMin)
                    }
                    HStack {
                        Text("Maximum IDR")
                        Spacer()
                        Text(matrix.rangeApprovalMax)
                    }
                }
            }
            .padding([.top, .leading, .trailing])
            Divider().padding(.horizontal)
            HStack {
                Text("Number of Approval")
                Spacer()
                Text("\(matrix.numApproval ?? 0)")
            }
            .padding(.horizontal)
            Divider().padding([.leading, .bottom, .trailing])
        }
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
        .foregroundColor(.black)
        .font(.system(size: 12, weight: .light))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
