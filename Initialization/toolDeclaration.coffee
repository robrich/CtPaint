# organized as they are in the 2 x 11 tool bar grid
toolNames = [
  'zoom', 'select'
  'sample', 'fill'
  'square', 'circle'
  'line', 'point'
  'flip', 'rotate'
  'invert', 'displace'
  'scale', 'resize'
  'horizontalSwap', 'verticalSwap'
  'copy', 'paste'
  'cut', 'view'
  'undo', 'redo'
]

toolMaxMagnitudes = [
  4, ''
  '', ''
  7, 7
  7, 7

  '', ''
  '', ''
  '', ''
  '', ''
  '', ''
  '', ''
  '', ''
]

toolModeCapacity = [
  false, true
  false, false
  true, true
  false, false

  false, false
  false, false
  false, false
  false, false
  false, false
  false, false
  false, false
]

toolMenuImages = [
  '', ''
  '', ''
  '', ''
  '', ''
  new Image(), new Image()
  '', new Image()
  new Image(), new Image()
  '', ''
  '', ''
  '', ''
  '', ''
]

ctPaintTools = {}

iteration = 0
while iteration < numberOfTools
  thisIteration = iteration
  ctPaintTools[iteration] =
    number: iteration
    name: toolNames[iteration]
    clickRegion: [((iteration%2)*25),(Math.floor(iteration/2))*25]
    pressedImage: [new Image(), new Image()]
    magnitude: 1
    maxMagnitude: toolMaxMagnitudes[iteration]
    modeCapable: toolModeCapacity[iteration]
    mode: false
    posture: ''
    menuImage: toolMenuImages[iteration]
    toolsAction: ->
      console.log 'did a '+toolNames[@number]
  ctPaintTools[iteration].pressedImage[0].src = 'assets\\u'+zeroPadder(iteration,2)+'000.PNG'
  ctPaintTools[iteration].pressedImage[1].src = 'assets\\v'+zeroPadder(iteration,2)+'000.PNG'
  iteration++

ctPaintTools[0].posture = zoomPosture
ctPaintTools[1].posture = selectPosture
ctPaintTools[2].posture = samplePosture
ctPaintTools[3].posture = fillPosture
ctPaintTools[4].posture = squarePosture
ctPaintTools[5].posture = circlePosture
ctPaintTools[6].posture = linePosture
ctPaintTools[7].posture = pointPosture
ctPaintTools[8].posture = emptyPosture
ctPaintTools[9].posture = emptyPosture
ctPaintTools[10].posture = emptyPosture
ctPaintTools[11].posture = emptyPosture
ctPaintTools[12].posture = emptyPosture
ctPaintTools[13].posture = emptyPosture
ctPaintTools[14].posture = emptyPosture
ctPaintTools[15].posture = emptyPosture
ctPaintTools[16].posture = emptyPosture
ctPaintTools[17].posture = emptyPosture
ctPaintTools[18].posture = emptyPosture
ctPaintTools[19].posture = emptyPosture
ctPaintTools[20].posture = emptyPosture
ctPaintTools[21].posture = emptyPosture

ctPaintTools[8].toolsAction = flipAction
ctPaintTools[9].toolsAction = rotateAction
ctPaintTools[10].toolsAction = invertAction
ctPaintTools[11].toolsAction = replaceAction
ctPaintTools[13].toolsAction = resizeAction
ctPaintTools[16].toolsAction = copyAction
ctPaintTools[17].toolsAction = pasteAction
ctPaintTools[18].toolsAction = cutAction
ctPaintTools[20].toolsAction = undoAction
ctPaintTools[21].toolsAction = redoAction

ctPaintTools[14].posture = horizontalColorSwapPosture
ctPaintTools[15].posture = verticalColorSwapPosture

ctPaintTools[8].menuImage.src = 'assets\\t01.png'
ctPaintTools[11].menuImage.src = 'assets\\t02.png'
ctPaintTools[9].menuImage.src = 'assets\\t04.png'
ctPaintTools[12].menuImage.src = 'assets\\t05.png'
ctPaintTools[13].menuImage.src = 'assets\\t03.png'

toolsToNumbers =
  'zoom':0
  'select':1
  'sample':2
  'fill':3
  'square':4
  'circle':5
  'line':6
  'point':7
  'flip':8
  'rotate':9
  'invert':10
  'replace':11
  'scale':12
  'resize':13
  'horizontalSwap':14
  'verticalSwap':15
  'copy':16
  'paste':17
  'cut':18
  'view':19
  'undo':20
  'redo':21

