//
//  Step.swift
//  Advent22
//
//  Created by Dragan Cecavac on 22.12.21.
//

import Foundation

struct Step {
    var on: Bool
    var xl: Int
    var xh: Int
    var yl: Int
    var yh: Int
    var zl: Int
    var zh: Int

    func isCore() -> Bool{
        return -50 <= xl && xl <= 50
            && -50 <= xh && xh <= 50
            && -50 <= yl && yl <= 50
            && -50 <= yh && yh <= 50
            && -50 <= zl && zl <= 50
            && -50 <= zh && zh <= 50
    }

    func overlapping(with other: Step) -> Step? {
        var result = other

        if xh < other.xl || other.xh < xl
            || yh < other.yl || other.yh < yl
            || zh < other.zl || other.zh < zl {
            return nil
        }

        result.xl = max (xl, other.xl)
        result.xh = min (xh, other.xh)
        result.yl = max (yl, other.yl)
        result.yh = min (yh, other.yh)
        result.zl = max (zl, other.zl)
        result.zh = min (zh, other.zh)

        return result
    }

    func size() -> UInt64 {
        let lengthX = UInt64(abs(xl - xh) + 1)
        let lengthY = UInt64(abs(yl - yh) + 1)
        let lengthZ = UInt64(abs(zl - zh) + 1)

        return lengthX * lengthY * lengthZ
    }

    func boundsMatching(_ other: Step) -> Bool {
        return xl == other.xl && xh == other.xh
            && yl == other.yl && yh == other.yh
            && zl == other.zl && zh == other.zh
    }
}
