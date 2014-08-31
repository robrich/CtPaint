toolbarHeight = 36
toolbarWidth = 52

canvasWidth = 512
canvasHeight = 512

canvasYPos = 5
canvasXPos = toolbarWidth+5

canvasAsData = undefined

selectedTool = undefined
numberOfTools = 22
toolViewMode = 0

mousePressed = false

zeroPadder = (number,zerosToFill) ->
  numberAsString = number+''
  while numberAsString.length < zerosToFill
    numberAsString = '0'+numberAsString
  return numberAsString

rgbToHex = (rgb) ->
  return '#' + rgb[0].toString(16) + rgb[1].toString(16) + rgb[2].toString(16)

ctCanvas = document.getElementById('CtPaint')
ctContext = ctCanvas.getContext('2d')

toolbar0Canvas = document.getElementById('toolbar0')
toolbar0Context = toolbar0Canvas.getContext('2d')
toolbar0sImage0 = new Image()
toolbar0sImage0.src = 'toolbar0v.PNG'
toolbar0sImage1 = new Image()
toolbar0sImage1.src = 'toolbar0u.PNG'

buttonWidth = 24
buttonHeight = 24

keysToKeyCodes = 
  'backspace':8
  'tab':9
  'enter':13
  'shift':16
  'ctrl':17
  'alt':18
  'caps lock':20
  'escape':27
  'space':32
  'left':37
  'up':38
  'right':39
  'down':40
  'delete':46
  '0':48
  '1':49
  '2':50
  '3':51
  '4':52
  '5':53
  '6':54
  '7':55
  '8':56
  '9':57
  'a':65
  'b':66
  'c':67
  'd':68
  'e':69
  'f':70
  'g':71
  'h':72
  'i':73
  'j':74
  'k':75
  'l':76
  'm':77
  'n':78
  'o':79
  'p':80
  'q':81
  'r':82
  's':83
  't':84
  'u':85
  'v':86
  'w':87
  'x':88
  'y':89
  'z':90
  'left command':91
  'right command':93
  'numpad0':96
  'numpad1':97
  'numpad2':98
  'numpad3':99
  'numpad4':100
  'numpad5':101
  'numpad6':102
  'numpad7':103
  'numpad8':104
  'numpad9':105
  'f1':112
  'f2':113
  'f3':114
  'f4':115
  'f5':116
  'f6':117
  'f7':118
  'f8':119
  'f9':120
  'f10':121
  'f11':122
  'f12':123
  'semicolon':186
  'equals':187
  'comma':188
  'minus':189
  'period':190
  'forward slash':191
  'tilda':192
  'left bracket':219
  'back slash':220
  'right bracket':221
  'single quote':222

toolNames = ['zoom','select','sample','fill','square','circle','line','point']

zoomAction = ->
  console.log '0'

selectAction = ->
  console.log '1'

sampleAction = ->
  console.log '2'

fillAction = ->
  console.log '3'

squareAction = ->
  console.log '4'

circleAction = ->
  console.log '5'

lineAction = (canvas, color, beginX, beginY, endX, endY) ->
  drawLine(canvas, color, beginX, beginY, endX, endY)

pointAction = (canvas, color, beginX, beginY, endX, endY) ->
  drawLine(canvas, color, beginX, beginY, endX, endY)

ctPaintTools = {}

iteration = 0
while iteration < numberOfTools
  thisIteration = iteration
  ctPaintTools[iteration] =
    number: iteration
    name: toolNames[iteration]
    clickRegion: [((iteration%2)*25),(Math.floor(iteration/2))*25]
    pressedImage: [new Image(), new Image()]
    toolsAction: ->
      console.log toolNames, iteration, thisIteration
      console.log 'did a '+toolNames[@number]
  ctPaintTools[iteration].pressedImage[0].src = 'u'+zeroPadder(iteration,2)+'.PNG'
  ctPaintTools[iteration].pressedImage[1].src = 'v'+zeroPadder(iteration,2)+'.PNG'
  iteration++

ctPaintTools[7].toolsAction = pointAction
ctPaintTools[6].toolsAction = lineAction

toolbar1Canvas = document.getElementById('toolbar1')
toolbar1Context = toolbar1Canvas.getContext('2d')
toolbar1sImage = new Image()
toolbar1sImage.src = 'toolbar10.png'
backgroundCanvas = document.getElementById('background')
backgroundContext = backgroundCanvas.getContext('2d')

border0Canvas = document.getElementById('border0')
border0Context = border0Canvas.getContext('2d')
border1Canvas = document.getElementById('border1')
border1Context = border1Canvas.getContext('2d')
border2Canvas = document.getElementById('border2')
border2Context = border2Canvas.getContext('2d')
border3Canvas = document.getElementById('border3')
border3Context = border3Canvas.getContext('2d')

border0Context.canvas.width = 1
border0Context.canvas.height = 1
border1Context.canvas.width = 1
border1Context.canvas.height = 1
border2Context.canvas.width = 1
border2Context.canvas.height = 1
border3Context.canvas.width = 1
border3Context.canvas.height = 1

colorsAtHand = [[192,192,192],[0,0,0],[255,255,255],[0,0,0]]

xSpot = undefined
ySpot = undefined

oldX = undefined
oldY = undefined

putPixel = (canvas, color, whereAtX, whereAtY) ->
  newPixel = canvas.createImageData(1,1)
  newPixelsColor = newPixel.data
  newPixelsColor[0] = color[0]
  newPixelsColor[1] = color[1]
  newPixelsColor[2] = color[2]
  newPixelsColor[3] = 255
  canvas.putImageData(newPixel,whereAtX,whereAtY)

drawLine = (canvas, color, beginX, beginY, endX, endY) ->
  deltaX = Math.abs(endX - beginX)
  if beginX < endX
    directionX = 1
  else
    directionX = -1
  deltaY = Math.abs(endY - beginY)
  if beginY < endY
    directionY = 1
  else
    directionY = -1
  if deltaX > deltaY
    errorOne = deltaX/2
  else
    errorOne = -deltaY/2
  keepGoin = true
  while keepGoin
    putPixel(canvas,color,beginX,beginY)
    if (beginX == endX) and (beginY == endY)
      keepGoin = false
    errorTwo = errorOne
    if errorTwo > -deltaX
      errorOne -= deltaY
      beginX += directionX
    if errorTwo < deltaY
      errorOne += deltaX
      beginY += directionY
  
positionCorners = ->
  $('#border0Div').css('top',(canvasYPos-1).toString())
  $('#border0Div').css('left',(canvasXPos-1).toString())

  $('#border1Div').css('top',(canvasYPos-1).toString())
  $('#border1Div').css('left',(canvasXPos+canvasWidth+1).toString())

  $('#border2Div').css('top',(canvasYPos+canvasHeight+1).toString())
  $('#border2Div').css('left',(canvasXPos+canvasWidth+1).toString())

  $('#border3Div').css('top',(canvasYPos+canvasHeight+1).toString())
  $('#border3Div').css('left',(canvasXPos-1).toString())

prepareCanvas = ->
  ctContext.canvas.width = canvasWidth
  ctContext.canvas.height = canvasHeight

  ctContext.fillStyle = '#000000'
  ctContext.fillRect(0,0,canvasWidth,canvasHeight)

  $('#ctpaintDiv').css('top', canvasYPos.toString())
  $('#ctpaintDiv').css('left', canvasXPos.toString())

  positionCorners()

setCanvasSizes = ->
  toolbar0Context.canvas.width = toolbarWidth
  toolbar0Context.canvas.height = window.innerHeight-toolbarHeight

  toolbar1Context.canvas.width = window.innerWidth
  toolbar1Context.canvas.height = toolbarHeight

  backgroundContext.canvas.width = window.innerWidth
  backgroundContext.canvas.height = window.innerHeight

placeToolbars = ->
  $('#toolbar0Div').css('top', '0')
  $('#toolbar1Div').css('top', (window.innerHeight-toolbarHeight).toString())

drawToolbars = ->
  toolbar0Context.fillStyle = '#202020'
  toolbar0Context.fillRect(0,0,toolbarWidth,window.innerHeight-toolbarHeight)
  toolbar0Context.drawImage(toolbar0sImage0,0,0)
  drawLine(toolbar0Context,[16,20,8],toolbarWidth-1,0,toolbarWidth-1,window.innerHeight-toolbarHeight)
  if selectedTool
    toolbar0Context.drawImage(selectedTool.pressedImage[toolViewMode],selectedTool.clickRegion[0],selectedTool.clickRegion[1])

  toolbar1Context.fillStyle = '#202020'
  toolbar1Context.fillRect(0,0,window.innerWidth,toolbarHeight)
  toolbar1Context.drawImage(toolbar1sImage,0,1)
  drawLine(toolbar1Context,[16,20,8],toolbarWidth-1,0,window.innerWidth,0)

  toolbar1Context.fillStyle = rgbToHex(colorsAtHand[0])
  toolbar1Context.fillRect(4,3,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorsAtHand[1])
  toolbar1Context.fillRect(21,3,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorsAtHand[2])
  toolbar1Context.fillRect(13,20,14,14)

  toolbar1Context.fillStyle = rgbToHex(colorsAtHand[2])
  toolbar1Context.fillRect(30,20,14,14)

getMousePosition = (event) ->
  xSpot = event.clientX
  ySpot = event.clientY

$(document).ready ()->
  setTimeout( ()->
    setCanvasSizes()
    prepareCanvas()
    placeToolbars()
    selectedTool = ctPaintTools[7]
    drawToolbars()
    canvasAsData = ctCanvas.toDataURL()
  ,200)

  $('body').keydown (event) ->
    if event.keyCode == keysToKeyCodes['up']
      canvasYPos-=3
      $('#ctpaintDiv').css('top', canvasYPos.toString())
      $('#ctpaintDiv').css('left', canvasXPos.toString())
      positionCorners()
    if event.keyCode == keysToKeyCodes['down']
      canvasYPos+=3
      $('#ctpaintDiv').css('top', canvasYPos.toString())
      $('#ctpaintDiv').css('left', canvasXPos.toString())
      positionCorners()
    if event.keyCode == keysToKeyCodes['right']
      console.log 'B'
      canvasXPos+=3
      $('#ctpaintDiv').css('top', canvasYPos.toString())
      $('#ctpaintDiv').css('left', canvasXPos.toString())
      positionCorners()
    if event.keyCode == keysToKeyCodes['left']
      canvasXPos-=3
      $('#ctpaintDiv').css('top', canvasYPos.toString())
      $('#ctpaintDiv').css('left', canvasXPos.toString())
      positionCorners()
  #$('body').keypress (event)->


  #$('body').keyup (event) ->
  #  console.log 'UP'


  $(window).resize ()->
    setCanvasSizes()
    placeToolbars()
    drawToolbars()

  $(window).scroll ()->
    $('#ctpaintDiv').css('top', canvasYPos.toString())
    $('#ctpaintDiv').css('left', canvasXPos.toString())
    window.scroll(0,0)


  $('#CtPaint').mousemove (event)->
    switch selectedTool.name
      when 'line'
        if mousePressed
          getMousePosition(event)
          canvasDataAsImage = new Image()
          canvasDataAsImage.onload = ->
            ctContext.drawImage(canvasDataAsImage,0,0)
            selectedTool.toolsAction(ctContext, colorsAtHand[0], oldX-(toolbarWidth+5), oldY-5, xSpot-(toolbarWidth+5), ySpot-5)
          canvasDataAsImage.src = canvasAsData
      when 'point'
        if mousePressed
          oldX = xSpot
          oldY = ySpot
          getMousePosition(event)
          selectedTool.toolsAction(ctContext, colorsAtHand[0], xSpot-(toolbarWidth+5), ySpot-5, oldX-(toolbarWidth+5), oldY-5)

  $('#CtPaint').mousedown (event)->
    mousePressed = true
    getMousePosition(event)
    switch selectedTool.name
      when 'line'
        oldX = xSpot
        oldY = ySpot
      when 'point'
       selectedTool.toolsAction(ctContext, colorsAtHand[0], xSpot-(toolbarWidth+5), ySpot-5, xSpot-(toolbarWidth+5), ySpot-5)

  $('#CtPaint').mouseup (event)->
    mousePressed = false
    switch selectedTool.name
      when 'line'
        canvasAsData = ctCanvas.toDataURL()
      when 'point'
        canvasAsData = ctCanvas.toDataURL()

  $('#toolbar0').mousedown (event)->
    getMousePosition(event)
    toolIndex = 0
    while toolIndex < numberOfTools
      if ctPaintTools[toolIndex].clickRegion[0]<xSpot and xSpot<(ctPaintTools[toolIndex].clickRegion[0]+buttonWidth)
        if ctPaintTools[toolIndex].clickRegion[1]<ySpot and ySpot<(ctPaintTools[toolIndex].clickRegion[1]+buttonHeight)
          selectedTool = ctPaintTools[toolIndex]
      toolIndex++
    drawToolbars()









