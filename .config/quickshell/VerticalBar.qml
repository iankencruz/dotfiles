import Quickshell
import Quickshell.Hyprland
import QtQuick
import "./components"

Scope {
    Variants {
        model: Quickshell.screens
        
        PanelWindow {
            property var modelData
            screen: modelData
            
            anchors {
                left: true
                top: true
                bottom: true
            }
            
            width: 50
            exclusiveZone: 48
            
            color: Qt.rgba(0.1, 0.1, 0.1, 0.95)
            
            Column {
                anchors {
                    left: parent.left
                    top: parent.top
                    right: parent.right
                    margins: 12
                }
                spacing: 8 
                
                TopIndicator {
                    width: parent.width
                }
                
                WorkspaceIndicators {
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                
                Item {
                    width: parent.width
                    height: 16
                }
                
               
                
                Item {
                    width: parent.width
                    height: 12
                }
                
                ClockDisplay {
                    width: parent.width
                }
            }

            SystemIndicators {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    margins: 100
                }
                width: parent.width
            }
            
            // The BottomControls are now a direct child of PanelWindow
            BottomControls {
                anchors {
                    bottom: parent.bottom
                    horizontalCenter: parent.horizontalCenter
                    margins: 12
                }
                // The width should be explicitly defined or based on its content, not the Column's width
                width: parent.width - 24 // Example width, considering the 12 margin on each side
            }
        }
    }
}
