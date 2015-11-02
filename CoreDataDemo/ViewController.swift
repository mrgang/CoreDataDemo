//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by 李刚 on 15/10/23.
//  Copyright © 2015年 李刚. All rights reserved.
//

import UIKit
import CoreData
class ViewController: UIViewController {

    @IBOutlet var lab1: UILabel!
    
    @IBOutlet var lab2: UILabel!
    
    @IBOutlet var textInputAge: UITextField!
    
    @IBOutlet var textInputName: UITextField!
    
    @IBOutlet var lableResult: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func add(sender: UIButton) {
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        
        //声明数据的请求
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = 0
        //声明一个实体结构
        let entity: NSEntityDescription? = NSEntityDescription.entityForName("People", inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        //设置查询条件
        let predicate = NSPredicate(format: "name= '\(getName())'", "")
        fetchRequest.predicate = predicate
        //查询操作
        var fetchedObjects: [AnyObject]?
        do{
            try fetchedObjects = context.executeFetchRequest(fetchRequest)
        }catch{
            lableResult.text = "\(error)"
        }
        if nil != fetchedObjects && fetchedObjects!.count > 0 {
            lableResult.text = "该用户已存在"
            return
        }
        
        let people = NSEntityDescription.insertNewObjectForEntityForName("People", inManagedObjectContext: context) as! People
        people.age = getAge()
        people.name = getName()
        do{
            try context.save()
        }catch{
            lableResult.text = "\(error)"
        }
        
    }
    func getAge() -> Int16 {
        if textInputAge.text!.characters.count == 0 {
            return 0
        }else{
            return Int16(self.textInputAge.text!)!
        }
    }
    func getName() -> String {
        if textInputName.text!.characters.count == 0 {
            return "lg"
        }else{
            return textInputName.text!
        }
    }
  
    @IBAction func deleteAct(sender: UIButton) {
        //获取管理的数据的上下文
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        //声明数据的请求
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = 0
        
        //声明一个实体结构
        let entity: NSEntityDescription? = NSEntityDescription.entityForName("People", inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        //设置查询条件
        let predicate = NSPredicate(format: "name= '\(getName())'", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        var fetchedObjects: [AnyObject]?
        do{
            try fetchedObjects = context.executeFetchRequest(fetchRequest)
        }catch{
            lableResult.text = "\(error)"
        }
        if let _ = fetchedObjects{
            for li in fetchedObjects! {
                context.deleteObject(li as! NSManagedObject)
            }
            do{
                    try context.save()
                }catch{
                    lableResult.text = "\(error)"
                }
            
        }
    }
    
    @IBAction func change(sender: UIButton) {
        //获取管理的数据的上下文
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        //声明数据的请求
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = 0
        
        //声明一个实体结构
        let entity: NSEntityDescription? = NSEntityDescription.entityForName("People", inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        //设置查询条件
        let name2Change = textInputName.text!
        if name2Change.characters.count == 0 {
            lableResult.text = "please  input select name"
            return
        }
        let predicate = NSPredicate(format: "name= '\(name2Change)'", "")
        fetchRequest.predicate = predicate
        
        //查询操作
        var fetchedObjects: [AnyObject]?
        do{
            try fetchedObjects = context.executeFetchRequest(fetchRequest)
        }catch{
            lableResult.text = "\(error)"
        }
        if let _ = fetchedObjects{
            for inf: People in fetchedObjects as! [People]{
                inf.age = Int16(textInputAge.text ?? "0")!
                do{
                    try context.save()
                }catch{
                    lableResult.text = "\(error)"
                }
            }
        }
    }
    
    @IBAction func selecte(sender: UIButton) {
        //获取管理的数据的上下文
        let app = UIApplication.sharedApplication().delegate as! AppDelegate
        let context = app.managedObjectContext
        //声明数据的请求
        let fetchRequest: NSFetchRequest = NSFetchRequest()
        fetchRequest.fetchLimit = 10
        fetchRequest.fetchOffset = 0
        
        //声明一个实体结构
        let entity: NSEntityDescription? = NSEntityDescription.entityForName("People", inManagedObjectContext: context)
        //设置数据请求的实体结构
        fetchRequest.entity = entity
        //设置查询条件
        let predicate = NSPredicate(format: "age >= 0")
        fetchRequest.predicate = predicate
        
        //查询操作
        var fetchedObjects: [AnyObject]?
        do{
            try fetchedObjects = context.executeFetchRequest(fetchRequest)
        }catch{
             lableResult.text = "\(error)"
        }
        var res = ""
        if let _ = fetchedObjects{
            for inf: People in fetchedObjects as! [People]{
                res += "name=\(inf.name!) age=\(inf.age)\n"
            }
        }
        lableResult.text = res
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

