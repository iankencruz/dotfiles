import QtQuick

Column {
    spacing: 2
    
    property var currentTime: new Date()
    
    // Timer to update the time
    Timer {
        interval: 60000  // Update every minute
        running: true
        repeat: true
        onTriggered: parent.currentTime = new Date()
    }
    
    Text {
        text: Qt.formatDateTime(parent.currentTime, "hh")
        color: "white"
        font.pixelSize: 16
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Text {
        text: Qt.formatDateTime(parent.currentTime, "mm")
        color: "white"
        font.pixelSize: 16
        font.bold: true
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Rectangle {
        width: 20
        height: 1
        color: "#444444"
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Text {
        text: Qt.formatDateTime(parent.currentTime, "dd")
        color: "#888888"
        font.pixelSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    Text {
        text: Qt.formatDateTime(parent.currentTime, "MM")
        color: "#888888"
        font.pixelSize: 12
        anchors.horizontalCenter: parent.horizontalCenter
    }
    
    MouseArea {
        anchors.fill: parent
        onClicked: {
            console.log("Time clicked:", Qt.formatDateTime(parent.currentTime, "ddd MMM d yyyy"))
        }
    }
}
