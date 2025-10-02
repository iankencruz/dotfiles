import QtQuick
import Quickshell.Io

Item {
    height: 48
    
    // Just the image without color overlay - use original SVG colors
    Image {
        id: archIcon
        anchors.centerIn: parent
        source: "file:///home/ianc/.config/quickshell/assets/arch-icon.svg"
        width: 24
        height: 24
        fillMode: Image.PreserveAspectFit
        smooth: true
        
        onStatusChanged: {
            if (status === Image.Error) {
                console.log("Failed to load Arch logo image, using fallback")
                fallbackText.visible = true
                visible = false
            }
        }
        
        // Hover effects
        states: State {
            name: "hovered"
            when: mouseArea.containsMouse
            PropertyChanges {
                target: archIcon
                scale: 1.1
            }
        }
        
        transitions: Transition {
            PropertyAnimation {
                properties: "scale"
                duration: 200
                easing.type: Easing.OutQuad
            }
        }
    }
    
    // Fallback text in case image doesn't load
    Text {
        id: fallbackText
        anchors.centerIn: parent
        text: "▲"
        color: "#4A4A4A"
        font.pixelSize: 24
        font.bold: true
        visible: false
    }
    
    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true
        
        onClicked: {
            // Launch wofi application launcher
            const wofiProcess = Qt.createQmlObject(`
                import Quickshell.Io
                Process {
                    command: ["wofi", "--show", "drun", "--allow-images"]
                    running: true
                }
            `, parent)
        }
    }
}
