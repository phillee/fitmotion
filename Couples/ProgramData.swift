//
//  CouplesData.swift
//  Couples
//
//  Created by Philip Lee on 1/19/16.
//  Copyright © 2016 Philip Lee. All rights reserved.
//

import UIKit

class SectionData: NSObject {
    var name: String!
    var image: String!
    var videoUrl: String!

    init(name: String, image: String, videoUrl: String) {
        self.name = name
        self.image = image
        self.videoUrl = videoUrl
    }
}


class ProgramData: NSObject {
    var sectionData: [SectionData]!
    var name: String!
    var coverImage: String!
    var programDescription: String!

    init(name: String, coverImage: String, programDescription: String, sectionData: [SectionData]) {
        self.name = name
        self.coverImage = coverImage
        self.programDescription = programDescription
        self.sectionData = sectionData
    }

    static let CouplesWorkouts = [
        ProgramData(
            name: "Core & Flexibility",
            coverImage: "cover-core.jpg",
            programDescription: "",
            sectionData:[
            ]
        ),
        ProgramData(
            name: "Cardio Sweat",
            coverImage: "cover-cardio.jpg",
            programDescription: "",
            sectionData: []),
        ProgramData(
            name: "Strength & Tone",
            coverImage: "cover-strength.jpg",
            programDescription: "",
            sectionData: [
                SectionData(
                    name: "Warmup & Stretching",
                    image: "warmup.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Squats & Overhead Press",
                    image: "squats.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Bicep Curls",
                    image: "biceps.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Lunges",
                    image: "lunges.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Hips & Shoulders",
                    image: "hips_shoulders.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Deadlift & Shoulder Raise",
                    image: "deadlift.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Tricep Dips",
                    image: "tricep.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Oblique Twists",
                    image: "oblique.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Upright Row & Reverse Fly",
                    image: "upright_row.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Pushups",
                    image: "pushups.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4"),
                SectionData(
                    name: "Bridges & Chest Press",
                    image: "bridges.png",
                    videoUrl: "https://s3-us-west-2.amazonaws.com/couples-workouts/squats.mp4")
            ])
    ]
}