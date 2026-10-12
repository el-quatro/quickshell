import QtQuick

Rectangle {
    id: island

    width: 180
    height: 23
    radius: 99
    color: "#000000"

    property bool hovered: hover.hovered
    property date currentTime: new Date()

    Text {
        anchors.centerIn: parent

        text: Qt.formatTime(island.currentTime, "HH:mm")
        color: "white"

        font.pixelSize: 14
        font.bold: true
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            island.currentTime = new Date()
        }
    }

    HoverHandler {
        id: hover
    }
}

