//
//  QuestionsParser.swift
//  SwiftPaginationCoreDataExample
//
//  Created by William Boles on 29/02/2016.
//  Copyright © 2016 Boles. All rights reserved.
//

import UIKit
import CoreData
import CoreDataServices

class QuestionsMapper: Mapper {
    
    //MARK: - Questions
    
    func mapQuestions(questionsRetrievalResponse: Dictionary<String, AnyObject>) -> Page {
        let page = NSEntityDescription.insertNewObjectForEntity(Page.self, managedObjectContext: self.localManagedObjectContext) as! Page
        
        let questionResponses = questionsRetrievalResponse["items"]
        
        for index in (0..<questionResponses!.count) {
            let questionResponse = questionResponses![index] as! Dictionary<String, AnyObject>
            
            let question = self.mapQuestion(questionResponse)
            question.index = index
            
            if (question.page == nil) {
                question.page = page
            } else {
                page.fullPage = false
            }
        }
        
        return page
    }
    
    //MARK: - Question
    
    func mapQuestion(questionResponse: Dictionary<String, AnyObject>) -> Question {
        let questionID = questionResponse["question_id"] as! NSInteger
        
        let predicate = NSPredicate(format: "questionID == \(questionID)")
        
        var question = self.localManagedObjectContext.retrieveFirstEntry(Question.self, predicate: predicate) as? Question
        
        if (question == nil) {
            question = NSEntityDescription.insertNewObjectForEntity(Question.self, managedObjectContext: self.localManagedObjectContext) as? Question
            
            question?.questionID = questionID
        }
        
        /*----------------*/
        
        question?.title = questionResponse["title"] as? String
        
        /*----------------*/
        
        let authorResponse = questionResponse["owner"] as! Dictionary<String, AnyObject>
        
        let userMapper = UserMapper(managedObjectContext: self.localManagedObjectContext)
        question?.author = userMapper.mapUser(authorResponse)
        
        /*----------------*/
        
        return question!
    }
}
