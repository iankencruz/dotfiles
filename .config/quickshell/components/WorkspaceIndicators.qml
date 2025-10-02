import QtQuick
import Quickshell.Hyprland

// Background container for workspace indicators
Rectangle {
    width: 40  // Smaller width - less padding on sides
    height: 5 * 40 + 4 * 8 + 24  // Fixed height: 5 items × 40px + 4 gaps × 8px + 24px padding (12px top + 12px bottom)
    radius: 100
    color: Qt.rgba(0.24, 0.24, 0.24, 0.9)  // Light grey background - lighter than the bar
    border.color: Qt.rgba(0.85, 0.85, 0.85, 0.4)  // Subtle grey border
    border.width: 1
    
    Column {
        anchors.centerIn: parent
        anchors.topMargin: 12    // Add top padding
        anchors.bottomMargin: 12 // Add bottom padding
        spacing: 8
        
        property var workspaces: Hyprland.workspaces
        property int activeWorkspace: Hyprland.focusedWorkspace?.id ?? 1
        
        // Calculate which workspaces to show based on active workspace position
        property var workspaceIds: {
            if (activeWorkspace <= 4) {
                // Show workspaces 1-5, with active at its natural position
                return [1, 2, 3, 4, 5]
            } else {
                // Show active workspace at the 5th position, with 4 workspaces before it
                return [activeWorkspace - 4, activeWorkspace - 3, activeWorkspace - 2, activeWorkspace - 1, activeWorkspace]
            }
        }
        
        Repeater {
            model: 5  // Always show exactly 5 workspaces
            
            delegate: Item {
                width: 40
                height: 40
                
                property int workspaceId: parent.workspaceIds[index]
                property bool isActive: workspaceId === parent.activeWorkspace
                property bool hasWindows: {
                    for (let i = 0; i < parent.workspaces.length; i++) {
                        if (parent.workspaces[i].id === workspaceId) {
                            return parent.workspaces[i].windows.length > 0
                        }
                    }
                    return false
                }
                
                // Active workspace - tall pill shape with number
                Rectangle {
                    id: activeIndicator
                    anchors.centerIn: parent
                    width: 26
                    height: 40
                    radius: 13  // Full rounding for pill shape
                    visible: isActive
                    
                    color: Qt.rgba(0.15, 0.15, 0.15, 0.7)  // Dark grey/charcoal background matching the image
                    border.color: Qt.rgba(0.45, 0.45, 0.45, 0.9)  // Darker border for definition
                    border.width: 1
                    
                    Text {
                        anchors.centerIn: parent
                        text: workspaceId
                        color: "#FFFFFF"  // White text for contrast on dark background
                        font.pixelSize: 12
                        font.weight: Font.DemiBold
                        font.family: "SF Pro Display, Inter, system-ui, sans-serif"
                    }
                    
                    states: State {
                        name: "pressed"
                        when: mouseArea.pressed
                        PropertyChanges {
                            target: activeIndicator
                            scale: 0.95
                        }
                    }
                    
                    transitions: Transition {
                        PropertyAnimation {
                            properties: "scale"
                            duration: 100
                            easing.type: Easing.OutQuad
                        }
                    }
                }
                
                // Inactive workspace - small circular dot
                Rectangle {
                    id: inactiveIndicator
                    anchors.centerIn: parent
                    width: 12
                    height: 12
                    radius: 6  // Perfect circle
                    visible: !isActive
                    
                    color: {
                        if (hasWindows) return "#7A7A7A"  // Slightly darker for contrast on grey
                        return "#B8B8B8"  // Adjusted for grey background
                    }
                    
                    states: [
                        State {
                            name: "hovered"
                            when: mouseArea.containsMouse
                            PropertyChanges {
                                target: inactiveIndicator
                                color: hasWindows ? "#5A5A5A" : "#989898"
                                scale: 1.2
                            }
                        },
                        State {
                            name: "pressed"
                            when: mouseArea.pressed
                            PropertyChanges {
                                target: inactiveIndicator
                                scale: 0.8
                            }
                        }
                    ]
                    
                    transitions: Transition {
                        PropertyAnimation {
                            properties: "color,scale"
                            duration: 120
                            easing.type: Easing.OutQuad
                        }
                    }
                }
                
                MouseArea {
                    id: mouseArea
                    anchors.fill: parent
                    hoverEnabled: true
                    
                    onClicked: {
                        Hyprland.dispatch("workspace " + workspaceId)
                    }
                }
            }
        }
    }
}
