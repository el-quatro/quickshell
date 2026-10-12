import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

Rectangle {
    id: workspaceContainer

    implicitWidth: workspacesLayout.implicitWidth + 16
    implicitHeight: 23

    radius: 19
    color: "#18181c"

    border.width: 1
    border.color: "#2b2b31"

    property int activeWorkspace:
        Hyprland.focusedWorkspace
            ? Hyprland.focusedWorkspace.id
            : 1

    property int firstWorkspace:
        Math.max(1, activeWorkspace - 2)

    RowLayout {
        id: workspacesLayout

        anchors.centerIn: parent
        spacing: 5

        Repeater {
            model: 3

            delegate: Rectangle {
                id: workspaceButton

                required property int index

                property int workspaceNum:
                    workspaceContainer.firstWorkspace + index

                property bool active:
                    workspaceNum === workspaceContainer.activeWorkspace

                property bool hovered: mouseArea.containsMouse

                Layout.preferredWidth: active ? 38 : 27
                Layout.preferredHeight: 16

                radius: 99

                color: {
                    if (active)
                        return "#f5f5f7"

                    if (hovered)
                        return "#35353c"

                    return "transparent"
                }

                border.width: active ? 0 : 1
                border.color: hovered
                    ? "#55555f"
                    : "#2e2e34"

                scale: hovered && !active ? 1.08 : 1.0

                Behavior on Layout.preferredWidth {
                    NumberAnimation {
                        duration: 220
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on scale {
                    NumberAnimation {
                        duration: 140
                        easing.type: Easing.OutCubic
                    }
                }

                Behavior on color {
                    ColorAnimation {
                        duration: 160
                    }
                }

                Text {
                    anchors.centerIn: parent

                    text: workspaceButton.workspaceNum

                    color: workspaceButton.active
                        ? "#111115"
                        : workspaceButton.hovered
                            ? "#ffffff"
                            : "#92929a"

                    font.pixelSize: workspaceButton.active ? 13 : 12
                    font.weight:
                        workspaceButton.active
                            ? Font.DemiBold
                            : Font.Medium

                    Behavior on color {
                        ColorAnimation {
                            duration: 150
                        }
                    }
                }

                // tiny active indicator
                Rectangle {
                    visible: workspaceButton.active

                    width:  5
                    height: 2
                    radius: 99

                    anchors {
                        horizontalCenter: parent.horizontalCenter
                        bottom: parent.bottom
                        bottomMargin: 0.5
                    }

                    color: "#111115"
                    opacity: 0.85
                }

                MouseArea {
                    id: mouseArea

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor

                    onClicked: {
                        Hyprland.dispatch(
                            "workspace " + workspaceButton.workspaceNum
                        )
                    }
                }
            }
        }
    }
}

