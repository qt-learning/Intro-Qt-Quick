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

    component SwitchImage: Image {
        required property string sourceBaseName
        property bool checked

        source: `assets/${sourceBaseName}${checked ? "-Checked" : ""}.png`
    }

    component DeviceSwitch: SwitchImage {
        property alias tapMargin: tapHandler.margin

        TapHandler {
            id: tapHandler
            onTapped: parent.checked = !parent.checked
        }
    }

    // Standby/on LED.
    SwitchImage {
        x: parent.width * 0.33 - width / 2
        y: 14
        sourceBaseName: "LED"
        checked: footPedal.checked

        DeviceText {
            text: qsTr("CHECK")
            anchors.top: parent.bottom
            anchors.topMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    // Mode switch.
    DeviceSwitch {
        x: parent.width * 0.66 - width / 2
        y: 14
        sourceBaseName: "Switch"
        // The image is quite narrow, so give the user a larger
        // area with which to click on the switch.
        tapMargin: 16

        DeviceText {
            text: qsTr("MODE")
            anchors.top: parent.bottom
            anchors.topMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
        }
    }

    // Foot switch.
    DeviceSwitch {
        id: footPedal
        sourceBaseName: "Button-Pedal"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 17
        anchors.horizontalCenter: parent.horizontalCenter
    }

    component DeviceDial: Image {
        id: dial
        source: "assets/Knob-Markings.png"

        property alias text: dialLabel.text

        property int value
        property real angle

        readonly property int minimumValue: 0
        readonly property int maximumValue: 100
        readonly property int range: dial.maximumValue - dial.minimumValue

        Image {
            source: "assets/Knob-Dial.png"
            anchors.centerIn: parent
            rotation: dial.angle
        }

        DeviceText {
            id: dialLabel
            anchors.top: dial.bottom
            anchors.horizontalCenter: dial.horizontalCenter
        }

        DeviceText {
            text: qsTr("MIN")
            anchors.left: dial.left
            anchors.bottom: dial.bottom
            font.pixelSize: 6
        }

        DeviceText {
            text: qsTr("MAX")
            anchors.right: dial.right
            anchors.bottom: dial.bottom
            font.pixelSize: 6
        }

        DragHandler {
            target: null
            onCentroidChanged: updateValueAndRotation()

            function updateValueAndRotation() {
                if (centroid.pressedButtons !== Qt.LeftButton) {
                    return
                }

                const startAngle = -140
                const endAngle = 140

                const yy = dial.height / 2.0 - centroid.position.y
                const xx = centroid.position.x - dial.width / 2.0

                const radianAngle = Math.atan2(yy, xx)
                let newAngle = (-radianAngle / Math.PI * 180) + 90

                newAngle = ((newAngle - dial.angle + 180) % 360) + dial.angle - 180

                dial.angle = Math.max(startAngle, Math.min(newAngle, endAngle))
                dial.value = (dial.angle - startAngle) / (endAngle - startAngle) * dial.range

                console.log("angle: ", dial.angle, "value: ", dial.value)
            }
        }
    }

    DeviceDial {
        anchors.left: footPedal.left
        y: 147 - height / 2
        text: qsTr("TIME")
    }

    DeviceDial {
        anchors.horizontalCenter: parent.horizontalCenter
        y: 67 - height / 2
        text: qsTr("LEVEL")
    }

    DeviceDial {
        anchors.right: footPedal.right
        y: 147 - height / 2
        text: qsTr("FEEDBACK")
    }
}
