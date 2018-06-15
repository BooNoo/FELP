import RealmSwift

extension RealmController {

.......////

    func createTradePoint(points: [TradePoint]){
        DispatchQueue(label: "loadDataFromWeb").async {
            autoreleasepool {
                let realm = try! Realm()
                for point in points {
                    try! realm.write {
                        realm.add(point, update: true)
                    }
                }
                self.deleteDeletedPoint()
            }
        }
    }

    func updatePoints(completionHandler: @escaping (String?, Error?) -> ()) {
            let server = API()
            server.getPointsData() { responseObject, error in
                if ((error) != nil) {
                    completionHandler(nil, error)
                } else {
                    let json = JSON(responseObject as Any)
                    var points: [TradePoint] = []
                    self.setAllPointDeleted()

                    for (_,subJson):(String, JSON) in json {
                        let address = (subJson["address"].string != nil) ? subJson["address"].string! : ""
                        let name = (subJson["name"].string != nil) ? subJson["name"].string! : ""
                        let phone = (subJson["phone"].string != nil) ? subJson["phone"].string! : ""
                        let terminalId = (subJson["terminalId"].string != nil) ? subJson["terminalId"].string! : ""
                        let tags = (subJson["tag"].string != nil) ? subJson["tag"].string! : ""
                        let latitude = subJson["latitude"].double
                        let longitude = subJson["longitude"].double
                        let openTimeHour = subJson["openTime"]["hour"].int
                        let openTimeMinute = subJson["openTime"]["minute"].int
                        let closeTimeHour = subJson["closeTime"]["hour"].int
                        let closeTimeMinute = subJson["closeTime"]["minute"].int

                        if (latitude != nil  && longitude != nil && terminalId != "") {
                            let point = TradePoint(value: [
                                "address": address,
                                "name": name,
                                "phone": phone,
                                "terminalId": terminalId,
                                "latitude": latitude!,
                                "longitude": longitude!,
                                "openTimeHour": openTimeHour,
                                "openTimeMinute": openTimeMinute ?? 0,
                                "closeTimeHour": closeTimeHour,
                                "closeTimeMinute": closeTimeMinute ?? 0,
                                "tags": tags,
                                "isDeleted": false,
                                ])
                            points.append(point)
                        }
                    }
                    self.createTradePoint(points: points)
                    completionHandler("no load error", nil)
                }
                return
            }
    }


.......///////

}