// Copyright (C) 2026 Qt Group.
// SPDX-License-Identifier: LicenseRef-Qt-Commercial OR GPL-3.0-only

import QtQuick

Window {
    minimumWidth: 260
    minimumHeight: 380
    maximumWidth: minimumWidth
    maximumHeight: minimumHeight
    visible: true
    title: qsTr("Guitar Pedal")

    Image {
        source: "assets/Guitar-Pedal-Background.png"
        anchors.fill: parent
    }

    // Saves specifying margins for child items that are inset from the window edge.
    Item {
        anchors.fill: parent
        anchors.leftMargin: 15
        anchors.rightMargin: 15
        anchors.topMargin: 17
        anchors.bottomMargin: 17

        // Top-left screw.
        Image {
            source: "assets/Screw.png"
            anchors.left: parent.left
            anchors.top: parent.top
        }

        // Top-right screw.
        Image {
            source: "assets/Screw.png"
            anchors.right: parent.right
            anchors.top: parent.top
        }

        // Bottom-left screw.
        Image {
            source: "assets/Screw.png"
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }

        // Bottom-right screw.
        Image {
            source: "assets/Screw.png"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }
    }
}
