pragma Singleton
import Quickshell
import QtQuick

Singleton {
    readonly property string hourString: Qt.formatDateTime(clock.date, "hh")
    readonly property string minuteString: Qt.formatDateTime(clock.date, "mm")
    readonly property string dayString: Qt.formatDateTime(clock.date, "dd")
    readonly property string monthString: Qt.formatDateTime(clock.date, "MM")
    
    SystemClock {
        id: clock
        precision: SystemClock.Minutes
    }
}
