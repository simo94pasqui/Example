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

    ChartView {
        id: chart
        property var selected_Point: undefined
        title: "Two Series, Common Axes"
        anchors.fill: parent
        antialiasing: true
        theme: ChartView.ChartThemeDark
        property real toleranceX: 0.05
        property real toleranceY: 0.05

        ValueAxis {
            id: axisX
            min: 0
            max: 10
            tickCount: 5
        }

        ValueAxis {
            id: axisY
            min: -0.5
            max: 1.5
        }

        LineSeries {
            id: series1
            axisX: axisX
            axisY: axisY
            pointsVisible: true
        }

        MouseArea {
            anchors.fill: parent
            onPressed:
            {
                var cp = chart.mapToValue(Qt.point(mouse.x,mouse.y));
                for(var i = 0;i < series1.count;i ++)
                {
                    var p = series1.at(i);
                    if(Math.abs(cp.x - p.x) <= chart.toleranceX && Math.abs(cp.y - p.y) <= chart.toleranceY)
                    {
                        chart.selected_Point = p;
                        break;
                    }
                }
            }
            onPositionChanged: {
                if(chart.selected_Point != undefined) {
                    var p = Qt.point(mouse.x, mouse.y);
                    var cp = chart.mapToValue(p);
                    if(cp.x >= axisX.min && cp.x <= axisX.max && cp.y >= axisY.min && cp.y <= axisY.max) {
                        series1.replace(chart.selected_Point.x, chart.selected_Point.y, cp.x, cp.y);
                        chart.selected_Point = cp;
                    }
                }
            }

            onReleased: {
                chart.selected_Point = undefined;
            }
        }

    }
    // Add data dynamically to the series
    Component.onCompleted: {
        for (var i = 0; i <= 10; i++) {
            series1.append(i, Math.random());
        }
    }
}
