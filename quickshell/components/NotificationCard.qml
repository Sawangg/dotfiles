import Quickshell
import QtQuick

Rectangle {
    id: root

    required property var notification

    readonly property color backgroundColor: {
        switch (notification.urgency) {
        case 2:
            return "#cc30212f"
        case 1:
            return "#cc282632"
        default:
            return "#cc1e1e2e"
        }
    }

    readonly property color borderColor: {
        switch (notification.urgency) {
        case 2:
            return "#66f38ba8"
        case 1:
            return "#40f9e2af"
        default:
            return "#282c3a"
        }
    }

    readonly property string iconSource: {
        if (notification.image.length > 0)
            return notification.image
        if (notification.appIcon.length > 0)
            return Quickshell.iconPath(notification.appIcon)
        return ""
    }

    readonly property string titleText: notification.summary || notification.appName || "Notification"
    readonly property string labelText: notification.appName || "Notification"
    readonly property string fallbackIconText: {
        const src = notification.appName || notification.summary || "N"
        return src.length > 0 ? src[0].toUpperCase() : "N"
    }

    readonly property int timeoutMs: {
        if (notification.resident || notification.expireTimeout === 0)
            return 0
        if (notification.expireTimeout > 0)
            return Math.round(notification.expireTimeout * 1000)
        return 5000
    }

    radius: 16
    color: backgroundColor
    border.width: 1
    border.color: borderColor
    implicitHeight: contentRow.implicitHeight + 24
    clip: true

    Row {
        id: contentRow

        anchors {
            left: parent.left
            right: parent.right
            top: parent.top
            margins: 12
        }
        spacing: 12

        Rectangle {
            id: iconPlate

            width: 42
            height: 42
            radius: 12
            color: "#313244"
            border.width: 1
            border.color: Qt.rgba(1, 1, 1, 0.06)
            clip: true

            Image {
                anchors.centerIn: parent
                width: parent.width - 10
                height: parent.height - 10
                source: root.iconSource
                visible: source.length > 0
                fillMode: root.notification.image.length > 0 ? Image.PreserveAspectCrop : Image.PreserveAspectFit
                asynchronous: true
                smooth: true
            }

            Text {
                anchors.centerIn: parent
                visible: root.iconSource.length === 0
                text: root.fallbackIconText
                color: "#cdd6f4"
                font.pixelSize: 16
                font.bold: true
            }
        }

        Column {
            id: textCol

            width: parent.width - iconPlate.width - closeButton.width - 24
            spacing: 3
            anchors.verticalCenter: iconPlate.verticalCenter

            Text {
                width: parent.width
                text: root.labelText
                color: "#a6adc8"
                font.pixelSize: 11
                font.weight: Font.Medium
                elide: Text.ElideRight
            }

            Text {
                width: parent.width
                text: root.titleText
                color: "#cdd6f4"
                font.pixelSize: 15
                font.bold: true
                wrapMode: Text.Wrap
                maximumLineCount: 2
                elide: Text.ElideRight
            }

            Text {
                width: parent.width
                text: root.notification.body
                visible: text.length > 0
                color: "#bac2de"
                font.pixelSize: 12
                wrapMode: Text.Wrap
                maximumLineCount: 2
                elide: Text.ElideRight
                textFormat: Text.PlainText
            }
        }

        Rectangle {
            id: closeButton

            width: 20
            height: 20
            radius: 10
            color: Qt.rgba(1, 1, 1, 0.06)
            anchors.verticalCenter: iconPlate.verticalCenter

            Text {
                anchors.centerIn: parent
                text: "✕"
                color: "#bac2de"
                font.pixelSize: 10
                font.bold: true
            }

            MouseArea {
                anchors.fill: parent
                onClicked: root.notification.dismiss()
            }
        }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        onEntered: expireTimer.stop()
        onExited: {
            if (expireTimer.interval > 0)
                expireTimer.restart()
        }
        onClicked: root.notification.dismiss()
    }

    Timer {
        id: expireTimer

        interval: root.timeoutMs
        running: interval > 0
        repeat: false
        onTriggered: root.notification.expire()
    }
}
