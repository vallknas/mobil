import QtQuick 2.12
import QtQuick.Controls 2.5

ApplicationWindow {

    id: mainWindow // если к объекту не планируется обращаться, можно без id

    signal signalMakeRequest();



    width: 640
    height: 480
    visible: true
    title: qsTr("Tabs")

    SwipeView {
        id: swipeView
        anchors.fill: parent
        currentIndex: tabBar.currentIndex

        Page1Form {
        }

        Page2Form {
        }

        Page3Form{
        }

        Page4Form{
        }
        Page5Form{
        }

    }

    footer: TabBar {
        id: tabBar
        currentIndex: swipeView.currentIndex

        TabButton {
            text: qsTr("Laba 1")
        }
        TabButton {
            text: qsTr("Laba 2")
        }
        TabButton {
            text: qsTr("Laba 3")
        }
        TabButton {
            text: qsTr("Laba 4")
        }
        TabButton {
            text: qsTr("Laba 5")
        }
    }
}
