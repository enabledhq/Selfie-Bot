//
//  RekognitionManager.swift
//  Selfie-Bot
//
//  Created by John Smith on 17/2/17.
//  Copyright © 2017 Enabled. All rights reserved.
//

import Foundation
import AWSCore
import AWSRekognition


class RekognitionManager {
    
    public static func setupDefaults() {
        let credentialsProvider = AWSCognitoCredentialsProvider(
            regionType: .USWest2,
            identityPoolId: getIdentityPoolFromDisk())
        
        let configuration = AWSServiceConfiguration(
            region: .USWest2,
            credentialsProvider: credentialsProvider)
        
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
    }
    
    public static func requestFaceDetection(image: Data,  completionHandler: ((AWSRekognitionDetectFacesResponse?, Error?) -> Swift.Void)?) {
        let awsRequest = AWSRekognitionDetectFacesRequest()
        let awsImage = AWSRekognitionImage()
        awsRequest?.attributes = ["ALL"]
        awsImage?.bytes = image
        awsRequest?.image = awsImage
        
        AWSRekognition.default().detectFaces(awsRequest!, completionHandler: completionHandler)
    }
    
    public static func getIdentityPoolFromDisk() -> String {
        let url = Bundle.main.url(forResource: "identityPoolID", withExtension: "txt")
        do {
            return try String(contentsOfFile:url!.path, encoding: String.Encoding.utf8)
        } catch {
            fatalError("Cannot read identity pool ID")
        }
    }
    
}
