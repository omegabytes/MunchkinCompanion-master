//
//  UserModel.swift
//  MunchkinCompanion
//
//  Created by Alex Gaesser on 2/1/15.
//  Copyright (c) 2015 AlexGaesser. All rights reserved.
//

import Foundation
import CoreData

@objc(UserModel)
class UserModel: NSManagedObject {

    @NSManaged var combat: NSNumber
    @NSManaged var effectiveCombat: NSNumber
    @NSManaged var level: NSNumber
    @NSManaged var monsterLevel: NSNumber
    @NSManaged var netCombatResult: NSNumber
    @NSManaged var oneShot: NSNumber
    @NSManaged var userName: String

}
