//
//  ContentView.swift
//  Final Grade
//
//  Created by Tessa Murray on 9/27/24.
//

import SwiftUI

struct ContentView: View {
    //MVP
    @State private var currentGradeTextField = ""
    @State private var finalWeightTextField = ""
    @State private var desiredGrade = 0.0
    @State private var requiredGrade = 0.0
    var body: some View {
        VStack {
            Text("Final Grade Calculator")
                .bold()
                .font(.title)
                .padding()
            TextField("Current Semester Grade", text: $currentGradeTextField)
                .multilineTextAlignment(.center)
            TextField("Final Weight %", text: $finalWeightTextField)
                .multilineTextAlignment(.center)
            Picker("Desired Semester Grade", selection: $desiredGrade) {
                Text("A").tag(90.0)
                Text("B").tag(80.0)
                Text("C").tag(70.0)
                Text("D").tag(60.0)
            }
            .pickerStyle(.segmented)
            .padding()
            Text("Required Grade on the Final")
            CustomText(text: String(format: "%.1f", requiredGrade))
                .padding()
            
            Spacer()
        }
        .onChange(of: desiredGrade) { oldValue, newValue in calculateGrade()
        }
        .background(requiredGrade > 100 ? Color.red : Color.green.opacity(requiredGrade > 0 ? 1.0 : 0.0))
    }
    
    // 2
    
    func calculateGrade()
    {
        // if there is a number there
        if let currentGrade = Double(currentGradeTextField) {
            // if there is a number there
            if let finalWeight = Double(finalWeightTextField) {
                if finalWeight < 100 && finalWeight > 0 {
                    // turn weight into percentage
                    let finalPercentage = finalWeight / 100.0
                    //do the math
                    requiredGrade = max(0.0, (desiredGrade - (currentGrade * (1.0 - finalPercentage))) / finalPercentage)
                }
            }
        }
    }
}


#Preview {
    ContentView()
}

struct CustomTextField: View {
    let placeholder : String
    let variable : Binding<String>
    var body: some View {
        TextField(placeholder, text: variable)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .frame(width: 200, height: 30)
            .font(.body)
            .padding()
    }
}

struct CustomText: View {
    let text : String
    var body: some View {
        Text(text)
            .font(.title)
            .fontWeight(.bold)
    }
}
