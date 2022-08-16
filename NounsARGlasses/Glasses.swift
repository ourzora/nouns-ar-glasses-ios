enum Glasses: String, CaseIterable {
    case hipRose = "hip rose"
    case blackEyesRed = "square black eyes red"
    case blackRGB = "square black rgb"
    case black = "square black"
    case blueMedSaturated = "square blue med saturated"
    case blue = "square blue"
    case frogGreen = "square frog green"
    case fullblack = "square fullblack"
    case greenBlueMulti = "square green blue multi"
    case greyLight = "square grey light"
    case guava = "square guava"
    case honey = "square honey"
    case magenta = "square magenta"
    case orange = "square orange"
    case pinkPurpleMulti = "square pink purple multi"
    case red = "square red"
    case smoke = "square smoke"
    case teal = "square teal"
    case watermelon = "square watermelon"
    case yellowOrangeMulti = "square yellow orange multi"
    case yellowSaturated = "square yellow saturated"
  
    func colourScheme() -> ColourScheme {
      switch self {
      case .hipRose:
        return ColourScheme(eyes: .normal, bridge: .pink, rightFrame: .pink, leftFrame: .pink, temple: .pink, templeTip: .pink)
      case .blackEyesRed:
        return ColourScheme(eyes: .red, bridge: .black, rightFrame: .black, leftFrame: .black, temple: .black, templeTip: .black)
      case .blackRGB:
        return ColourScheme(eyes: .rgb, bridge: .black, rightFrame: .black, leftFrame: .black, temple: .black, templeTip: .black)
      case .black:
        return ColourScheme(eyes: .normal, bridge: .black, rightFrame: .black, leftFrame: .black, temple: .black, templeTip: .black)
      case .blueMedSaturated:
        return ColourScheme(eyes: .normal, bridge: .blueSaturated, rightFrame: .blueSaturated, leftFrame: .blueSaturated, temple: .blueSaturated, templeTip: .blueSaturated)
      case .blue:
        return ColourScheme(eyes: .normal, bridge: .blue, rightFrame: .blue, leftFrame: .blue, temple: .blue, templeTip: .blue)
      case .frogGreen:
        return ColourScheme(eyes: .normal, bridge: .frogGreen, rightFrame: .frogGreen, leftFrame: .frogGreen, temple: .frogGreen, templeTip: .frogGreen)
      case .fullblack:
        return ColourScheme(eyes: .fullBlack, bridge: .black, rightFrame: .black, leftFrame: .black, temple: .black, templeTip: .black)
      case .greenBlueMulti:
        return ColourScheme(eyes: .normal, bridge: .purpleBlue, rightFrame: .lightBlue, leftFrame: .green, temple: .purpleBlue, templeTip: .lightBlue)
      case .greyLight:
        return ColourScheme(eyes: .normal, bridge: .greyLight, rightFrame: .greyLight, leftFrame: .greyLight, temple: .greyLight, templeTip: .greyLight)
      case .guava:
        return ColourScheme(eyes: .normal, bridge: .guavaWatermelon, rightFrame: .guavaWatermelon, leftFrame: .guavaWatermelon, temple: .guavaWatermelon, templeTip: .guavaWatermelon)
      case .honey:
        return ColourScheme(eyes: .normal, bridge: .honey, rightFrame: .honey, leftFrame: .honey, temple: .honey, templeTip: .honey)
      case .magenta:
        return ColourScheme(eyes: .normal, bridge: .magenta, rightFrame: .magenta, leftFrame: .magenta, temple: .magenta, templeTip: .magenta)
      case .orange:
        return ColourScheme(eyes: .normal, bridge: .orange, rightFrame: .orange, leftFrame: .orange, temple: .orange, templeTip: .orange)
      case .pinkPurpleMulti:
        return ColourScheme(eyes: .normal, bridge: .purple, rightFrame: .violet, leftFrame: .pink, temple: .purple, templeTip: .violet)
      case .red:
        return ColourScheme(eyes: .normal, bridge: .red, rightFrame: .red, leftFrame: .red, temple: .red, templeTip: .red)
      case .smoke:
        return ColourScheme(eyes: .normal, bridge: .smoke, rightFrame: .smoke, leftFrame: .smoke, temple: .smoke, templeTip: .smoke)
      case .teal:
        return ColourScheme(eyes: .normal, bridge: .teal, rightFrame: .teal, leftFrame: .teal, temple: .teal, templeTip: .teal)
      case .watermelon:
        return ColourScheme(eyes: .normal, bridge: .guavaWatermelon, rightFrame: .guavaWatermelon, leftFrame: .guavaWatermelon, temple: .guavaWatermelon, templeTip: .guavaWatermelon)
      case .yellowOrangeMulti:
        return ColourScheme(eyes: .normal, bridge: .lightOrange, rightFrame: .lightOrange, leftFrame: .yellow, temple: .lightOrange, templeTip: .yellow)
      case .yellowSaturated:
        return ColourScheme(eyes: .normal, bridge: .yellowSaturated, rightFrame: .yellowSaturated, leftFrame: .yellowSaturated, temple: .yellowSaturated, templeTip: .yellowSaturated)
      }
   }
}

enum EyeType {
  case red, rgb, fullBlack, normal
}

enum PartColour: String {
  case black = "#000000"
  case blueSaturated = "#2B83F6"
  case blue = "#5648ED"
  case frogGreen = "#8DD122"
  case green = "#068940"
  case lightBlue = "#257CED"
  case purpleBlue = "#254EFB"
  case greyLight = "#9CB4B8"
  case guavaWatermelon = "#E8705B"
  case honey = "#D19A54"
  case magenta = "#B9185C"
  case orange = "#FE500C"
  case pink = "#FF638D"
  case purple = "#AB36BE"
  case violet = "#CC0595"
  case red = "#F3322C"
  case smoke = "#D7D3CD"
  case teal = "#4BEA69"
  case yellow = "#FFC110"
  case lightOrange = "#F98F30"
  case yellowSaturated = "#FFEF16"
  case redEye = "#FF0E0E"
}

struct ColourScheme {
  var eyes: EyeType
  var bridge: PartColour
  var rightFrame: PartColour
  var leftFrame: PartColour
  var temple: PartColour
  var templeTip: PartColour
}
