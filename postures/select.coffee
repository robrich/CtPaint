selectPosture = [
  # Mouse Move
  (event) ->
    if not areaSelected
      if mousePressed
        getMousePositionOnCanvas(event)
        sortedXs = [ Math.min(xSpot, oldX), Math.max(xSpot, oldX) ]
        sortedYs = [ Math.min(ySpot, oldY), Math.max(ySpot, oldY) ]

        boxInformation = (Math.abs(xSpot - oldX) + 1).toString() 
        boxInformation += 'px x '
        boxInformation += (Math.abs(ySpot - oldY) + 1).toString()
        boxInformation += 'px'
        drawInformation( event, boxInformation )

        originX = sortedXs[0] - 1
        originY = sortedYs[0] - 1
        otherSideX = sortedXs[1] + 1
        otherSideY = sortedYs[1] + 1
        canvasDataAsImage = new Image()
        canvasDataAsImage.onload = ->
          ctContext.drawImage(canvasDataAsImage,0,0)
          drawSelectBox(ctContext, originX, originY, otherSideX, otherSideY)
        canvasDataAsImage.src = cH[cH.length - 1]
      else
        drawInformation( event, boxInformation )
    else
      if mousePressed
        getMousePositionOnCanvas(event)
        xOffset = xSpot - oldX
        yOffset = ySpot - oldY
        gripX = selectionX + xOffset
        gripY = selectionY + yOffset
        rightEdge = gripX + selectionsWidth
        bottomEdge = gripY + selectionsHeight

        if (gripX isnt undefined) and (gripY isnt undefined)
          selectionOrigin = '(' + (gripX + '') + ', ' + (gripY + '') + ')'
          drawInformation( selectionOrigin )

        canvasDataAsImage = new Image()
        canvasDataAsImage.onload = ->
          ctContext.drawImage(canvasDataAsImage,0,0)
          ctContext.putImageData(selection, gripX, gripY)
          drawSelectBox(ctContext, gripX - 1, gripY - 1, rightEdge, bottomEdge)
        canvasDataAsImage.src = cH[cH.length - 1]
      else
        drawInformation( event, boxInformation )

  # Mouse down
  (event) ->
    mousePressed = true
    if not areaSelected
      getMousePositionOnCanvas(event)
      oldX = xSpot
      oldY = ySpot
    else
      getMousePositionOnCanvas(event)
      oldX = xSpot
      oldY = ySpot

      notTooFarLeft = selectionX < xSpot
      notTooFarRight = xSpot < (selectionX + selectionsWidth)
      withinXBoundaries = notTooFarLeft and notTooFarRight
      notTooLow = selectionY < ySpot
      notTooHigh = ySpot < (selectionY + selectionsHeight)
      withinYBoundaries = notTooLow and notTooHigh

      if not (withinXBoundaries and withinYBoundaries)
        areaSelected = false
        boxInformation = undefined
        canvasDataAsImage = new Image()
        canvasDataAsImage.onload = ->
          ctContext.drawImage(canvasDataAsImage,0,0)
          ctContext.putImageData(selection, selectionX, selectionY)
          historyUpdate()
        canvasDataAsImage.src = cH[cH.length - 1]

  # Mouse up
  (event) ->
    mousePressed = false
    if not areaSelected
      sortedXs = [ Math.min(xSpot, oldX), Math.max(xSpot, oldX) ]
      sortedYs = [ Math.min(ySpot, oldY), Math.max(ySpot, oldY) ]
      selectionsWidth = Math.abs(xSpot - oldX)
      selectionsHeight = Math.abs(ySpot - oldY)
      selectionX = sortedXs[0]
      selectionY = sortedYs[0]
      originX = selectionX - 1
      originY = selectionY - 1
      otherSideX = selectionX + selectionsWidth + 1
      otherSideY = selectionY + selectionsHeight + 1
      if 0 < selectionsWidth and 0 < selectionsHeight
        selection = 
          ctContext.getImageData( sortedXs[0], sortedYs[0], selectionsWidth, selectionsHeight)
        canvasDataAsImage = new Image()
        canvasDataAsImage.onload = ->
          ctContext.drawImage(canvasDataAsImage,0,0)
          squareAction(ctContext, colorSwatches[1], oldX, oldY, xSpot - 1, ySpot - 1, true)
          historyUpdate()
          ctContext.putImageData(selection, selectionX, selectionY)
          drawSelectBox(ctContext, originX, originY, otherSideX, otherSideY)
        canvasDataAsImage.src = cH[cH.length - 1]
        areaSelected = true
    else
      selectionX = gripX
      selectionY = gripY
  (event) ->
]

