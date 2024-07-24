//
//  ExerciseClassifier+Singleton.swift
//  MC3-FitMotion
//
//  Created by Baghiz on 24/07/24.
//

/*
See LICENSE folder for this sample’s licensing information.

Abstract:
Creates a common instance of the Exercise Classifier.
 The app only uses one instance anyway and using a static property initializes
 the model at launch instead of when the the main view loads.
*/

import CoreML

extension BicepCurl {
    /// Creates a shared Exercise Classifier instance for the app at launch.
    static let shared: BicepCurl = {
        // Use a default model configuration.
        let defaultConfig = MLModelConfiguration()

        // Create an Exercise Classifier instance.
        guard let bicepCurl = try? BicepCurl(configuration: defaultConfig) else {
            // The app requires the action classifier to function.
            fatalError("Exercise Classifier failed to initialize.")
        }

        // Ensure the Exercise Classifier.Label cases match the model's classes.
        bicepCurl.checkLabels()

        return bicepCurl
    }()
}
