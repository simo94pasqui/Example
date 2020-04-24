import QtQuick 2.9
import QtQuick.Window 2.2
import QtCharts 2.2
import QtQuick.Controls 2.2

Window {
    id: window
    visible: true
    width: 640
    height: 550
    color: "#000000"
    title: "LUT"
    property var selectedPoint : ({})
    property int selectedIndex : 0

    Component.onCompleted: {
        createChart()
    }

    function createChart(){
        lineseries_lut.removePoints(0, 6)
        scatterseries_lut.removePoints(0, 6)
        for(var i=0; i<6; i++)
        {
            lineseries_lut.append(i*51, i*51)
            scatterseries_lut.append(i*51, i*51)
        }
        lineseries_lut.pointsReplaced()
        scatterseries_lut.pointsReplaced()
    }

    ChartView {
        id: chart_lut
        width: 640
        height: 480
        anchors.bottomMargin: 121
        anchors.fill: parent
        antialiasing: true
        legend.visible: false
        theme: ChartView.ChartThemeDark
        property real toleranceX: 6 //da aumentare nel caso risulti difficile muovere i punti
        property real toleranceY: 6 //da aumentare nel caso risulti difficile muovere i punti
        property var selected_Point: undefined

        ValueAxis{
            id: valueAxis_x
            tickCount : 6
            onRangeChanged: {
                valueAxis_x.min = 0
                valueAxis_x.max = 255
            }
        }

        ValueAxis{
            id: valueAxis_y
            onRangeChanged: {
                valueAxis_y.min = 0
                valueAxis_y.max = 255
            }
        }

        LineSeries {
            id: lineseries_lut
            width: 4
            color: "red"
            axisX: valueAxis_x
            axisY: valueAxis_y
        }

        ScatterSeries {
            id: scatterSeriesHighlight
            color: "#80FF0000";
            markerSize: 30
        }

        ScatterSeries {
            id: scatterseries_lut
            axisX: valueAxis_x
            axisY: valueAxis_y
            color: "red"
            borderColor: "red"
            markerSize: 20
        }

        MouseArea {
            anchors.fill: parent

            onPressed:
            {
                var cp = chart_lut.mapToValue(Qt.point(mouse.x,mouse.y));
                for(var i = 0;i < scatterseries_lut.count;i ++)
                {
                    var p = scatterseries_lut.at(i);
                    if(Math.abs(cp.x - p.x) <= chart_lut.toleranceX && Math.abs(cp.y - p.y) <= chart_lut.toleranceY)
                    {
                        chart_lut.selected_Point = p;
                        selectedPoint = p
                        selectedIndex = i
                        textField_y.text = (p.y).toFixed(0)
                        text_X.text = "X: " + (p.x).toFixed(0)
                        scatterSeriesHighlight.clear()
                        scatterSeriesHighlight.append(p.x, p.y)
                        //console.log("Point Select " + chart_lut.selected_Point)
                        break;
                    }
                }
            }

            onPositionChanged: {
                if(chart_lut.selected_Point != undefined) {
                    var p = Qt.point(mouse.x, mouse.y);
                    var cp = chart_lut.mapToValue(p);
                    if(cp.x >= valueAxis_x.min && cp.x <= valueAxis_x.max && cp.y >= valueAxis_y.min && cp.y <= valueAxis_y.max)
                    {
                        lineseries_lut.remove(selectedIndex)
                        scatterseries_lut.remove(selectedIndex)

                        lineseries_lut.insert(selectedIndex, selectedPoint.x, cp.y)    //se vuoi: selectedPoint.x => cp.x
                        scatterseries_lut.insert(selectedIndex, selectedPoint.x, cp.y) //se vuoi: selectedPoint.x => cp.x

                        scatterSeriesHighlight.clear()
                        scatterSeriesHighlight.append(selectedPoint.x, cp.y) //se vuoi: selectedPoint.x => cp.x

                        textField_y.text = (cp.y).toFixed(0)
                        text_X.text = "X: " + (selectedPoint.x).toFixed(0)
                        chart_lut.selected_Point = cp;
                    }
                }
            }

            onReleased: {
                chart_lut.selected_Point = undefined;
            }
        }
    }

    Text {
        id: text_X
        x: 17
        y: 455
        color: "#ffffff"
        text: qsTr("X:")
        font.pixelSize: 12
        anchors.bottomMargin: 80
        anchors.bottom: parent.bottom
    }

    Text {
        id: text_Y
        x: 17
        y: 476
        color: "#ffffff"
        text: qsTr("Y:")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 59
        font.pixelSize: 12
    }

    Button {
        id: button_down
        x: 17
        y: 497
        width: 40
        height: 40
        text: qsTr("-")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 13

        signal pressAndHold()

        function downEvent(){
            if(selectedPoint.y>0){
                lineseries_lut.remove(selectedIndex)
                scatterseries_lut.remove(selectedIndex)

                selectedPoint.y  = selectedPoint.y-1
                textField_y.text = selectedPoint.y

                lineseries_lut.insert(selectedIndex, selectedPoint.x, selectedPoint.y)
                scatterseries_lut.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)
            }
        }

        Timer {
            id: longPressDown

            interval: 100
            repeat: true
            running: false

            onTriggered: {
                button_down.downEvent()
            }
        }

        onClicked: downEvent()

        onPressedChanged: {
            if ( pressed ) {
                longPressDown.running = true;
            } else {
                longPressDown.running = false;
            }
        }
    }

    Button {
        id: button_up
        x: 135
        y: 497
        width: 40
        height: 40
        text: qsTr("+")
        anchors.bottomMargin: 13
        anchors.bottom: parent.bottom

        signal pressAndHold()

        function upEvent(){
            if(selectedPoint.y<255){
                lineseries_lut.remove(selectedIndex)
                scatterseries_lut.remove(selectedIndex)

                selectedPoint.y  = selectedPoint.y+1
                textField_y.text = selectedPoint.y

                lineseries_lut.insert(selectedIndex, selectedPoint.x, selectedPoint.y)
                scatterseries_lut.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)
            }
        }

        Timer {
            id: longPressUp

            interval: 100
            repeat: true
            running: false

            onTriggered: {
                button_up.upEvent()
            }
        }

        onClicked: upEvent()

        onPressedChanged: {
            if ( pressed ) {
                longPressUp.running = true;
            } else {
                longPressUp.running = false;
            }
        }
    }

    TextField {
        id: textField_y
        x: 56
        y: 497
        width: 80
        height: 40
        text: qsTr("")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 13
        horizontalAlignment: Text.AlignHCenter
        inputMethodHints: Qt.ImhDigitsOnly
        validator: IntValidator { bottom: 000; top: 255}
        onAccepted: {
            if(selectedPoint.y<=255 && selectedPoint.y>=0){
                lineseries_lut.remove(selectedIndex)
                scatterseries_lut.remove(selectedIndex)

                selectedPoint.y=textField_y.text

                lineseries_lut.insert(selectedIndex, selectedPoint.x, selectedPoint.y)
                scatterseries_lut.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)
            }
        }
        onTextChanged: {
            if(!textField_y.acceptableInput)
                text = 0
        }
    }

    Button {
        id: button_invio
        x: 223
        y: 497
        text: qsTr("Invio")
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 13
        onClicked: {
            if(selectedPoint.y<=255 && selectedPoint.y>=0){
                lineseries_lut.remove(selectedIndex)
                scatterseries_lut.remove(selectedIndex)

                selectedPoint.y=textField_y.text

                lineseries_lut.insert(selectedIndex, selectedPoint.x, selectedPoint.y)
                scatterseries_lut.insert(selectedIndex, selectedPoint.x, selectedPoint.y)

                scatterSeriesHighlight.clear()
                scatterSeriesHighlight.append(selectedPoint.x, selectedPoint.y)
            }
        }
    }
}
