import QtQuick 2.9
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.1
import QtQuick.Controls 2.2

Window {
    visible: true
    width: 640
    height: 480
    color: "#000000"
    title: qsTr("RS232")

    Connections {
        target: Laser

        onGetData: {
            terminal.append(""+data);
        }
    }

    Button {
        id: button_connect
        x: 37
        y: 26
        width: 120
        height: 40
        text: qsTr("Connect")
        contentItem: Text {
            text: button_connect.text
            color: "#000000"
            font.pointSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: Laser.openSerialPort()
        background: Rectangle {
            color: "#ffffff"
        }
    }

    Button {
        id: button_disconnect
        x: 180
        y: 26
        width: 120
        height: 40
        text: qsTr("Disconnect")
        contentItem: Text {
            text: button_disconnect.text
            color: "#000000"
            font.pointSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: Laser.closeSerialPort()
        background: Rectangle {
            color: "#ffffff"
        }
    }

    Button {
        id: button_write
        x: 322
        y: 26
        width: 120
        height: 40
        text: qsTr("Write")
        contentItem: Text {
            text: button_write.text
            color: "#000000"
            font.pointSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: {
            var str = "SR,00,130";
            terminal.append(str);
            Laser.writeData(str + "\r")
        }
        background: Rectangle {
            color: "#ffffff"
        }
    }

    Button {
        id: button_read
        x: 465
        y: 26
        width: 120
        height: 40
        text: qsTr("Read")
        contentItem: Text {
            text: button_read.text
            color: "#000000"
            font.pointSize: 15
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
        }
        onClicked: Laser.readData()
        background: Rectangle {
            color: "#ffffff"
        }
    }

    TextArea {
        id: terminal
        x: 37
        y: 124
        width: 548
        height: 318
        background: Rectangle {
            color: "#ffffff"
        }
    }
}
