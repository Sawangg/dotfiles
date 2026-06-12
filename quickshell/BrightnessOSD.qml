import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick

Scope {
    id: root

    property real brightness: 0.0
    property real prevBrightness: -1.0

    Process {
        id: brightnessReader
        command: ["brightnessctl", "-m"]
        running: true
        stdout: StdioCollector {
            onStreamFinished: {
                var parts = this.text.trim().split(",")
                if (parts.length >= 5) {
                    var pct = parseFloat(parts[3])
                    if (!isNaN(pct)) {
                        root.brightness = pct / 100.0
                        if (root.prevBrightness >= 0 && root.brightness !== root.prevBrightness) {
                            osdWindow.show()
                        }
                        root.prevBrightness = root.brightness
                    }
                }
            }
        }
        onRunningChanged: if (!running) running = true
    }

    Timer {
        id: hideTimer
        interval: 2000
        repeat: false
        onTriggered: osdWindow.visible = false
    }

    PanelWindow {
        id: osdWindow

        screen: Quickshell.screens[0]
        visible: false
        aboveWindows: true
        color: "transparent"
        surfaceFormat.opaque: false

        anchors {
            top: true
            right: true
        }
        margins {
            top: 24
            right: 24
        }

        implicitWidth: card.width
        implicitHeight: card.height

        function show() {
            visible = true
            hideTimer.restart()
        }

        Rectangle {
            id: card

            width: 320
            height: 60
            radius: 18
            color: "#cc1e1e2e"
            border.width: 1
            border.color: "#282c3a"

            Row {
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    leftMargin: 16
                    rightMargin: 16
                }
                spacing: 8

                Text {
                    width: 22
                    anchors.verticalCenter: parent.verticalCenter
                    text: "☀"
                    font.pixelSize: 16
                    color: "#cdd6f4"
                }

                Item {
                    id: track
                    width: parent.width - 60
                    height: 6
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        anchors.fill: parent
                        radius: 3
                        color: Qt.rgba(1, 1, 1, 0.15)
                    }

                    Rectangle {
                        width: Math.min(root.brightness, 1.0) * track.width
                        height: track.height
                        radius: 3
                        color: "#cdd6f4"

                        Behavior on width {
                            NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
                        }
                    }
                }

                Text {
                    width: 22
                    anchors.verticalCenter: parent.verticalCenter
                    text: "☀"
                    font.pixelSize: 22
                    color: "#cdd6f4"
                }
            }
        }
    }
}
