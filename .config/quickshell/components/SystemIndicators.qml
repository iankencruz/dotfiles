import QtQuick

Column {
    spacing: 8
    
    // Volume indicator
    Rectangle {
        id: volumeBtn
        width: 40
        height: 40
        radius: 20
        anchors.horizontalCenter: parent.horizontalCenter
        color: Qt.rgba(0.2, 0.2, 0.2, 0.85)
        border.color: Qt.rgba(0.4, 0.4, 0.4, 0.4)
        border.width: 1
        
        Text {
            anchors.centerIn: parent
            text: "🔊"
            font.pixelSize: 16
        }
        
        states: [
            State {
                name: "hovered"
                when: mouseArea.containsMouse && !mouseArea.pressed
                PropertyChanges { 
                    target: volumeBtn
                    color: Qt.rgba(0.3, 0.3, 0.3, 0.9)
                    scale: 1.05
                }
            },
            State {
                name: "pressed" 
                when: mouseArea.pressed
                PropertyChanges { 
                    target: volumeBtn
                    scale: 0.95
                }
            }
        ]
        
        transitions: Transition {
            PropertyAnimation { 
                properties: "color,scale"
                duration: 150
                easing.type: Easing.OutQuad
            }
        }
        
        MouseArea {
            id: volumeMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: console.log("Volume clicked")
        }
    }
    
    // Network indicator
    Rectangle {
        id: networkBtn
        width: 40
        height: 40
        radius: 20
        anchors.horizontalCenter: parent.horizontalCenter
        color: Qt.rgba(0.2, 0.2, 0.2, 0.85)
        border.color: Qt.rgba(0.4, 0.4, 0.4, 0.4)
        border.width: 1
        
        Text {
            anchors.centerIn: parent
            text: "📶"
            font.pixelSize: 16
        }
        
        states: [
            State {
                name: "hovered"
                when: mouseArea.containsMouse && !mouseArea.pressed
                PropertyChanges { 
                    target: networkBtn
                    color: Qt.rgba(0.3, 0.3, 0.3, 0.9)
                    scale: 1.05
                }
            },
            State {
                name: "pressed"
                when: mouseArea.pressed
                PropertyChanges { 
                    target: networkBtn
                    scale: 0.95
                }
            }
        ]
        
        transitions: Transition {
            PropertyAnimation { 
                properties: "color,scale"
                duration: 150
                easing.type: Easing.OutQuad
            }
        }
        
        MouseArea {
            id: networkMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: console.log("Network clicked")
        }
    }
    
    // Bluetooth indicator
    Rectangle {
        id: bluetoothBtn
        width: 40
        height: 40
        radius: 20
        anchors.horizontalCenter: parent.horizontalCenter
        color: Qt.rgba(0.2, 0.2, 0.2, 0.85)
        border.color: Qt.rgba(0.4, 0.4, 0.4, 0.4)
        border.width: 1
        
        Text {
            anchors.centerIn: parent
            text: "🔵"
            font.pixelSize: 16
        }
        
        states: [
            State {
                name: "hovered"
                when: mouseArea.containsMouse && !mouseArea.pressed
                PropertyChanges { 
                    target: bluetoothBtn
                    color: Qt.rgba(0.3, 0.3, 0.3, 0.9)
                    scale: 1.05
                }
            },
            State {
                name: "pressed"
                when: mouseArea.pressed
                PropertyChanges { 
                    target: bluetoothBtn
                    scale: 0.95
                }
            }
        ]
        
        transitions: Transition {
            PropertyAnimation { 
                properties: "color,scale"
                duration: 150
                easing.type: Easing.OutQuad
            }
        }
        
        MouseArea {
            id: bluetoothMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: console.log("Bluetooth clicked")
        }
    }
    
    // Battery indicator
    Rectangle {
        id: batteryBtn
        width: 40
        height: 40
        radius: 20
        anchors.horizontalCenter: parent.horizontalCenter
        color: Qt.rgba(0.2, 0.2, 0.2, 0.85)
        border.color: Qt.rgba(0.4, 0.4, 0.4, 0.4)
        border.width: 1
        
        Text {
            anchors.centerIn: parent
            text: "🔋"
            font.pixelSize: 16
        }
        
        // Small percentage indicator
        Text {
            anchors {
                bottom: parent.bottom
                right: parent.right
                margins: 4
            }
            text: "85"  // Could be dynamic later
            color: "#95a5a6"
            font.pixelSize: 8
            font.bold: true
        }
        
        states: [
            State {
                name: "hovered"
                when: mouseArea.containsMouse && !mouseArea.pressed
                PropertyChanges { 
                    target: batteryBtn
                    color: Qt.rgba(0.3, 0.3, 0.3, 0.9)
                    scale: 1.05
                }
            },
            State {
                name: "pressed"
                when: mouseArea.pressed
                PropertyChanges { 
                    target: batteryBtn
                    scale: 0.95
                }
            }
        ]
        
        transitions: Transition {
            PropertyAnimation { 
                properties: "color,scale"
                duration: 150
                easing.type: Easing.OutQuad
            }
        }
        
        MouseArea {
            id: batteryMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: console.log("Battery clicked")
        }
    }
}
