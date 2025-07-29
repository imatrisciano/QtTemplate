import QtQuick
import QuickTemplate

Window {
    width: Constants.width
    height: Constants.height

    minimumWidth: 800
    minimumHeight: 600

    visible: true
    title: "QuickTemplate"

    MainScreen {
        anchors.fill: parent
    }
}
