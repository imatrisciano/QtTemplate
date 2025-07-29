
/*
This is a UI file (.ui.qml) that is intended to be edited in Qt Design Studio only.
It is supposed to be strictly declarative and only uses a subset of QML. If you edit
this file manually, you might introduce QML code that is not supported by Qt Design Studio.
Check out https://doc.qt.io/qtcreator/creator-quick-ui-forms.html for details on .ui.qml files.
*/
import QtQuick

import QtQuick.Controls.Material
import QtQuick.Controls
import QtQuick.Layouts
import QuickTemplate
import Backend
import QtQml

Pane {
    id: root
    Material.theme: darkModeToggle.checked ? Material.Dark : Material.Light

    readonly property bool mobile: Qt.platform.os === "android"
    readonly property bool horizontal: width > height
    readonly property real buttonMinWidth: 65

    leftPadding: 60
    rightPadding: 60
    topPadding: 50
    bottomPadding: 50

    width: 800
    height: 600
    state: "mobileHorizontal"

    Backend {
        id: backend
        temperature: someSlider.value
    }

    ColumnLayout {
        id: slidersColumn
        x: 0
        y: 88
        width: 298
        height: 412
        spacing: 20
        anchors.fill: parent

        Toggle {
            id: darkModeToggle
            text: qsTr("Dark mode")
            Layout.alignment: horizontalCenter
        }

        LabeledSlider {
            id: someSlider
            Layout.minimumWidth: 160
            labelText: "Temperature target"
            from: -90
            to: 90
            Layout.fillWidth: true
            //value: backend.temperature
            value: 30
        }
        LabeledSlider {
            id: currentTemperature
            Layout.preferredWidth: parent.width
            Layout.minimumWidth: 160
            labelText: "Current temperature"
            from: -90
            to: 90
            Layout.fillWidth: true
            value: backend.temperature
            enabled: false
        }

        Button {
            id: someButton
            Layout.preferredWidth: parent.width
            height: 52
            text: qsTr("Click me")
            Layout.minimumWidth: root.buttonMinWidth
            Layout.preferredHeight: 45

            Connections {
                target: someButton
                onClicked: {
                    console.log("Button clicked")
                    someSlider.value = 0

                    backend.someFunction("value from the button")
                }
            }
        }

        Label {
            id: lblStatus
            text: qsTr("Status: ") + backend.status
            font.italic: true
            Layout.alignment: horizontalCenter
        }
    }

    Item {
        id: __materialLibrary__
    }

    Connections {
        target: backend
        function onObjectNameChanged() {
            console.log("clicked")
        }
    }

    states: [
        State {
            name: "mobileHorizontal"
            when: root.mobile && root.horizontal

            PropertyChanges {
                target: root
                leftPadding: 45
                topPadding: 15
                bottomPadding: 0
                buttonRowWidth: width * 0.2
                buttonMinWidth: 75
            }
        },
        State {
            name: "desktopVertical"
            when: !root.mobile && !root.horizontal

            PropertyChanges {
                target: root
                bottomPadding: 20
            }
            AnchorChanges {
                target: slidersColumn
                anchors.right: parent.right
            }
            PropertyChanges {
                target: slidersColumn
                anchors.rightMargin: 20
            }


            /*
            AnchorChanges {
                target: buttonsRow
                anchors.bottom: undefined
                anchors.top: slidersColumn.top
            }
            */
        },
        State {
            name: "mobileVertical"
            when: root.mobile && !root.horizontal

            PropertyChanges {
                target: root
                topPadding: 15
                leftPadding: 45
                bottomPadding: 0
                buttonMinWidth: 75
            }
        }
    ]

    transitions: Transition {
        PropertyAnimation {
            properties: "scale.x, scale.y, scale.z, y, z"
        }
        AnchorAnimation {}
    }
}
