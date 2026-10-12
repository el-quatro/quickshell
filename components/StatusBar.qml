import QtQuick
import QtQuick.Shapes
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

PanelWindow {
    id: root

    WlrLayershell.namespace: "quickshell"

    property bool open: false


    // property int itemWidth: 42
    // property int itemHeight: 30
    // property int itemRadius: 99
    // property int itempixelSize: 18


    property real barH: 35
    property real menuW: 600
    property real menuH: 220
    property real menuLeft: (width - menuW) / 2
    property real menuRight: menuLeft + menuW

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 280
    exclusiveZone: 36
    aboveWindows: true

    color: "transparent"

    margins {
        top: 5
        left: 7
        right: 7
    }

    Shape {
        id: shellShape
        
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: root.open
            ? root.barH + root.menuH
            : root.barH

        preferredRendererType: Shape.CurveRenderer

        ShapePath {
            fillColor: Qt.rgba(0.094, 0.094, 0.0145, 0.15)
            strokeColor: "#45475a"
            strokeWidth: 1

            startX: 18
            startY: 0

            // Top
            PathLine {
                x: root.width - 18
                y: 0
            }

            // Top-right
            PathQuad {
                x: root.width
                y: 18
                controlX: root.width
                controlY: 0
            }

            PathLine {
                x: root.width
                y: root.barH - 18
            }

            // Bottom-right
            PathQuad {
                x: root.width - 18
                y: root.barH
                controlX: root.width
                controlY: root.barH
            }

            // Bar -> right side of island expansion
            PathLine {
                x: root.open ? root.menuRight + 22 : 18
                y: root.barH
            }

            PathCubic {
                x: root.open ? root.menuRight : 18
                y: root.open ? root.barH + 22 : root.barH

                control1X: root.open ? root.menuRight + 10 : 18
                control1Y: root.barH

                control2X: root.open ? root.menuRight : 18
                control2Y: root.open ? root.barH + 10 : root.barH
            }

            // Right wall
            PathLine {
                x: root.open ? root.menuRight : 18
                y: root.open
                    ? root.barH + root.menuH - 20
                    : root.barH
            }

            // Bottom-right
            PathQuad {
                x: root.open ? root.menuRight - 20 : 18
                y: root.open ? root.barH + root.menuH : root.barH

                controlX: root.open ? root.menuRight : 18
                controlY: root.open
                    ? root.barH + root.menuH
                    : root.barH
            }

            // Bottom
            PathLine {
                x: root.open ? root.menuLeft + 20 : 18
                y: root.open ? root.barH + root.menuH : root.barH
            }

            // Bottom-left
            PathQuad {
                x: root.open ? root.menuLeft : 18
                y: root.open
                    ? root.barH + root.menuH - 20
                    : root.barH

                controlX: root.open ? root.menuLeft : 18
                controlY: root.open
                    ? root.barH + root.menuH
                    : root.barH
            }

            // Left wall
            PathLine {
                x: root.open ? root.menuLeft : 18
                y: root.open ? root.barH + 22 : root.barH
            }

            // Left side -> bar
            PathCubic {
                x: root.open ? root.menuLeft - 22 : 18
                y: root.barH

                control1X: root.open ? root.menuLeft : 18
                control1Y: root.open
                    ? root.barH + 10
                    : root.barH

                control2X: root.open
                    ? root.menuLeft - 10
                    : 18

                control2Y: root.barH
            }

            // Finish bottom of bar
            PathLine {
                x: 18
                y: root.barH
            }

            // Bottom-left bar corner
            PathQuad {
                x: 0
                y: root.barH - 18
                controlX: 0
                controlY: root.barH
            }

            PathLine {
                x: 0
                y: 18
            }

            // Top-left
            PathQuad {
                x: 18
                y: 0
                controlX: 0
                controlY: 0
            }
        }
    }



    Item {
        id: barContent

        z: 10

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }

        height: root.barH




        Island {
            id: island

            anchors {
                horizontalCenter: parent.horizontalCenter
                verticalCenter: parent.verticalCenter
            }

            onHoveredChanged: {
                root.open = hovered
            }
        }


        Speaker {
            id: speaker

            anchors {
                right: parent.right
                rightMargin: 20
                verticalCenter: parent.verticalCenter
            }
        }

        Battery {
            id: battery

            anchors {
                right: speaker.left
                rightMargin: 10
                verticalCenter: parent.verticalCenter
            }
        }

        NetworkButton {
            id: network

            anchors {
                right: battery.left
                rightMargin: 10
                verticalCenter: parent.verticalCenter
            }
        }

        Workspace {
            id: workspace

            anchors {
                left: parent.left
                leftMargin: 10
                verticalCenter: parent.verticalCenter
            }
        }
    }
}



