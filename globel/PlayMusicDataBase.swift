//
//  PlayMusicDataBase.swift
//  SwiftMusic
//
//  Created by lanou on 16/8/2.
//  Copyright © 2016年 lanou. All rights reserved.
//

import UIKit
import FMDB


class PlayMusicDataBase: NSObject {
    
    
    var dataBase:FMDatabase?
    
    var mytablename:String?
    
    
    static var shareDataBase:PlayMusicDataBase = {
    
            let instance = PlayMusicDataBase()
    
        return instance
    
    }()
    
    
    func openDatabase(){
    
        let docpath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask , true) [0]
        
        let databasepath = docpath.stringByAppendingString("/Music.sqlite")
        
        print(databasepath)
        
        
        dataBase = FMDatabase.init(path: databasepath)
        
    
    }
    
    func creatDataBasetable(table:String){
    
        
        
       
            
            openDatabase()

            mytablename = table
      

        if ((dataBase?.open()) != nil){
            

          let sqlstring = "create table if not exists \(mytablename!)(ID Integer NOT NULL PRIMARY KEY AUTOINCREMENT,SongID TEXT, SongName TEXT,SingerName TEXT,SongImage TEXT,Lrcy TEXT,SongUrl TEXT) "
            
            let result = dataBase?.executeStatements(sqlstring)
         
            if result == true {
                
                print("建表成功")
                
            }else{
            
                print("建表失败")
            }

        }
     
    }
    
    
    //插入数据
    func insertPlayModel(playmodel:PlayModel){
        
        
        
        if dataBase?.open() == true {
            let insertSqlString = "insert into \(mytablename ?? "musictable")(SongID,SongName,SingerName,SongImage,Lrcy,SongUrl)values(?,?,?,?,?,?)"
            
        
          
            do{
                
            
                try dataBase?.executeUpdate(insertSqlString, values:[playmodel.song_id!,playmodel.title!,playmodel.author!,playmodel.pic_radio!,playmodel.lrclink!,playmodel.file_link!])
                
          
            } catch {
            
            
                print("插入数据失败")
           
            
            }
        
            
            
        }
        
        
        NSNotificationCenter.defaultCenter().postNotificationName("reload", object: nil)
        
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    //删除数据
    func deletePlayModel(song_id:String){
    
    
        if dataBase?.open() == true{
        
            let deleteSqlString = "delete from \(mytablename ?? "musictable") where ID = ?"
        
          
            do{
                //异常捕获 这里面出错的时候就会走下面那个方法
                try  dataBase?.executeUpdate(deleteSqlString, values: [song_id])
                
            
            }catch{
            
            
                print("删除失败")
            
            
            }
      
        }
    
    
    
    
    
    }
    
    func selectData() -> [PlayModel]{
    
        var allModel = [PlayModel]()
        
        if dataBase?.open() == true {
            
            let sqlString = "SELECT * \(mytablename ?? "musictable") user ORDER BY SongID ASC"
            
       
        let resultset = dataBase?.executeQuery(sqlString, withArgumentsInArray: ["musictable"])
            
            
            while resultset?.next() == true {
                
                let playmodel = PlayModel()
                
                playmodel.song_id = resultset?.stringForColumn("SongName")
                playmodel.author = resultset?.stringForColumn("SingerName")
                playmodel.pic_radio = resultset?.stringForColumn("SongImage")
                playmodel.file_link = resultset?.stringForColumn("SongUrl")
                playmodel.lrclink = resultset?.stringForColumn("Lrcy")
                
                
                allModel.append(playmodel)
                
            }
            
          
            
        }
    
        return allModel
    
    }
    
    
    
    
    
    
    
    
    //返回所有数据
    func selectAllModels() -> [PlayModel]{
        
        PlayMusicDataBase.shareDataBase.openDatabase()
    
            var allModel = [PlayModel]()
        
        if dataBase?.open() == true{
        
            
            let selectSql = "select * from \(mytablename ?? "musictable")"
            
            
            let resultSet = dataBase?.executeQuery(selectSql, withArgumentsInArray: ["musictable"])
            
            
            
            while resultSet?.next() == true {
                
                let playmodel = PlayModel()
                
                playmodel.song_id = resultSet?.stringForColumn("SongName")
                playmodel.author = resultSet?.stringForColumn("SingerName")
                playmodel.pic_radio = resultSet?.stringForColumn("SongImage")
                playmodel.file_link = resultSet?.stringForColumn("SongUrl")
                playmodel.lrclink = resultSet?.stringForColumn("Lrcy")
                playmodel.sortId = Int((resultSet?.intForColumn("ID"))!)
                
             allModel.append(playmodel)
                
            }
      
        
        }
        
        return allModel
    
    }
    
    
    
    
    
    
    
    

}
