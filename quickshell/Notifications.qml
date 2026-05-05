import Quickshell
import Quickshell.Services.Notifications
import Quickshell.Wayland
import QtQuick
import "components"

Scope {
    id: root

    NotificationServer {
        id: notificationServer

        actionsSupported: false
        bodyImagesSupported: false
        bodyMarkupSupported: false
        bodyHyperlinksSupported: false
        imageSupported: true
        keepOnReload: true

        onNotification: notification.tracked = true
    }

    PanelWindow {
        id: notificationOverlay

        screen: Quickshell.screens[0]
        visible: notificationServer.trackedNotifications.values.length > 0
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

        implicitWidth: notificationColumn.width
        implicitHeight: notificationColumn.implicitHeight

        Column {
            id: notificationColumn

            width: 368
            spacing: 8

            Repeater {
                model: notificationServer.trackedNotifications

                delegate: NotificationCard {
                    required property var modelData

                    width: notificationColumn.width
                    notification: modelData
                }
            }
        }
    }
}
