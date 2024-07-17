/*
 See LICENSE folder for this sample’s licensing information.
 
 Abstract:
 A `Pose` is a collection of "landmarks" and connections between select landmarks.
 Each `Pose` can draw itself as a wireframe to a Core Graphics context.
 */

import UIKit
import Vision

typealias Observation = VNHumanBodyPoseObservation
/// Stores the landmarks and connections of a human body pose and draws them as
/// a wireframe.
/// - Tag: Pose
struct Pose {
    /// The names and locations of the significant points on a human body.
    private let landmarks: [Landmark]
    
    /// A list of lines between landmarks for drawing a wireframe.
    private var connections: [Connection]!
    
    /// The locations of the pose's landmarks as a multiarray.
    /// - Tag: multiArray
    let multiArray: MLMultiArray?
    
    /// A rough approximation of the landmarks' area.
    let area: CGFloat
    
    /// Creates a `Pose` for each human body pose observation in the array.
    /// - Parameter observations: An array of human body pose observations.
    /// - Returns: A `Pose` array.
    static func fromObservations(_ observations: [Observation]?) -> [Pose]? {
        // Convert each observations to a `Pose`.
        observations?.compactMap { observation in Pose(observation) }
    }
    
    /// Creates a wireframe from a human pose observation.
    /// - Parameter observation: A human body pose observation.
    init?(_ observation: Observation) {
        // Create a landmark for each joint in the observation.
        landmarks = observation.availableJointNames.compactMap { jointName in
            guard jointName != JointName.root else {
                return nil
            }
            
            guard let point = try? observation.recognizedPoint(jointName) else {
                return nil
            }
            
            return Landmark(point)
        }
        
        guard !landmarks.isEmpty else { return nil }
        
        //
        area = Pose.areaEstimateOfLandmarks(landmarks)
        
        // Save the multiarray from the observation.
        multiArray = try? observation.keypointsMultiArray()
        
        // Build a list of connections from the pose's landmarks.
        buildConnections()
    }
    
    /// Draws all the valid connections and landmarks of the wireframe.
    /// - Parameters:
    ///   - context: A context the method uses to draw the wireframe.
    ///   - transform: A transform that modifies the point locations.
    /// - Tag: drawWireframeToContext
    func drawWireframeToContext(_ context: CGContext,
                                applying transform: CGAffineTransform? = nil) {
        let scale = drawingScale
        
        // Draw the connection lines first.
        connections.forEach {
            line in line.drawToContext(context, applying: transform, at: scale)
            
        }
        
        // Draw the landmarks on top of the lines' endpoints.
        landmarks.forEach { landmark in
            landmark.drawToContext(context, applying: transform, at: scale)
        }
    }
    
    /// Adjusts the landmarks radius and connection thickness when the pose draws
    /// itself as a wireframe.
    private var drawingScale: CGFloat {
        /// The typical size of a dominant pose.
        ///
        /// The sample's author empirically derived this value.
        let typicalLargePoseArea: CGFloat = 0.35
        
        /// The largest scale is 100%.
        let max: CGFloat = 1.0
        
        /// The smallest scale is 60%.
        let min: CGFloat = 0.6
        
        /// The area's ratio relative to the typically large pose area.
        let ratio = area / typicalLargePoseArea
        
        let scale = ratio >= max ? max : (ratio * (max - min)) + min
        return scale
    }
}

// MARK: - Helper methods
extension Pose {
    /// Creates an array of connections from the available landmarks.
    mutating func buildConnections() {
        // Only build the connections once.
        guard connections == nil else {
            return
        }
        
        connections = [Connection]()
        
        // Get the joint name for each landmark.
        let joints = landmarks.map { $0.name }
        
        // Get the location for each landmark.
        let locations = landmarks.map { $0.location }
        
        // Create a lookup dictionary of landmark locations.
        let zippedPairs = zip(joints, locations)
        let jointLocations = Dictionary(uniqueKeysWithValues: zippedPairs)
        
        // Add a connection if both of its endpoints have valid landmarks.
        for jointPair in Pose.jointPairs {
            guard let one = jointLocations[jointPair.joint1] else { continue }
            guard let two = jointLocations[jointPair.joint2] else { continue }
            
            connections.append(Connection(one, two))
        }
    }
    
    /// Returns a rough estimate of the landmarks' collective area.
    /// - Parameter landmarks: A `Landmark` array.
    /// - Returns: A `CGFloat` that is greater than or equal to `0.0`.
    static func areaEstimateOfLandmarks(_ landmarks: [Landmark]) -> CGFloat {
        let xCoordinates = landmarks.map { $0.location.x }
        let yCoordinates = landmarks.map { $0.location.y }
        
        guard let minX = xCoordinates.min() else { return 0.0 }
        guard let maxX = xCoordinates.max() else { return 0.0 }
        
        guard let minY = yCoordinates.min() else { return 0.0 }
        guard let maxY = yCoordinates.max() else { return 0.0 }
        
        let deltaX = maxX - minX
        let deltaY = maxY - minY
        
        return deltaX * deltaY
    }
}

extension Pose {
    typealias JointName = VNHumanBodyPoseObservation.JointName

    /// The name and location of a point of interest on a human body.
    ///
    /// Each landmark defines its location in an image and the name of the body
    /// joint it represents, such as nose, left eye, right knee, and so on.
    struct Landmark {
        /// The minimum `VNRecognizedPoint` confidence for a valid `Landmark`.
        private static let threshold: Float = 0.2

        /// The drawing radius of a landmark.
        private static let radius: CGFloat = 14.0

        /// The name of the landmark.
        ///
        /// For example, "left shoulder", "right knee", "nose", and so on.
        let name: JointName

        /// The location of the landmark in normalized coordinates.
        ///
        /// When calling `drawToContext()`, use a transform to apply a scale
        /// that's appropriate for the graphics context.
        let location: CGPoint

        /// Creates a landmark from a point.
        /// - Parameter point: A point in a human body pose observation.
        init?(_ point: VNRecognizedPoint) {
            // Only create a landmark from a point that satisfies the minimum
            // confidence.
            guard point.confidence >= Pose.Landmark.threshold else {
                return nil
            }

            name = JointName(rawValue: point.identifier)
            location = point.location
        }

        /// Draws a circle at the landmark's location after transformation.
        /// - Parameters:
        ///   - context: A context the method uses to draw the landmark.
        ///   - transform: A transform that modifies the point locations.
        func drawToContext(_ context: CGContext, applying transform: CGAffineTransform? = nil, at scale: CGFloat = 1.0) {

            context.setFillColor(UIColor.white.cgColor)
            context.setStrokeColor(UIColor.darkGray.cgColor)

            // Define the rectangle's origin by applying the transform to the
            // landmark's normalized location.
            let origin = location.applying(transform ?? .identity)

            // Define the size of the circle's rectangle with the radius.
            let radius = Landmark.radius * scale
            let diameter = radius * 2
            let rectangle = CGRect(x: origin.x - radius, y: origin.y - radius, width: diameter, height: diameter)
            
            context.addEllipse(in: rectangle)
            context.drawPath(using: CGPathDrawingMode.fillStroke)
        }
    }
}
