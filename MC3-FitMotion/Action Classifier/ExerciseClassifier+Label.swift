//
//  ExerciseClassifier+Label.swift
//  MC3-FitMotion
//
//  Created by Baghiz on 24/07/24.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Defines the app's knowledge of the model's class labels.
*/

extension BicepCurl {
    /// Represents the app's knowledge of the Exercise Classifier model's labels.
    enum Label: String, CaseIterable {
        case Benar = "Benar"
        case Salah = "Salah"

        /// A negative class that represents irrelevant actions.
        case Idle = "Idle"

        /// Creates a label from a string.
        /// - Parameter label: The name of an action class.
        init(_ string: String) {
            guard let label = Label(rawValue: string) else {
                let typeName = String(reflecting: Label.self)
                fatalError("Add the `\(string)` label to the `\(typeName)` type.")
            }

            self = label
        }
    }
}

