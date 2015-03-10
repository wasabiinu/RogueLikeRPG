import Foundation

enum AloeEase {
    case None
    , InQuad , OutQuad , InOutQuad
    , InCubic , OutCubic , InOutCubic
    , InQuart, OutQuart, InOutQuart
    , InQuint, OutQuint, InOutQuint
    , InSine, OutSine, InOutSine
    , InExpo, OutExpo, InOutExpo
    , InCirc, OutCirc, InOutCirc
    , InElastic, OutElastic, InOutElastic
    , InBack, OutBack, InOutBack
    , InBounce, OutBounce, InOutBounce
    
    static let list = [None
        , InQuad , OutQuad , InOutQuad
        , InCubic , OutCubic , InOutCubic
        , InQuart, OutQuart, InOutQuart
        , InQuint, OutQuint, InOutQuint
        , InSine, OutSine, InOutSine
        , InExpo, OutExpo, InOutExpo
        , InCirc, OutCirc, InOutCirc
        , InElastic, OutElastic, InOutElastic
        , InBack, OutBack, InOutBack
        , InBounce, OutBounce, InOutBounce]
    
    func name()->String{
        switch(self){
        case .None: return "None"
        case .InQuad: return "InQuad"
        case .OutQuad: return "OutQuad"
        case .InOutQuad: return "InOutQuad"
        case .InCubic: return "InCubic"
        case .OutCubic: return "OutCubic"
        case .InOutCubic: return "InOutCubic"
        case .InQuart: return "InQuart"
        case .OutQuart: return "OutQuart"
        case .InOutQuart: return "InOutQuart"
        case .InQuint: return "InQuint"
        case .OutQuint: return "OutQuint"
        case .InOutQuint: return "InOutQuint"
        case .InSine: return "InSine"
        case .OutSine: return "OutSine"
        case .InOutSine: return "InOutSine"
        case .InExpo: return "InExpo"
        case .OutExpo: return "OutExpo"
        case .InOutExpo: return "InOutExpo"
        case .InCirc: return "InCirc"
        case .OutCirc: return "OutCirc"
        case .InOutCirc: return "InOutCirc"
        case .InElastic: return "InElastic"
        case .OutElastic: return "OutElastic"
        case .InOutElastic: return "InOutElastic"
        case .InBack: return "InBack"
        case .OutBack: return "OutBack"
        case .InOutBack: return "InOutBack"
        case .InBounce: return "InBounce"
        case .OutBounce: return "OutBounce"
        case .InOutBounce: return "InOutBounce"
        }
    }
    
    func calc (t:Double, b:Double, c:Double, d:Double) -> Double {
        
        switch(self){
        case .None: return easeNone(t, b: b, c: c, d: d)
        case .InQuad: return easeInQuad(t, b: b, c: c, d: d)
        case .OutQuad: return easeOutQuad(t, b: b, c: c, d: d)
            /*
            case .InOutQuad: return easeInOutQuad(t, b: b, c: c, d: d)
            case .InCubic: return easeInCubic(t, b: b, c: c, d: d)
            case .OutCubic: return easeOutCubic(t, b: b, c: c, d: d)
            case .InOutCubic: return easeInOutCubic(t, b: b, c: c, d: d)
            case .InQuart: return easeInQuart(t, b: b, c: c, d: d)
            case .OutQuart: return easeOutQuart(t, b: b, c: c, d: d)
            case .InOutQuart: return easeInOutQuart(t, b: b, c: c, d: d)
            case .InQuint: return easeInQuint(t, b: b, c: c, d: d)
            case .OutQuint: return easeOutQuint(t, b: b, c: c, d: d)
            case .InOutQuint: return easeInOutQuint(t, b: b, c: c, d: d)
            case .InSine: return easeInSine(t, b: b, c: c, d: d)
            case .OutSine: return easeOutSine(t, b: b, c: c, d: d)
            case .InOutSine: return easeInOutSine(t, b: b, c: c, d: d)
            case .InExpo: return easeInExpo(t, b: b, c: c, d: d)
            case .OutExpo: return easeOutExpo(t, b: b, c: c, d: d)
            case .InOutExpo: return easeInOutExpo(t, b: b, c: c, d: d)
            case .InCirc: return easeInCirc(t, b: b, c: c, d: d)
            case .OutCirc: return easeOutCirc(t, b: b, c: c, d: d)
            case .InOutCirc: return easeInOutCirc(t, b: b, c: c, d: d)
            case .InElastic: return easeInElastic(t, b: b, c: c, d: d)
            case .OutElastic: return easeOutElastic(t, b: b, c: c, d: d)
            case .InOutElastic: return easeInOutElastic(t, b: b, c: c, d: d)
            case .InBack: return easeInBack(t, b: b, c: c, d: d)
            case .OutBack: return easeOutBack(t, b: b, c: c, d: d)
            case .InOutBack: return easeInOutBack(t, b: b, c: c, d: d)
            case .InBounce: return easeInBounce(t, b: b, c: c, d: d)
            case .OutBounce: return easeOutBounce(t, b: b, c: c, d: d)
            case .InOutBounce: return easeInOutBounce(t, b: b, c: c, d: d)
            */
        default: return easeNone(t, b: b, c: c, d: d)
        }
    }
    private func easeNone(t:Double, b:Double, c:Double, d:Double)->Double{
        return c*t/d + b
    }
    private func easeInQuad(t:Double, b:Double, c:Double, d:Double)->Double{
        let t:Double = t / d
        return c*t*t + b
    }
    private func easeOutQuad(t:Double, b:Double, c:Double, d:Double)->Double{
        let t:Double = t / d
        return (-c) * t * (t-2) + b
    }
    // 〜以下略 easing関数〜
}