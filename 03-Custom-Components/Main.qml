import QtQuick

Window {
    minimumWidth: 260
    minimumHeight: 380
    maximumWidth: minimumWidth
    maximumHeight: minimumHeight
    visible: true
    title: qsTr("Guitar Pedal")

    FontLoader {
        id: russoFontLoader
        source: "fonts/RussoOne-Regular.ttf"
    }

    FontLoader {
        id: prismaFontLoader
        source: "fonts/Prisma.ttf"
    }

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

        component ScrewImage: Image {
            source: "assets/Screw.png"
        }

        // Top-left screw.
        ScrewImage {
            anchors.left: parent.left
            anchors.top: parent.top
        }

        // Top-right screw.
        ScrewImage {
            anchors.right: parent.right
            anchors.top: parent.top
        }

        // Bottom-left screw.
        ScrewImage {
            anchors.left: parent.left
            anchors.bottom: parent.bottom
        }

        // Bottom-right screw.
        ScrewImage {
            anchors.right: parent.right
            anchors.bottom: parent.bottom
        }

        // Customized text for static labels.
        component DeviceText: Text {
            color: "#191919"
            font.family: russoFontLoader.font.family
            font.weight: russoFontLoader.font.weight
            font.pixelSize: 9
        }

        component InfoText: Column {
            id: infoLabel
            spacing: 5

            property alias text: label.text
            property alias font: label.font
            property int lineWidth: 200
            property int lineHeight: 2
            property color lineColor: "#191919"

            Rectangle {
                width: infoLabel.lineWidth
                height: infoLabel.lineHeight
                color: infoLabel.lineColor
            }

            DeviceText {
                id: label
                anchors.horizontalCenter: infoLabel.horizontalCenter
            }

            Rectangle {
                width: infoLabel.lineWidth
                height: infoLabel.lineHeight
                color: infoLabel.lineColor
            }
        }

        // Brand Label
        InfoText {
            text: qsTr("TIME BLENDER")
            anchors.top: parent.verticalCenter
            anchors.topMargin: 16
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 10
            font.family: prismaFontLoader.font.family
            font.pixelSize: 18
        }

        // Input Label
        InfoText {
            text: qsTr("IN")
            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.right: parent.right
            lineWidth: 30
            lineHeight: 2
        }

        // Output label
        InfoText {
            anchors.top: parent.top
            anchors.topMargin: 60
            anchors.left: parent.left
            text: qsTr("OUT")
            lineWidth: 30
            lineHeight: 2
        }
    }
}
