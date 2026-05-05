import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Wayland
import QtQuick

Scope {
    id: root

    // Bind the default sink so audio.volume / audio.muted are live
    PwObjectTracker {
        objects: Pipewire.defaultAudioSink ? [Pipewire.defaultAudioSink] : []
    }

    // Show OSD whenever volume or mute changes
    Connections {
        target: Pipewire.defaultAudioSink ? Pipewire.defaultAudioSink.audio : null
        enabled: Pipewire.defaultAudioSink !== null

        function onVolumeChanged() { osdWindow.show() }
        function onMutedChanged()  { osdWindow.show() }
    }

    // Auto-hide timer
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

            readonly property var  sink:   Pipewire.defaultAudioSink
            readonly property bool muted:  sink && sink.audio ? sink.audio.muted  : false
            readonly property real volume: sink && sink.audio ? sink.audio.volume : 0.0

            width: 320
            height: 78
            radius: 18
            color: "#cc1e1e2e"
            border.width: 1
            border.color: "#282c3a"

            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                    leftMargin: 16
                    rightMargin: 16
                }
                spacing: 7

                // Device name
                Text {
                    width: parent.width
                    text: card.sink ? (card.sink.description || card.sink.name || "Audio Output") : "Audio Output"
                    color: "#cdd6f4"
                    font.pixelSize: 13
                    font.bold: true
                    elide: Text.ElideRight
                }

                // Icon ── track ── icon
                Row {
                    width: parent.width
                    height: 24
                    spacing: 8

                    Text {
                        width: 22
                        anchors.verticalCenter: parent.verticalCenter
                        text: card.muted ? "🔇" : (card.volume < 0.33 ? "🔈" : "🔉")
                        font.pixelSize: 18
                    }

                    // Track
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
                            width: card.muted ? 0 : Math.min(card.volume, 1.0) * track.width
                            height: track.height
                            radius: 3
                            color: "#cdd6f4"

                            Behavior on width {
                                NumberAnimation { duration: 80; easing.type: Easing.OutCubic }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: mouse => {
                                if (card.sink && card.sink.audio)
                                    card.sink.audio.volume = mouse.x / track.width
                            }
                        }
                    }

                    Text {
                        width: 22
                        anchors.verticalCenter: parent.verticalCenter
                        text: "🔊"
                        font.pixelSize: 18
                    }
                }
            }
        }
    }
}
