import SwiftUI
import SwiftData

struct MatrixInfoView: View {
    var matrix: Matrix
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var matrixName: String
    @State private var rangeApprovalMin: String
    @State private var rangeApprovalMax: String
    @State private var numApproval: Int?
    @State private var selectedFeature: String
    let features = ["Default", "Transfer Online"]

    init(matrix: Matrix) {
        self.matrix = matrix
        _matrixName = State(initialValue: matrix.matrixName)
        _rangeApprovalMin = State(initialValue: matrix.rangeApprovalMin)
        _rangeApprovalMax = State(initialValue: matrix.rangeApprovalMax)
        _numApproval = State(initialValue: matrix.numApproval)
        _selectedFeature = State(initialValue: matrix.selectedFeature)
    }

    var body: some View {
        NavigationView {
            ZStack {
                Color.orange.edgesIgnoringSafeArea(.all)
                VStack {
                    Color.white
                        .edgesIgnoringSafeArea(.bottom)
                        .overlay(
                            VStack {
                                Text("Approval Matrix Info")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(.orange)
                                Divider().padding(.horizontal)
                                VStack {
                                    HStack {
                                        Text("Approval Matrix Alias")
                                            .font(.system(size: 17))
                                        Spacer()
                                    }
                                    .padding(.top)
                                    TextField("Input Matrix Name", text: $matrixName)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .font(.system(size: 25))
                                    HStack {
                                        Text("Features")
                                            .font(.system(size: 17))
                                        Spacer()
                                    }
                                    .padding(.top)
                                    HStack {
                                        Picker("Select Feature", selection: $selectedFeature) {
                                            ForEach(features, id: \.self) {
                                                Text($0)
                                            }
                                        }
                                        .pickerStyle(MenuPickerStyle())
                                        .overlay(RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.black, lineWidth: 1))
                                        Spacer()
                                    }
                                }.padding(.bottom, 5.0)
                                Divider().padding(.horizontal)
                                VStack {
                                    HStack {
                                        Text("Range of Approval (Minimum)")
                                            .font(.system(size: 17))
                                        Spacer()
                                    }
                                    .padding(.top)
                                    TextField("Input Text Here", text: $rangeApprovalMin)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .font(.system(size: 25))
                                    HStack {
                                        Text("Range of Approval (Maximum)")
                                            .font(.system(size: 17))
                                        Spacer()
                                    }
                                    .padding(.top)
                                    TextField("Input Text Here", text: $rangeApprovalMax)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .font(.system(size: 25))
                                    HStack {
                                        Text("Number of Approval")
                                            .font(.system(size: 17))
                                        Spacer()
                                    }
                                    .padding(.top)
                                    TextField("Input Number", value: $numApproval, formatter: NumberFormatter())
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .font(.system(size: 25))
                                        .padding(.bottom)
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            matrix.matrixName = matrixName
                                            matrix.rangeApprovalMin = rangeApprovalMin
                                            matrix.rangeApprovalMax = rangeApprovalMax
                                            matrix.numApproval = numApproval
                                            matrix.selectedFeature = selectedFeature
                                            dismiss()
                                        }) {
                                            Text("UPDATE")
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                    .foregroundColor(.orange)
                                    .font(.system(size: 20, weight: .bold))
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            context.delete(matrix)
                                            dismiss()
                                        }) {
                                            Text("DELETE")
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
                                    .foregroundColor(.orange)
                                    .font(.system(size: 20, weight: .bold))
                                }
                            }
                            .padding(),
                            alignment: .top
                        )
                }
            }
            .navigationTitle("Approval Matrix")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Approval Matrix")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct MatrixInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MatrixInfoView(matrix: Matrix(matrixName: "Sample", rangeApprovalMin: "0", rangeApprovalMax: "10000", numApproval: 1, selectedFeature: "Default"))
    }
}
