import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.2
import QtQuick.Controls.Styles 1.2

Window {
    visible: true
    width: 640
    height: 480

    ListModel {
        id: model
        ListElement {
            name: "Bill Jones"
            icon: "no_photo.png"
        }
        ListElement {
            name: "Jane Doe"
            icon: "no_photo.png"
        }
        ListElement {
            name: "John Smith"
            icon: "no_photo.png"
        }
        ListElement {
            name: "John PARR"
            icon: "no_photo.png"
        }
        ListElement {
            name: "SISI Smith"
            icon: "no_photo.png"
        }
        ListElement {
            name: "AHAHAHAH"
            icon: "no_photo.png"
        }
        ListElement {
            name: "CIAO"
            icon: "no_photo.png"
        }
    }

    Component {
        id: delegate
        Item {
            width: 200
            height: 200
            scale: PathView.iconScale
            opacity: PathView.iconOpacity
            z: PathView.iconOrder
            Button {
                id: btn_PhotoPer
                visible: true//false
                width: 170
                height: 170
                background: Rectangle{
                    id: bg_photoper
                    implicitWidth: btn_PhotoPer.width
                    implicitHeight: btn_PhotoPer.height
                    border.width: 5
                }
                Image {
                    id: img_PhotoPer
                    width: btn_PhotoPer.width
                    height: btn_PhotoPer.height
                    source: icon
                    fillMode: Image.PreserveAspectFit //PreserveAspectCrop
                    cache: false
                    visible: true
                }
                onClicked: {
                    console.log("CIAO SONO " + name)
                }
            }
            Text {
                id: nametxt
                text: name
            }
        }
    }

    PathView {
        id: pathview_img
        height: 228
        anchors.right: parent.right
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: 52
        anchors.leftMargin: 52
        anchors.topMargin: 126
        preferredHighlightBegin: 0.5
        preferredHighlightEnd: 0.5
        highlightRangeMode: PathView.StrictlyEnforceRange
        Keys.onRightPressed: if (!moving) incrementCurrentIndex()
        Keys.onLeftPressed: if (!moving) decrementCurrentIndex()
        model: model
        delegate: delegate
        path: Path {
            startX: 0; startY: pathview_img.height/2
            PathAttribute { name: "iconScale"; value: 0.2 }
            PathAttribute { name: "iconOpacity"; value: 10.2 }
            PathAttribute { name: "iconOrder"; value: 0 }
            PathLine {x: pathview_img.width / 2; y: pathview_img.height/2 }
            PathAttribute { name: "iconScale"; value: 1.2 }
            PathAttribute { name: "iconOpacity"; value: 1 }
            PathAttribute { name: "iconOrder"; value: 8 }
            PathLine {x: pathview_img.width; y: pathview_img.height/2 }
        }
    }

    Button {
        id: btn_clickchangeimg
        x: 210
        y: 416
        visible: true//false
        width: 109
        height: 44
        text: "change img"
        onClicked: {
            model.setProperty(0, "icon", "oring_1.png")
            model.setProperty(1, "icon", "oring_1.png")
            model.setProperty(2, "icon", "oring_1.png")
            model.setProperty(3, "icon", "oring_1.png")
            model.setProperty(4, "icon", "oring_1.png")
            model.setProperty(5, "icon", "oring_1.png")
            model.setProperty(6, "icon", "oring_1.png")
        }
    }

    Button {
        id: btn_clickhide
        x: 338
        y: 416
        visible: true//false
        width: 96
        height: 44
        text: "hide"
        onClicked: {
            pathview_img.visible = false
        }
    }
}
