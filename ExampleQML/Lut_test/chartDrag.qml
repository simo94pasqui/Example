import QtQuick 2.0
import QtQuick.Window 2.14
import QtCharts 2.2

Window {
    id: window
    visible: true
    width: 400
    height: 300
    color: "#000000"
    title: "LUT"

    property point selectedPoint : ({})
    property int selectedIndex : 0

    ChartView {
        id: chartView
        anchors.fill: parent
        legend.visible: false
        antialiasing: true
        theme: ChartView.ChartThemeDark


        SplineSeries {
            id: scatterSeries0
            color: "blue";
            width: 3

            XYPoint { x: 0; y: 0}
            XYPoint { x: 0.2; y: 0.2}
            XYPoint { x: 0.4; y: 0.4 }
            XYPoint { x: 0.6; y: 0.6 }
            XYPoint { x: 0.8; y: 0.8 }
            XYPoint { x: 1; y: 1}

        }

        ScatterSeries {
            id: scatterSeries1
            color: "blue";
            markerSize: 25
            //borderWidth: 0
            borderColor: "blue"

            // nodes on top of lineseries
            function findindex(p1) {
                console.log("p1:"+p1)
                var minDist = 100
                var minIndex = -1
                for (var i=0; i<scatterSeries1.count; i++) {
                var p = scatterSeries1.at(i)
                console.log("p:"+p)
                var d = Math.sqrt(Math.pow(p.x-p1.x,2)+Math.pow(p.y-p1.y,2))
                console.log("d:"+d)
                if (d < minDist) { minDist = d; minIndex = i }
                }
                console.log("minIndex:"+minIndex+" minDist:"+minDist)
                return minIndex
            }

            XYPoint { x: 0; y: 0}
            XYPoint { x: 0.2; y: 0.2}
            XYPoint { x: 0.4; y: 0.4 }
            XYPoint { x: 0.6; y: 0.6 }
            XYPoint { x: 0.8; y: 0.8 }
            XYPoint { x: 1; y: 1}

            onClicked: {
                console.log("scatter onClicked: " + point);
                selectedIndex = findindex(point)
                selectedPoint = scatterSeries1.at(selectedIndex)

                console.log("map:"+chartView.mapToPosition(selectedPoint, scatterSeries1))

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)

            }


            Component.onCompleted: scatterSeries0.clone()
        }



        ScatterSeries {
            id: scatterSeriesHighlight
            color: "#80FF0000";
            markerSize: 50
        }

        ScatterSeries {
            id: scatterSeriesTop
            color: "#80808080";
            markerSize: 50
            markerShape: ScatterSeries.MarkerShapeRectangle
            onPressed: color = "#80101010"
            onReleased: color = "#80808080"

            XYPoint { x: 0.5; y:0.9 }

            onClicked: {
                console.log("top onclicked")

                scatterSeries1.remove(selectedIndex)
                selectedPoint.y=selectedPoint.y+0.1
                scatterSeries1.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeries0.remove(selectedIndex)
                scatterSeries0.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)
            }
        }

        ScatterSeries {
            id: scatterSeriesBottom
            color: "#80808080";
            markerSize: 50
            markerShape: ScatterSeries.MarkerShapeRectangle
            onPressed: color = "#80101010"
            onReleased: color = "#80808080"

            XYPoint { x: 0.5; y:0.1 }

            onClicked: {
                console.log("bottom onclicked")
                scatterSeries1.remove(selectedIndex)
                selectedPoint.y=selectedPoint.y-0.1
                scatterSeries1.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeries0.remove(selectedIndex)
                scatterSeries0.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)
            }

        }

        ScatterSeries {
            id: scatterSeriesLeft
            color: "#80808080";
            markerSize: 50
            markerShape: ScatterSeries.MarkerShapeRectangle
            onPressed: color = "#80101010"
            onReleased: color = "#80808080"

            XYPoint { x: 0.1; y:0.5 }


            onClicked: {
                console.log("left onclicked")

                scatterSeries1.remove(selectedIndex)
                selectedPoint.x=selectedPoint.x-0.1
                scatterSeries1.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeries0.remove(selectedIndex)
                scatterSeries0.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)
            }
        }

        ScatterSeries {
            id: scatterSeriesRight
            color: "#80808080";
            markerSize: 50
            markerShape: ScatterSeries.MarkerShapeRectangle
            onPressed: color = "#80101010"
            onReleased: color = "#80808080"

            XYPoint { x: 0.9; y:0.5 }

            onClicked: {
                console.log("right onclicked")

                scatterSeries1.remove(selectedIndex)
                selectedPoint.x=selectedPoint.x+0.1
                scatterSeries1.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeries0.remove(selectedIndex)
                scatterSeries0.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)
            }
        }

    }

}
