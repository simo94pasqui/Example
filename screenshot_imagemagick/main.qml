import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Controls 1.4

Window {
    visible: true
    width: 640
    height: 480
    color: "#000000"
    title: qsTr("Hello World")

    Button {
        x: 242
        y: 155
        width: 156
        height: 112
        text: "screenshot"
        onClicked:{
            screenshot.takePicture()
        }
    }
}
