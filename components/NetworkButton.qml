import QtQuick
import Quickshell.Networking

Rectangle {
    id: root

    width: 45
    height: 23
    radius: 99

    color: "#f9e2af"

    Text {
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: -2

        text: {
            const device = Networking.devices.values[0]

            if (!device)
                return " "

            const connected = device.networks.values.find(n => n.connected)
                return connected ? " " : "󰤮 "
        }

        color: "#11111b"
        font.pixelSize: 18
        font.bold: true
    }
}

