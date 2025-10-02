import QtQuick
import Quickshell.Hyprland

Item {
    width: 50
    height: 40
    
    property var activeWindow: Hyprland.focusedWindow
    property string appName: {
        if (!activeWindow) return "Desktop"
        
        // Try different properties to get the app name
        let name = activeWindow.class || activeWindow.initialClass || activeWindow.title || "Unknown"
        
        // Clean up common app names
        if (name.toLowerCase().includes("firefox")) return "Firefox"
        if (name.toLowerCase().includes("ghostty")) return "Ghostty"
        if (name.toLowerCase().includes("terminal")) return "Terminal"
        if (name.toLowerCase().includes("code")) return "Code"
        if (name.toLowerCase().includes("chrome")) return "Chrome"
        
        // Return the raw name (capitalized)
        return name.charAt(0).toUpperCase() + name.slice(1)
    }
    
    // Force update when focused window changes
    Connections {
        target: Hyprland
        function onFocusedWindowChanged() {
            // Force property binding update
            activeWindow = Hyprland.focusedWindow
            console.log("Active window changed:", activeWindow ? activeWindow.class : "null")
        }
    }
    
    Text {
        anchors.centerIn: parent
        text: appName
        color: "#4A4A4A"
        font.pixelSize: 16
        font.weight: Font.Medium
        font.family: "SF Pro Display, Inter, system-ui, sans-serif"
        horizontalAlignment: Text.AlignHCenter
        
        // Rotate text vertically like in the image
        rotation: 90
        transformOrigin: Item.Center
        
        // Truncate if too long
        width: 200  // Height constraint when rotated
        elide: Text.ElideRight
    }
    
    // Debug info - remove after testing
    Text {
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        text: activeWindow ? activeWindow.class : "no window"
        color: "red"
        font.pixelSize: 8
        visible: true  // Set to false to hide debug info
    }
    
    // Optional hover effect
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        
        onContainsMouseChanged: {
            if (containsMouse) {
                parent.children[0].color = "#2A2A2A"
            } else {
                parent.children[0].color = "#4A4A4A"
            }
        }
        
        onClicked: {
            if (activeWindow) {
                console.log("Clicked on:", activeWindow.class, activeWindow.title)
                Hyprland.dispatch("focuswindow address:" + activeWindow.address)
            }
        }
    }
}
