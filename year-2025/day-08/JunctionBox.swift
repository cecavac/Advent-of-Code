//
//  JunctionBox.swift
//  day-08
//
//  Created by Dragan Cecavac on 08.12.25.
//

class JunctionBox {
    var circuitId: Int
    let x, y, z: Int
    let id: Int
    static var idGenerator = 0

    init(_ data: String) {
        let elements = data.split(separator: ",")
        x = Int(String(elements[0]))!
        y = Int(String(elements[1]))!
        z = Int(String(elements[2]))!

        id = JunctionBox.idGenerator
        circuitId = JunctionBox.idGenerator
        JunctionBox.idGenerator += 1
    }

    func distance(box: JunctionBox) -> Int {
        let dx = x - box.x
        let dy = y - box.y
        let dz = z - box.z

        return dx * dx + dy * dy + dz * dz
    }
}
