import SwiftUI
import SwiftData

@Model
class Matrix {
    var matrixName: String
    var rangeApprovalMin: String
    var rangeApprovalMax: String
    var numApproval: Int?
    var selectedFeature: String
    
    init(matrixName: String, rangeApprovalMin: String, rangeApprovalMax: String, numApproval: Int? = nil, selectedFeature: String = "Default") {
        self.matrixName = matrixName
        self.rangeApprovalMin = rangeApprovalMin
        self.rangeApprovalMax = rangeApprovalMax
        self.numApproval = numApproval
        self.selectedFeature = selectedFeature
    }
}
