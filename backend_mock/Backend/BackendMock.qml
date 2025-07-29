import QtQuick

QtObject {
    property int temperature: 0
    readonly property string status: "Mocked Status"

    function someFunction(msg) {
        console.log("Mocked call to someFunction with value " + msg)
    }

    Behavior on temperature {
        SmoothedAnimation {
            velocity: 20
        }
    }
}
