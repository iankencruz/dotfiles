import QtQuick

Column {
    spacing: 0
    
    
    // Search/launcher button  
    Rectangle {
        id: settingsBtn
        width: 40
        height: 40
        radius: 20
        anchors.horizontalCenter: parent.horizontalCenter
        color: Qt.rgba(0.2, 0.2, 0.2, 0.85)
        border.color: Qt.rgba(0.4, 0.4, 0.4, 0.4)
        border.width: 1
        
        Text {
            anchors.centerIn: parent
            text: "⚙️"
            font.pixelSize: 16
        }
        
        states: [
            State {
                name: "hovered"
                when: mouseArea.containsMouse && !mouseArea.pressed
                PropertyChanges { 
                    target: settingsBtn
                    color: Qt.rgba(0.3, 0.3, 0.3, 0.9)
                    scale: 1.05
                }
            },
            State {
                name: "pressed"
                when: mouseArea.pressed
                PropertyChanges { 
                    target: settingsBtn
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
            id: settingsMouseArea
            anchors.fill: parent
            hoverEnabled: true
            onClicked: console.log("Settings clicked")
        }
    }


}
