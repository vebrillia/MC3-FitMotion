//
//  Predictor.swift
//  ActionClassifierSwiftUI
//
//  Created by Kristanto Sean on 18/07/24.
//

import Foundation
import Vision

protocol PredictorDelegate: AnyObject {
    func predictor(_ predictor: Predictor, didFindNewRecognizedPoints points: [CGPoint])
    func predictor(_ predictor: Predictor, didLabelAction action: String, with confidence: Double)
}

class Predictor {
    
    weak var delegate: PredictorDelegate?
    
    // set prediction window size (30 for 1 second (30fps)) and array for predicting
    let predictionWindowSize = 90
    var posesWindow: [VNHumanBodyPoseObservation] = []
    
    init() {
        posesWindow.reserveCapacity(predictionWindowSize)
    }
    
    func estimation(sampleBuffer: CMSampleBuffer) {
        let requestHandler = VNImageRequestHandler(cmSampleBuffer: sampleBuffer, orientation: .up)
        
        let request = VNDetectHumanBodyPoseRequest(completionHandler: bodyPoseHandler)
        
        do {
            try requestHandler.perform([request])
        } catch {
            print("Unable to perform the request with error \(error)")
        }
    }
    
    func bodyPoseHandler(request: VNRequest, error: Error?) {
        guard let observations = request.results as? [VNHumanBodyPoseObservation] else { return }
        
        observations.forEach { observation in
            processObservation(observation)
        }
        
        // get the first accurate observation to be processed with ML detection
        if let result = observations.first {
            storeObservation(result)
            
            labelActionType()
        }
    }
    
    func processObservation(_ observation: VNHumanBodyPoseObservation) {
        do {
            let recognizedPoints = try observation.recognizedPoints(forGroupKey: .all)
            
            // orientation up means the Y starts at the bottom, need to adjust that for our app
            let displayedPoints = recognizedPoints.map {
                CGPoint(x: $0.value.x, y: 1 - $0.value.y)
            }
            
            delegate?.predictor(self, didFindNewRecognizedPoints: displayedPoints)
        } catch {
            print("Error finding recognized points: \(error)")
        }
    }
    
    func storeObservation(_ observation: VNHumanBodyPoseObservation) {
        // make sure if poses window is already full, we remove old one and make room for new one
        if posesWindow.count >= predictionWindowSize {
            posesWindow.removeFirst()
        }
        
        posesWindow.append(observation)
    }
    
    func labelActionType() {
        guard let modelClassifier = try? BicepCurl(configuration: MLModelConfiguration()) else { return }
        
        // prepare the multi array for prediction
        guard let poseMultiArray = prepareInputWithObservations() else { return }
        
        // predict the window
        guard let predictions = try? modelClassifier.prediction(poses: poseMultiArray) else { return }
        
        let label = predictions.label
        let confidence = predictions.labelProbabilities[label] ?? 0
        
        print("ZZZZZZ")
        print(label, confidence)
        
        delegate?.predictor(self, didLabelAction: label, with: confidence)
    }
    
    func prepareInputWithObservations() -> MLMultiArray? {
        let numAvailableFrames = posesWindow.count
        let observationsNeeded = 90
        var multiArrayBuffer = [MLMultiArray]()
        
        // translate our poses into multi array
        for frameIndex in 0 ..< min(numAvailableFrames, observationsNeeded) {
            let pose = posesWindow[frameIndex]
            do {
                let oneFrameMultiArray = try pose.keypointsMultiArray()
                multiArrayBuffer.append(oneFrameMultiArray)
            } catch {
                continue
            }
        }
        
        if numAvailableFrames < observationsNeeded {
            for _ in 0 ..< (observationsNeeded - numAvailableFrames) {
                do {
                    let oneFrameMultiArray = try MLMultiArray(shape: [1, 3, 18], dataType: .double)
                    try resetMultiArray(oneFrameMultiArray)
                    multiArrayBuffer.append(oneFrameMultiArray)
                } catch {
                    continue
                }
                
                print("Array")
            }
        }
        
        return MLMultiArray(concatenating: [MLMultiArray](multiArrayBuffer), axis: 0, dataType: .float)
    }
    
    // function to rewrite to 0 when necessary
    func resetMultiArray(_ predictionWindow: MLMultiArray, with value: Double = 0.0) throws {
        let pointer = try UnsafeMutableBufferPointer<Double>(predictionWindow)
        pointer.initialize(repeating: value)
        
    }
}

