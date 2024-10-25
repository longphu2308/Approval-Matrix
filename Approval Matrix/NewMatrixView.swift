import SwiftUI

struct NewMatrixView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) var dismiss
    @State private var matrixName: String = ""
    @State private var rangeApprovalMin: String = ""
    @State private var rangeApprovalMax: String = ""
    @State private var numApproval: Int? = nil
    @State private var selectedFeature = "Default"
    let features = ["Default", "Transfer Online"]

    var body: some View {
        NavigationView {
            ZStack {
                Color.orange.edgesIgnoringSafeArea(.all)
                VStack {
                    Color.white
                        .edgesIgnoringSafeArea(.bottom)
                        .overlay(
                            VStack {
                                Text("Create New Approval Matrix")
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
                                VStack{
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
                                            let newMatrix = Matrix(matrixName:matrixName, rangeApprovalMin:rangeApprovalMin, rangeApprovalMax:rangeApprovalMax,numApproval:numApproval,selectedFeature: selectedFeature)
                                            context.insert(newMatrix)
                                            do {
                                                try context.save()
                                                dismiss()
                                            } catch {
                                                print("Failed to save context: \(error.localizedDescription)")
                                            }
                                        }) {
                                            Text("ADD TO LIST")
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth:1))
                                    .foregroundColor(.orange)
                                    .font(.system(size: 20, weight: .bold))
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            matrixName=""
                                            rangeApprovalMin=""
                                            rangeApprovalMax=""
                                            numApproval=nil
                                            selectedFeature="Default"
                                        }) {
                                            Text("RESET")
                                        }
                                        Spacer()
                                    }
                                    .padding()
                                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth:1))
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
                    NavigationLink(destination: ContentView()) {
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

struct NewMatrixView_Previews: PreviewProvider {
    static var previews: some View {
        NewMatrixView()
    }
}
